<?php
/**
 * Synchronize the back-office business profiles and their native QloApps permissions.
 *
 * This script is intentionally idempotent. It uses the existing profile/access/module_access
 * tables and does not modify booking, availability, price, tax, order, or status data.
 */

if (PHP_SAPI !== 'cli') {
    exit("This script must be run from the command line.\n");
}

require_once dirname(__DIR__).'/config/config.inc.php';

$roles = array(
    'reception' => array(
        'names' => array('fr' => 'Réception', 'en' => 'Reception'),
        'fallback' => 'Réception',
        'tabs' => array(
            'AdminDashboard' => array(1, 0, 0, 0, 1),
            'AdminSearch' => array(1, 0, 0, 0, 0),
            'AdminParentOrders' => array(1, 0, 0, 0, 0),
            'AdminOrders' => array(1, 1, 1, 0, 1),
            'AdminCustomers' => array(1, 1, 1, 0, 0),
            'AdminAddresses' => array(1, 1, 1, 0, 0),
            'AdminCarts' => array(1, 1, 1, 0, 0),
            'AdminCustomerThreads' => array(1, 1, 1, 0, 0),
            'AdminHotelReservationSystemManagement' => array(1, 0, 0, 0, 0),
            'AdminHotelRoomsBooking' => array(1, 1, 1, 0, 1),
            'AdminBookingDocument' => array(1, 0, 0, 0, 0),
        ),
    ),
    'manager' => array(
        'names' => array('fr' => 'Gérant', 'en' => 'Manager'),
        'fallback' => 'Gérant',
        'tabs' => array(
            'AdminDashboard' => array(1, 0, 0, 0, 1),
            'AdminStats' => array(1, 0, 0, 0, 1),
            'AdminSearch' => array(1, 0, 0, 0, 0),
            'AdminCatalog' => array(1, 0, 0, 0, 0),
            'AdminProducts' => array(1, 1, 1, 0, 1),
            'AdminNormalProducts' => array(1, 1, 1, 0, 0),
            'AdminCategories' => array(1, 1, 1, 0, 0),
            'AdminFeatures' => array(1, 1, 1, 0, 0),
            'AdminHotelBedTypes' => array(1, 1, 1, 0, 0),
            'AdminPriceRule' => array(1, 0, 0, 0, 0),
            'AdminCartRules' => array(1, 1, 1, 0, 0),
            'AdminSpecificPriceRule' => array(1, 1, 1, 0, 0),
            'AdminParentOrders' => array(1, 0, 0, 0, 0),
            'AdminOrders' => array(1, 1, 1, 0, 1),
            'AdminInvoices' => array(1, 0, 0, 0, 0),
            'AdminSlip' => array(1, 0, 0, 0, 0),
            'AdminCustomers' => array(1, 0, 1, 0, 0),
            'AdminAddresses' => array(1, 0, 1, 0, 0),
            'AdminHotelReservationSystemManagement' => array(1, 0, 0, 0, 0),
            'AdminAddHotel' => array(1, 1, 1, 0, 0),
            'AdminHotelRoomsBooking' => array(1, 1, 1, 0, 1),
            'AdminHotelFeatures' => array(1, 1, 1, 0, 0),
            'AdminOrderRefundRules' => array(1, 1, 1, 0, 0),
            'AdminOrderRefundRequests' => array(1, 0, 1, 0, 0),
            'AdminHotelConfigurationSetting' => array(1, 0, 0, 0, 0),
            'AdminHotelGeneralSettings' => array(1, 0, 1, 0, 0),
            'AdminHotelFeaturePricesSettings' => array(1, 1, 1, 0, 0),
            'AdminRoomTypeGlobalDemand' => array(1, 1, 1, 0, 0),
            'AdminBookingDocument' => array(1, 1, 1, 0, 0),
        ),
    ),
    'accountant' => array(
        'names' => array('fr' => 'Comptable', 'en' => 'Accountant'),
        'fallback' => 'Comptable',
        'tabs' => array(
            'AdminDashboard' => array(1, 0, 0, 0, 1),
            'AdminStats' => array(1, 0, 0, 0, 1),
            'AdminSearch' => array(1, 0, 0, 0, 0),
            'AdminParentOrders' => array(1, 0, 0, 0, 0),
            'AdminOrders' => array(1, 0, 1, 0, 1),
            'AdminInvoices' => array(1, 0, 1, 0, 0),
            'AdminPaymentReceipts' => array(1, 0, 1, 0, 0),
            'AdminSlip' => array(1, 0, 1, 0, 0),
            'AdminOrderRefundRequests' => array(1, 0, 1, 0, 0),
            'AdminBookingDocument' => array(1, 0, 0, 0, 0),
            'AdminParentModules' => array(1, 0, 0, 0, 0),
            'AdminPayment' => array(1, 0, 0, 0, 0),
        ),
    ),
    'admin' => array(
        'names' => array('fr' => 'Admin', 'en' => 'Admin'),
        'fallback' => 'Admin',
        'all_tabs' => true,
    ),
);

$db = Db::getInstance();
$languages = Language::getLanguages(false);
$profileIds = array();

ensureSuperAdminAccess($db);

foreach ($roles as $key => $role) {
    $profileIds[$key] = ensureProfile($db, $languages, $role);
    ensureAccessRows($db, $profileIds[$key]);
    ensureModuleAccessRows($db, $profileIds[$key]);
}

foreach ($roles as $key => $role) {
    $idProfile = (int)$profileIds[$key];

    if (!empty($role['all_tabs'])) {
        $db->execute('
            UPDATE `'._DB_PREFIX_.'access`
            SET `view` = 1, `add` = 1, `edit` = 1, `delete` = 1, `kpi` = 1
            WHERE `id_profile` = '.$idProfile
        );
        $db->execute('
            UPDATE `'._DB_PREFIX_.'module_access`
            SET `view` = 1, `configure` = 1, `uninstall` = 1
            WHERE `id_profile` = '.$idProfile
        );
        continue;
    }

    $db->execute('
        UPDATE `'._DB_PREFIX_.'access`
        SET `view` = 0, `add` = 0, `edit` = 0, `delete` = 0, `kpi` = 0
        WHERE `id_profile` = '.$idProfile
    );

    $tabIds = getTabIdsByClass($db);
    foreach ($role['tabs'] as $className => $permissions) {
        if (!isset($tabIds[$className])) {
            continue;
        }
        grantTab($db, $idProfile, (int)$tabIds[$className], $permissions);
    }

    $db->execute('
        UPDATE `'._DB_PREFIX_.'module_access`
        SET `view` = 0, `configure` = 0, `uninstall` = 0
        WHERE `id_profile` = '.$idProfile
    );
}

syncHotelAccess($db, $profileIds);

echo "Back-office roles synchronized:\n";
foreach ($profileIds as $key => $idProfile) {
    echo '- '.$key.' => profile #'.$idProfile."\n";
}

function ensureProfile(Db $db, array $languages, array $role)
{
    $names = array_values($role['names']);
    $escapedNames = array();
    foreach ($names as $name) {
        $escapedNames[] = "'".pSQL($name)."'";
    }

    $idProfile = (int)$db->getValue('
        SELECT p.`id_profile`
        FROM `'._DB_PREFIX_.'profile` p
        INNER JOIN `'._DB_PREFIX_.'profile_lang` pl ON p.`id_profile` = pl.`id_profile`
        WHERE pl.`name` IN ('.implode(',', $escapedNames).')
        ORDER BY p.`id_profile`
    ');

    if (!$idProfile) {
        $db->execute('INSERT INTO `'._DB_PREFIX_.'profile` () VALUES ()');
        $idProfile = (int)$db->Insert_ID();
    }

    foreach ($languages as $language) {
        $iso = $language['iso_code'];
        $name = isset($role['names'][$iso]) ? $role['names'][$iso] : $role['fallback'];
        $db->execute('
            REPLACE INTO `'._DB_PREFIX_.'profile_lang` (`id_profile`, `id_lang`, `name`)
            VALUES ('.$idProfile.', '.(int)$language['id_lang'].', \''.pSQL($name).'\')
        ');
    }

    return $idProfile;
}

function ensureSuperAdminAccess(Db $db)
{
    $adminProfile = (int)_PS_ADMIN_PROFILE_;
    $db->execute('
        INSERT IGNORE INTO `'._DB_PREFIX_.'access`
        (`id_profile`, `id_tab`, `view`, `add`, `edit`, `delete`, `kpi`)
        SELECT '.$adminProfile.', `id_tab`, 1, 1, 1, 1, 1
        FROM `'._DB_PREFIX_.'tab`
    ');

    $db->execute('
        UPDATE `'._DB_PREFIX_.'access`
        SET `view` = 1, `add` = 1, `edit` = 1, `delete` = 1, `kpi` = 1
        WHERE `id_profile` = '.$adminProfile
    );

    $db->execute('
        INSERT IGNORE INTO `'._DB_PREFIX_.'module_access`
        (`id_profile`, `id_module`, `view`, `configure`, `uninstall`)
        SELECT '.$adminProfile.', `id_module`, 1, 1, 1
        FROM `'._DB_PREFIX_.'module`
    ');

    $db->execute('
        UPDATE `'._DB_PREFIX_.'module_access`
        SET `view` = 1, `configure` = 1, `uninstall` = 1
        WHERE `id_profile` = '.$adminProfile
    );
}

function ensureAccessRows(Db $db, $idProfile)
{
    $db->execute('
        INSERT IGNORE INTO `'._DB_PREFIX_.'access`
        (`id_profile`, `id_tab`, `view`, `add`, `edit`, `delete`, `kpi`)
        SELECT '.(int)$idProfile.', `id_tab`, 0, 0, 0, 0, 0
        FROM `'._DB_PREFIX_.'tab`
    ');
}

function ensureModuleAccessRows(Db $db, $idProfile)
{
    $db->execute('
        INSERT IGNORE INTO `'._DB_PREFIX_.'module_access`
        (`id_profile`, `id_module`, `view`, `configure`, `uninstall`)
        SELECT '.(int)$idProfile.', `id_module`, 0, 0, 0
        FROM `'._DB_PREFIX_.'module`
    ');
}

function getTabIdsByClass(Db $db)
{
    $tabs = array();
    $rows = $db->executeS('SELECT `id_tab`, `class_name` FROM `'._DB_PREFIX_.'tab`');
    foreach ($rows as $row) {
        $tabs[$row['class_name']] = (int)$row['id_tab'];
    }
    return $tabs;
}

function grantTab(Db $db, $idProfile, $idTab, array $permissions)
{
    $db->execute('
        UPDATE `'._DB_PREFIX_.'access`
        SET
            `view` = '.(int)$permissions[0].',
            `add` = '.(int)$permissions[1].',
            `edit` = '.(int)$permissions[2].',
            `delete` = '.(int)$permissions[3].',
            `kpi` = '.(int)$permissions[4].'
        WHERE `id_profile` = '.(int)$idProfile.'
            AND `id_tab` = '.(int)$idTab
    );
}

function syncHotelAccess(Db $db, array $profileIds)
{
    $hasHotelAccess = (bool)$db->executeS("SHOW TABLES LIKE '"._DB_PREFIX_."htl_access'");
    $hasHotels = (bool)$db->executeS("SHOW TABLES LIKE '"._DB_PREFIX_."htl_branch_info'");
    if (!$hasHotelAccess || !$hasHotels) {
        echo "Hotel access table not available yet; skipped hotel-level access.\n";
        return;
    }

    foreach ($profileIds as $idProfile) {
        $db->execute('
            REPLACE INTO `'._DB_PREFIX_.'htl_access` (`id_profile`, `id_hotel`, `access`)
            SELECT '.(int)$idProfile.', `id`, 1
            FROM `'._DB_PREFIX_.'htl_branch_info`
        ');
    }
}
