{if $bookings|count}
    <div class="reception-list">
        {foreach from=$bookings item=booking}
            {if isset($status_map[$booking.id_status])}
                {assign var=status_label value=$status_map[$booking.id_status].label}
                {assign var=status_hint value=$status_map[$booking.id_status].hint}
                {assign var=status_class value=$status_map[$booking.id_status].class}
            {else}
                {assign var=status_label value='Statut inconnu'}
                {assign var=status_hint value=''}
                {assign var=status_class value='status-unknown'}
            {/if}
            <article class="reception-booking-card">
                <div class="reception-booking-main">
                    <div class="reception-booking-copy">
                        <div class="reception-guest">
                            {if $booking.firstname || $booking.lastname}
                                {$booking.firstname|escape:'html':'UTF-8'} {$booking.lastname|escape:'html':'UTF-8'}
                            {else}
                                {l s='Client non lié'}
                            {/if}
                        </div>
                        <div class="reception-meta">
                            <span class="reception-order">#{intval($booking.id_order)}</span>
                            <span class="reception-room-pill">{l s='Chambre'} {$booking.room_num|escape:'html':'UTF-8'}</span>
                            <span>{$booking.room_type_name|escape:'html':'UTF-8'}</span>
                        </div>
                        <div class="reception-stay-line">
                            {$booking.hotel_name|escape:'html':'UTF-8'} - {dateFormat date=$booking.date_from} -> {dateFormat date=$booking.date_to}
                        </div>
                    </div>
                    <span class="reception-status {$status_class|escape:'html':'UTF-8'}" title="{$status_hint|escape:'html':'UTF-8'}">
                        {$status_label|escape:'html':'UTF-8'}
                    </span>
                </div>
                <div class="reception-actions">
                    <a class="btn btn-default btn-sm" href="{$booking.order_url|escape:'html':'UTF-8'}">
                        <i class="icon-eye-open"></i> {l s='Voir'}
                    </a>
                    {if isset($action_hint) && $action_hint == 'checkin' && $booking.id_status == $status_alloted}
                        <a class="btn btn-success btn-sm" href="{$booking.order_url|escape:'html':'UTF-8'}" data-confirm="{l s='Ouvrir cette réservation pour confirmer l&#039;enregistrement ?'}">
                            <i class="icon-sign-in"></i> {l s='Enregistrer'}
                        </a>
                    {/if}
                    {if isset($action_hint) && $action_hint == 'checkout' && $booking.id_status == $status_checked_in}
                        <a class="btn btn-warning btn-sm" href="{$booking.order_url|escape:'html':'UTF-8'}" data-confirm="{l s='Ouvrir cette réservation pour confirmer le départ ?'}">
                            <i class="icon-sign-out"></i> {l s='Départ'}
                        </a>
                    {/if}
                </div>
            </article>
        {/foreach}
    </div>
{else}
    <div class="reception-empty">{$empty_label|escape:'html':'UTF-8'}</div>
{/if}
