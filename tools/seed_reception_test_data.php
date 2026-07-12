<?php
/**
 * Seed a larger local dataset for reception/back-office testing.
 *
 * This script clones existing valid QloApps orders/bookings instead of creating
 * business records from scratch. It keeps the existing business logic untouched
 * and only adds test data to the local database.
 */

require_once dirname(__DIR__).'/config/config.inc.php';

if (!defined('_PS_VERSION_')) {
    die("QloApps bootstrap failed.\n");
}

$db = Db::getInstance();
$now = new DateTime('2026-07-11 10:00:00');
$batch = 'Codex reception seed '.date('YmdHis');

function seed_table($table)
{
    return _DB_PREFIX_.$table;
}

function seed_sql_value($value)
{
    if ($value === null) {
        return 'NULL';
    }

    return "'".pSQL((string) $value, true)."'";
}

function seed_columns($table)
{
    static $cache = array();

    if (!isset($cache[$table])) {
        $rows = Db::getInstance()->executeS('SHOW COLUMNS FROM `'.bqSQL(seed_table($table)).'`');
        $cache[$table] = array();
        foreach ($rows as $row) {
            $cache[$table][$row['Field']] = $row;
        }
    }

    return $cache[$table];
}

function seed_row($table, $where)
{
    return Db::getInstance()->getRow('SELECT * FROM `'.bqSQL(seed_table($table)).'` WHERE '.$where);
}

function seed_rows($table, $where)
{
    return Db::getInstance()->executeS('SELECT * FROM `'.bqSQL(seed_table($table)).'` WHERE '.$where);
}

function seed_insert($table, array $data)
{
    $columns = seed_columns($table);
    $fields = array();
    $values = array();

    foreach ($columns as $field => $meta) {
        if (strpos($meta['Extra'], 'auto_increment') !== false) {
            continue;
        }
        if (!array_key_exists($field, $data)) {
            continue;
        }

        $fields[] = '`'.bqSQL($field).'`';
        $values[] = seed_sql_value($data[$field]);
    }

    $sql = 'INSERT INTO `'.bqSQL(seed_table($table)).'` ('.implode(',', $fields).') VALUES ('.implode(',', $values).')';
    if (!Db::getInstance()->execute($sql)) {
        throw new RuntimeException('Insert failed for '.$table.': '.Db::getInstance()->getMsgError());
    }

    return (int) Db::getInstance()->Insert_ID();
}

function seed_clone($table, array $base, array $changes = array())
{
    foreach (seed_columns($table) as $field => $meta) {
        if (strpos($meta['Extra'], 'auto_increment') !== false) {
            unset($base[$field]);
        }
    }

    return seed_insert($table, array_merge($base, $changes));
}

function seed_reference()
{
    do {
        $reference = '';
        for ($i = 0; $i < 9; $i++) {
            $reference .= chr(mt_rand(65, 90));
        }
        $exists = (int) Db::getInstance()->getValue(
            'SELECT COUNT(*) FROM `'.bqSQL(seed_table('orders'))."` WHERE reference = '".pSQL($reference)."'"
        );
    } while ($exists);

    return $reference;
}

function seed_money($value)
{
    return number_format((float) $value, 6, '.', '');
}

function seed_datetime(DateTime $date, $time = '00:00:00')
{
    return $date->format('Y-m-d').' '.$time;
}

function seed_room_has_overlap($idRoom, DateTime $dateFrom, DateTime $dateTo)
{
    return (bool) Db::getInstance()->getValue(
        'SELECT COUNT(*) FROM `'.bqSQL(seed_table('htl_booking_detail')).'`
        WHERE id_room = '.(int) $idRoom.'
            AND is_cancelled = 0
            AND date_from < \''.pSQL(seed_datetime($dateTo)).'\'
            AND \''.pSQL(seed_datetime($dateFrom)).'\' < date_to'
    );
}

function seed_pick_room(array $rooms, DateTime $dateFrom, DateTime $dateTo, $startIndex)
{
    $count = count($rooms);
    for ($offset = 0; $offset < $count; $offset++) {
        $room = $rooms[($startIndex + $offset) % $count];
        if (!seed_room_has_overlap((int) $room['id'], $dateFrom, $dateTo)) {
            return $room;
        }
    }

    return $rooms[$startIndex % $count];
}

$baseBookings = Db::getInstance()->executeS(
    'SELECT * FROM `'.bqSQL(seed_table('htl_booking_detail')).'` ORDER BY id'
);

if (!$baseBookings) {
    die("Aucune réservation existante trouvée. Créez d'abord une réservation de référence.\n");
}

$roomsByProduct = array();
foreach (Db::getInstance()->executeS('SELECT * FROM `'.bqSQL(seed_table('htl_room_information')).'` ORDER BY id_product, id') as $room) {
    $roomsByProduct[(int) $room['id_product']][] = $room;
}

$names = array(
    array('Aminata', 'Diallo', '771112233'),
    array('Mamadou', 'Ndiaye', '772223344'),
    array('Fatou', 'Sow', '773334455'),
    array('Ibrahima', 'Ba', '774445566'),
    array('Awa', 'Diop', '775556677'),
    array('Cheikh', 'Fall', '776667788'),
    array('Mariama', 'Gueye', '777778899'),
    array('Abdoulaye', 'Sarr', '778889900'),
    array('Ndeye', 'Faye', '779990011'),
    array('Oumar', 'Kane', '770101112'),
    array('Khady', 'Mbaye', '770202223'),
    array('Pape', 'Seck', '770303334'),
);

$offsets = array(-12, -10, -8, -6, -4, -2, -1, 0, 0, 1, 1, 2, 3, 5, 7, 10, 14, 18);
$states = array(2, 8, 1, 2, 2, 8);
$bookingStatuses = array(3, 3, 2, 2, 1, 1, 2, 1, 2, 1);
$created = array('customers' => 0, 'orders' => 0, 'bookings' => 0, 'invoices' => 0, 'payments' => 0);
$roomCounters = array();
$invoiceNumber = (int) Db::getInstance()->getValue('SELECT COALESCE(MAX(number), 0) FROM `'.bqSQL(seed_table('order_invoice')).'`');

for ($i = 0; $i < 48; $i++) {
    $templateBooking = $baseBookings[$i % count($baseBookings)];
    $templateOrder = seed_row('orders', 'id_order = '.(int) $templateBooking['id_order']);
    $templateCustomer = seed_row('customer', 'id_customer = '.(int) $templateBooking['id_customer']);
    $templateCart = seed_row('cart', 'id_cart = '.(int) $templateOrder['id_cart']);

    if (!$templateOrder || !$templateCustomer || !$templateCart) {
        continue;
    }

    $name = $names[$i % count($names)];
    $dateFrom = clone $now;
    $dateFrom->modify(($offsets[$i % count($offsets)] + (int) floor($i / count($offsets)) * 3).' days');
    $nights = 1 + ($i % 4);
    $dateTo = clone $dateFrom;
    $dateTo->modify('+'.$nights.' days');
    $orderDate = clone $dateFrom;
    $orderDate->modify('-'.(2 + ($i % 9)).' days');

    $idProduct = (int) $templateBooking['id_product'];
    if (empty($roomsByProduct[$idProduct])) {
        continue;
    }
    if (!isset($roomCounters[$idProduct])) {
        $roomCounters[$idProduct] = 0;
    }
    $room = seed_pick_room($roomsByProduct[$idProduct], $dateFrom, $dateTo, $roomCounters[$idProduct]);
    $roomCounters[$idProduct]++;

    $orderState = $states[$i % count($states)];
    $bookingStatus = $bookingStatuses[$i % count($bookingStatuses)];
    $reference = seed_reference();
    $secureKey = md5($reference.microtime(true).mt_rand());
    $email = strtolower($name[0].'.'.$name[1].'.'.($i + 1).'.'.date('His')).'@seed.reception.local';

    $idCustomer = seed_clone('customer', $templateCustomer, array(
        'firstname' => $name[0],
        'lastname' => $name[1],
        'email' => $email,
        'secure_key' => $secureKey,
        'note' => $batch,
        'phone' => $name[2],
        'active' => 1,
        'deleted' => 0,
        'date_add' => seed_datetime($orderDate),
        'date_upd' => seed_datetime($orderDate),
    ));
    $created['customers']++;

    $idCart = seed_clone('cart', $templateCart, array(
        'id_customer' => $idCustomer,
        'secure_key' => $secureKey,
        'date_add' => seed_datetime($orderDate),
        'date_upd' => seed_datetime($orderDate),
    ));

    foreach (seed_rows('cart_product', 'id_cart = '.(int) $templateCart['id_cart']) as $cartProduct) {
        seed_insert('cart_product', array_merge($cartProduct, array(
            'id_cart' => $idCart,
            'date_add' => seed_datetime($orderDate),
        )));
    }

    $idOrder = seed_clone('orders', $templateOrder, array(
        'reference' => $reference,
        'id_customer' => $idCustomer,
        'id_cart' => $idCart,
        'current_state' => $orderState,
        'secure_key' => $secureKey,
        'source' => $batch,
        'valid' => $orderState == 2 ? 1 : 0,
        'invoice_number' => 0,
        'delivery_number' => 0,
        'invoice_date' => '0000-00-00 00:00:00',
        'delivery_date' => '0000-00-00 00:00:00',
        'date_add' => seed_datetime($orderDate),
        'date_upd' => seed_datetime($orderDate),
    ));
    $created['orders']++;

    $detailMap = array();
    foreach (seed_rows('order_detail', 'id_order = '.(int) $templateOrder['id_order'].' ORDER BY id_order_detail') as $orderDetail) {
        $oldDetailId = (int) $orderDetail['id_order_detail'];
        $detailMap[$oldDetailId] = seed_clone('order_detail', $orderDetail, array(
            'id_order' => $idOrder,
            'id_order_invoice' => 0,
        ));

        foreach (seed_rows('order_detail_tax', 'id_order_detail = '.$oldDetailId) as $tax) {
            seed_insert('order_detail_tax', array_merge($tax, array(
                'id_order_detail' => $detailMap[$oldDetailId],
            )));
        }
    }

    $newInvoiceId = 0;
    if ($orderState != 1) {
        $templateInvoice = seed_row('order_invoice', 'id_order = '.(int) $templateOrder['id_order']);
        if ($templateInvoice) {
            $invoiceNumber++;
            $newInvoiceId = seed_clone('order_invoice', $templateInvoice, array(
                'id_order' => $idOrder,
                'number' => $invoiceNumber,
                'delivery_number' => 0,
                'delivery_date' => null,
                'note' => $batch,
                'date_add' => seed_datetime($orderDate),
            ));
            $created['invoices']++;

            Db::getInstance()->execute(
                'UPDATE `'.bqSQL(seed_table('order_detail')).'` SET id_order_invoice = '.(int) $newInvoiceId.' WHERE id_order = '.(int) $idOrder
            );
            Db::getInstance()->execute(
                'UPDATE `'.bqSQL(seed_table('orders')).'` SET invoice_number = '.(int) $invoiceNumber.", invoice_date = '".pSQL(seed_datetime($orderDate))."' WHERE id_order = ".(int) $idOrder
            );
        }
    }

    $newPaymentId = 0;
    $newPaymentDetailId = 0;
    if ($orderState != 1) {
        $templatePayment = seed_row('order_payment', "order_reference = '".pSQL($templateOrder['reference'])."'");
        if ($templatePayment) {
            $amount = (float) $templateOrder['total_paid'];
            if ($orderState == 8) {
                $amount = round($amount * 0.5, 2);
            }

            $newPaymentId = seed_clone('order_payment', $templatePayment, array(
                'order_reference' => $reference,
                'amount' => number_format($amount, 2, '.', ''),
                'payment_method' => $i % 2 ? 'Paiement par carte' : 'Virement bancaire',
                'transaction_id' => 'SEED-'.$reference,
                'date_add' => seed_datetime($orderDate),
            ));
            $created['payments']++;

            $templatePaymentDetail = seed_row('order_payment_detail', 'id_order = '.(int) $templateOrder['id_order']);
            if ($templatePaymentDetail) {
                $newPaymentDetailId = seed_clone('order_payment_detail', $templatePaymentDetail, array(
                    'id_order' => $idOrder,
                    'id_order_payment' => $newPaymentId,
                    'amount' => number_format($amount, 2, '.', ''),
                ));
            }

            if ($newInvoiceId && $newPaymentDetailId) {
                seed_insert('order_invoice_payment', array(
                    'id_order_invoice' => $newInvoiceId,
                    'id_order_payment' => $newPaymentId,
                    'id_order_payment_detail' => $newPaymentDetailId,
                    'id_order' => $idOrder,
                ));
            }
        }
    }

    $templateHistory = seed_row('order_history', 'id_order = '.(int) $templateOrder['id_order'].' ORDER BY id_order_history DESC');
    if ($templateHistory) {
        seed_clone('order_history', $templateHistory, array(
            'id_order' => $idOrder,
            'id_order_state' => $orderState,
            'date_add' => seed_datetime($orderDate),
        ));
    }

    foreach (seed_rows('htl_cart_booking_data', 'id_cart = '.(int) $templateOrder['id_cart'].' AND id_product = '.$idProduct) as $cartBooking) {
        seed_clone('htl_cart_booking_data', $cartBooking, array(
            'id_cart' => $idCart,
            'id_order' => $idOrder,
            'id_customer' => $idCustomer,
            'id_room' => (int) $room['id'],
            'date_from' => seed_datetime($dateFrom),
            'date_to' => seed_datetime($dateTo),
            'adults' => 1 + ($i % 3),
            'children' => $i % 4 == 0 ? 1 : 0,
            'child_ages' => $i % 4 == 0 ? '8' : '',
            'date_add' => seed_datetime($orderDate),
            'date_upd' => seed_datetime($orderDate),
        ));
    }

    $checkIn = '0000-00-00 00:00:00';
    $checkOut = '0000-00-00 00:00:00';
    if ($bookingStatus >= 2) {
        $checkIn = seed_datetime($dateFrom, '12:00:00');
    }
    if ($bookingStatus >= 3) {
        $checkOut = seed_datetime($dateTo, '11:00:00');
    }

    $paidAmount = '0.000000';
    if ($orderState == 2) {
        $paidAmount = seed_money($templateBooking['total_price_tax_incl']);
    } elseif ($orderState == 8) {
        $paidAmount = seed_money(((float) $templateBooking['total_price_tax_incl']) * 0.5);
    }

    seed_clone('htl_booking_detail', $templateBooking, array(
        'id_order' => $idOrder,
        'id_order_detail' => isset($detailMap[(int) $templateBooking['id_order_detail']]) ? $detailMap[(int) $templateBooking['id_order_detail']] : 0,
        'id_cart' => $idCart,
        'id_room' => (int) $room['id'],
        'id_customer' => $idCustomer,
        'id_status' => $bookingStatus,
        'comment' => $batch,
        'check_in' => $checkIn,
        'check_out' => $checkOut,
        'planned_check_out' => seed_datetime($dateTo, '11:00:00'),
        'date_from' => seed_datetime($dateFrom),
        'date_to' => seed_datetime($dateTo),
        'total_paid_amount' => $paidAmount,
        'room_num' => $room['room_num'],
        'adults' => 1 + ($i % 3),
        'children' => $i % 4 == 0 ? 1 : 0,
        'child_ages' => $i % 4 == 0 ? '8' : '',
        'email' => $email,
        'date_add' => seed_datetime($orderDate),
        'date_upd' => seed_datetime($orderDate),
    ));
    $created['bookings']++;
}

echo "Lot cree: ".$batch."\n";
echo "Clients: ".$created['customers']."\n";
echo "Commandes: ".$created['orders']."\n";
echo "Reservations: ".$created['bookings']."\n";
echo "Factures: ".$created['invoices']."\n";
echo "Paiements: ".$created['payments']."\n";
