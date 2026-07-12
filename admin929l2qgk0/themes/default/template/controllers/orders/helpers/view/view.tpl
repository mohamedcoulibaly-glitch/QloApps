{*
* 2007-2017 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author PrestaShop SA <contact@prestashop.com>
*  @copyright  2007-2017 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}

{extends file="helpers/view/view.tpl"}
{extends file="page_header_toolbar.tpl"}
{block name=pageTitle}
    <h2 class="order_page_title page-title">
        {if is_array($title)}{$title|end|strip_tags}{else}{$title|strip_tags}{/if}
        {if $currentState->id == Configuration::get('PS_OS_REFUND')}
            <span class="toolbar_order_status_badge badge badge-danger">{l s='Remboursé'}</span>
        {elseif $currentState->id == Configuration::get('PS_OS_CANCELED')}
            <span class="toolbar_order_status_badge badge badge-danger">{l s='Annulé'}</span>
        {else}
            <span class="toolbar_order_status_badge badge badge-success">{l s='Réservé'}</span>
        {/if}
    </h2>
{/block}

{block name="override_tpl"}
	<script type="text/javascript">
	var admin_order_tab_link = "{$link->getAdminLink('AdminOrders')|addslashes}";
    var rooms_reallocation_url = "{$link->getAdminLink('AdminOrders')|addslashes}";
	var id_order = {$order->id};
	var id_lang = {$current_id_lang};
	var id_currency = {$order->id_currency};
	var id_customer = {$order->id_customer|intval};
	{assign var=PS_TAX_ADDRESS_TYPE value=Configuration::get('PS_TAX_ADDRESS_TYPE')}
	var id_address = {$order->$PS_TAX_ADDRESS_TYPE};
	var currency_sign = "{$currency->sign}";
	var currency_format = "{$currency->format}";
	var currency_blank = "{$currency->blank}";
	var priceDisplayPrecision = {$smarty.const._PS_PRICE_DISPLAY_PRECISION_|intval};
	var use_taxes = {if $order->getTaxCalculationMethod() == $smarty.const.PS_TAX_INC}true{else}false{/if};
	var stock_management = {$stock_management|intval};
	var txt_add_product_stock_issue = "{l s='Êtes-vous sûr de vouloir ajouter cette quantité ?' js=1}";
	var txt_add_product_new_invoice = "{l s='Êtes-vous sûr de vouloir créer une nouvelle facture ?' js=1}";
	var txt_add_product_no_product = "{l s='Erreur : Aucun produit sélectionné' js=1}";
	var txt_add_product_no_product_quantity = "{l s='Erreur : La quantité du produit doit être définie' js=1}";
	var txt_add_product_no_product_price = "{l s='Erreur : Le prix du produit doit être défini' js=1}";
	var txt_confirm = "{l s='Êtes-vous sûr ?' js=1}";
	var statesShipped = new Array();
	var has_voucher = {if count($discounts)}1{else}0{/if};
    var allowBackdateOrder = {if $allowBackdateOrder}{$allowBackdateOrder}{else}false{/if};
	{foreach from=$states item=state}
		{if (isset($currentState->shipped) && !$currentState->shipped && $state['shipped'])}
			statesShipped.push({$state['id_order_state']});
		{/if}
	{/foreach}
	var order_discount_price = {if ($order->getTaxCalculationMethod() == $smarty.const.PS_TAX_EXC)}
									{$order->total_discounts_tax_excl}
								{else}
									{$order->total_discounts_tax_incl}
								{/if};

	var errorRefund = "{l s='Erreur. Vous ne pouvez pas rembourser un montant négatif.'}";
	</script>

	{assign var="hook_invoice" value={hook h="displayInvoice" id_order=$order->id}}
	{if ($hook_invoice)}
	<div>{$hook_invoice}</div>
	{/if}

    <div id="order_detail_view"{if isset($is_reception_profile) && $is_reception_profile} class="reception-order-view"{/if}>
        {* Overbookings information of the order *}
        {include file='controllers/orders/_overbookings.tpl'}

        <div class="row">
            <div class="col-lg-7">
                {if isset($htl_booking_order_data) && $htl_booking_order_data}
                    <div class="panel">
                        <div class="panel-heading order_status_heading">
                            <i class="icon-bed"></i> &nbsp;{l s='Statut de la chambre'}
                        </div>
                        <div class="panel-content">
                            <div class="row">
                                <div class="col-lg-12 table-responsive" id="room_status_info_wrapper">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>{l s='Chambre'}</th>
                                                <th>{l s='Séjour'}</th>
                                                <th>{l s='Arrivée'}</th>
                                                <th>{l s='Départ'}</th>
                                                <th>{l s='Attribution'}</th>
                                                <th>{l s='Action'}</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            {if isset($htl_booking_order_data) && $htl_booking_order_data}
                                                {foreach from=$htl_booking_order_data item=data}
                                                    <tr>
                                                        <td>
                                                            {$data['room_num']}<br>
                                                            <a href="{$link->getAdminLink('AdminProducts')|escape:'html':'UTF-8'}&amp;id_product={$data['id_product']}&amp;updateproduct" target="_blank">{$data['room_type_name']|escape:'html':'UTF-8'}</a>
                                                        </td>
                                                        <td>
                                                            {assign var="is_full_date" value=($show_full_date && ($data['date_from']|date_format:'%D' == $data['date_to']|date_format:'%D'))}
                                                            {dateFormat date=$data['date_from'] full=$is_full_date} - {dateFormat date=$data['date_to'] full=$is_full_date}
                                                        </td>
                                                        <td>
                                                            {if ($data['id_status'] == $hotel_order_status['STATUS_CHECKED_IN']['id_status']) || ($data['id_status'] == $hotel_order_status['STATUS_CHECKED_OUT']['id_status'])}
                                                                <span class="text-danger room_status">{l s='Arrivée enregistrée le'}<br>{dateFormat date=$data['check_in'] full=1}</span>
                                                            {else}
                                                                --
                                                            {/if}
                                                        </td>
                                                        <td>
                                                            {if $data['id_status'] == $hotel_order_status['STATUS_CHECKED_OUT']['id_status']}
                                                                <span class="text-success room_status">{l s='Départ validé le'}<br>{dateFormat date=$data['check_out'] full=1}</span>
                                                            {else}
                                                                --
                                                            {/if}
                                                        </td>
                                                        <td>
                                                            {if $data['booking_type'] == $ALLOTMENT_MANUAL}
                                                                {l s='Manuelle'} &nbsp;{if $data['comment'] != ''}<a class="manual_allotment_comment" href="#" data-id_hotel_booking_detail="{$data['id']}"><i class="icon-info-circle"></i></a>{/if}
                                                            {else}
                                                                {l s='Auto'}
                                                            {/if}
                                                        </td>
                                                        <td>
                                                            <a title="{l s='Voir les documents client'}" class="btn btn-default" href="#" onclick="BookingDocumentsModal.init({$data.id|intval}, this); return false;">
                                                                <span class="badge badge-info">{if $data.num_checkin_documents > 0}{$data.num_checkin_documents}{else}0{/if}</span> <i class="icon-file-text"></i>
                                                            </a>

                                                            {if isset($refundReqBookings) && $refundReqBookings && $data.id|in_array:$refundReqBookings && $data.is_refunded}
                                                                <span class="badge badge-danger">{if $data.is_cancelled}{l s='Annulé'}{else}{l s='Remboursé'}{/if}</span>
                                                            {elseif $can_edit}
                                                                <a class="open_room_status_form btn btn-default" href="#" data-id_hotel_booking_detail="{$data['id']}" data-id_order="{$data['id_order']}" data-id_status="{$data['id_status']}" data-id_room="{$data['id_room']}" data-date_from="{$data['date_from']|date_format:"%Y-%m-%d"}" data-date_to="{$data['date_to']|date_format:"%Y-%m-%d"}" data-check_in_time="{$data['check_in_time']}" data-check_out_time="{$data['check_out_time']}">
                                                                    <i class="icon-pencil"></i> {l s='Corriger'}
                                                                </a>
                                                            {/if}
                                                        </td>
                                                    </tr>
                                                {/foreach}
                                            {else}
                                                <tr>
                                                    <td class="list-empty hidden-print" colspan="6">
                                                        <div class="list-empty-msg">
                                                            <i class="icon-warning-sign list-empty-icon"></i>
                                                            {l s='Aucune chambre trouvée'}
                                                        </div>
                                                    </td>
                                                </tr>
                                            {/if}
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                {/if}
                <div class="panel">
                    <div class="panel-heading">
                        <i class="icon-file"></i> &nbsp;{l s='Séjour'}
                        <span class="badge">{$order->reference}</span>
                        <span class="badge">{l s="#"}{$order->id}</span>
                        <div class="panel-heading-action">
                            <div class="btn-group">
                                <a class="btn btn-default{if !$previousOrder} disabled{/if}" href="{$link->getAdminLink('AdminOrders')|escape:'html':'UTF-8'}&amp;vieworder&amp;id_order={$previousOrder|intval}">
                                    <i class="icon-backward"></i>
                                </a>
                                <a class="btn btn-default{if !$nextOrder} disabled{/if}" href="{$link->getAdminLink('AdminOrders')|escape:'html':'UTF-8'}&amp;vieworder&amp;id_order={$nextOrder|intval}">
                                    <i class="icon-forward"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                    <!-- Tab nav -->
                    <ul class="nav nav-tabs" id="tabOrder">
                        {$HOOK_TAB_ORDER}
                        <li class="active">
                            <a  href="#status">
                                <i class="icon-time"></i>
{l s='Statut'} <span class="badge">{$history|@count}</span>
                            </a>
                        </li>
                        <li>
                            <a  href="#documents">
                                <i class="icon-file-text"></i>
                                {l s='Documents'} <span class="badge">{$order->getDocuments()|@count}</span>
                            </a>
                        </li>
                    </ul>
                    <!-- Tab content -->
                    <div class="tab-content panel">
                        {$HOOK_CONTENT_ORDER}
                        <!-- Tab status -->
                        <div class="tab-pane active" id="status">
                            <h4 class="visible-print">{l s='Statut'} <span class="badge">({$history|@count})</span></h4>
                            <!-- History of status -->
                            <div class="table-responsive">
                                <table class="table history-status row-margin-bottom">
                                    <tbody>
                                        {foreach from=$history item=row key=key}
                                            {if ($key == 0)}
                                                <tr>
                                                    <td style="background-color:{$row['color']}"><img src="{$link->getMediaLink("`$img_dir`os/`$row['id_order_state']|intval`.gif")}" width="16" height="16" alt="{if !empty($row['ostate_name'])}{$row['ostate_name']|stripslashes}{/if}" /></td> {* by webkul to get media link *}
                                                    <td style="background-color:{$row['color']};color:{$row['text-color']}">{if !empty($row['ostate_name'])}{$row['ostate_name']|stripslashes}{/if}</td>
                                                    <td style="background-color:{$row['color']};color:{$row['text-color']}">{if $row['employee_lastname']}{$row['employee_firstname']|stripslashes} {$row['employee_lastname']|stripslashes}{/if}</td>
                                                    <td style="background-color:{$row['color']};color:{$row['text-color']}">{dateFormat date=$row['date_add'] full=true}</td>

                                                    {if $can_edit}
                                                        <td style="background-color:{$row['color']};color:{$row['text-color']}" class="text-right">
                                                            {if $row['send_email']|intval}
                                                                <a class="btn btn-default" href="{$link->getAdminLink('AdminOrders')|escape:'html':'UTF-8'}&amp;vieworder&amp;id_order={$order->id|intval}&amp;sendStateEmail={$row['id_order_state']|intval}&amp;id_order_history={$row['id_order_history']|intval}" title="{l s='Renvoyer cet email au client'}">
                                                                    <i class="icon-mail-reply"></i>
                                                                    {l s="Renvoyer l'email"}
                                                                </a>
                                                            {/if}
                                                        </td>
                                                    {/if}
                                                </tr>
                                            {else}
                                                <tr>
                                                    <td><img src="{$link->getMediaLink("`$img_dir`os/`$row['id_order_state']|intval`.gif")}" width="16" height="16" /></td>
                                                    <td>{if !empty($row['ostate_name'])}{$row['ostate_name']|stripslashes}{/if}</td>
                                                    <td>{if $row['employee_lastname']}{$row['employee_firstname']|stripslashes} {$row['employee_lastname']|stripslashes}{else}&nbsp;{/if}</td>
                                                    <td>{dateFormat date=$row['date_add'] full=true}</td>
                                                    {if $can_edit}
                                                        <td class="text-right">
                                                            {if $row['send_email']|intval}
                                                                <a  href="{$link->getAdminLink('AdminOrders')|escape:'html':'UTF-8'}&amp;vieworder&amp;id_order={$order->id|intval}&amp;sendStateEmail={$row['id_order_state']|intval}&amp;id_order_history={$row['id_order_history']|intval}" title="{l s='Renvoyer cet email au client'}">
                                                                    <i class="icon-mail-reply"></i>
                                                                    {l s="Renvoyer l'email"}
                                                                </a>
                                                            {/if}
                                                        </td>
                                                    {/if}
                                                </tr>
                                            {/if}
                                        {/foreach}
                                    </tbody>
                                </table>
                            </div>
                            <!-- Change status form -->
                            {* If current state is refunded or cancelled the further order status changes are not allowed *}
                            {if $can_edit && (!isset($currentState) || (isset($currentState) && ($currentState->id != Configuration::get('PS_OS_REFUND') && $currentState->id != Configuration::get('PS_OS_CANCELED'))))}
                                <form action="{$currentIndex|escape:'html':'UTF-8'}&amp;vieworder&amp;id_order={$order->id|intval}&amp;token={$smarty.get.token}" method="post" class="form-horizontal well hidden-print">
                                    <div class="row">
                                        <div class="col-lg-9">
                                            <select id="id_order_state" class="chosen form-control" name="id_order_state">
                                                {foreach from=$states item=state}
                                                    <option value="{$state['id_order_state']|intval}"{if isset($currentState) && $state['id_order_state'] == $currentState->id} selected="selected" disabled="disabled"{elseif ($state['id_order_state'] == Configuration::get('PS_OS_REFUND') && ($total_paid <= 0 && !$discounts|count))} disabled="disabled"{elseif ($state['id_order_state'] == Configuration::get('PS_OS_CANCELED') && ($totalRefundedRooms || $discounts|count || $total_paid > 0))} disabled="disabled"{elseif ($state['id_order_state'] == Configuration::get('PS_OS_OVERBOOKING_PAID') || $state['id_order_state'] == Configuration::get('PS_OS_OVERBOOKING_UNPAID') || $state['id_order_state'] == Configuration::get('PS_OS_OVERBOOKING_PARTIAL_PAID')) && (!isset($orderOverBookings) || !$orderOverBookings)} disabled="disabled"{/if}>{$state['name']|escape}</option>
                                                {/foreach}
                                            </select>
                                            <input type="hidden" name="id_order" value="{$order->id}" />
                                        </div>
                                        <div class="col-lg-3">
                                            <button type="submit" name="submitState" class="btn btn-primary">
                                                {l s='Mettre à jour le statut'}
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            {/if}
                        </div>
                        <!-- Tab documents -->
                        <div class="tab-pane" id="documents">
                            <h4 class="visible-print">{l s='Documents'} <span class="badge">({$order->getDocuments()|@count})</span></h4>
                            {* Include document template *}
                            {include file='controllers/orders/_documents.tpl'}
                        </div>
                    </div>
                    <script>
                        $('#tabOrder a').click(function (e) {
                            e.preventDefault()
                            $(this).tab('show')
                        })
                    </script>
                    <hr />
                    <!-- Tab nav -->
                    {* <!-- commented by qlo -->
                    <ul class="nav nav-tabs" id="myTab" style="display:none"><!-- by webkul -->
                        {$HOOK_TAB_SHIP}
                        <li class="active">
                            <a href="#shipping">
                                <i class="icon-truck "></i>
                                {l s='Livraison'} <span class="badge">{$order->getShipping()|@count}</span>
                            </a>
                        </li>
                        <li>
                            <a href="#returns">
                                <i class="icon-undo"></i>
                                {l s='Retours de marchandises'} <span class="badge">{$order->getReturn()|@count}</span>
                            </a>
                        </li>
                    </ul>
                    <!-- Tab content -->
                    <div class="tab-content panel" style="display:none"><!-- by webkul -->
                    {$HOOK_CONTENT_SHIP}
                        <!-- Tab shipping -->
                        <div class="tab-pane active" id="shipping">
                            <h4 class="visible-print">{l s='Livraison'} <span class="badge">({$order->getShipping()|@count})</span></h4>
                            <!-- Shipping block -->
                            {if !$order->isVirtual()}
                            <div class="form-horizontal">
                                {if $order->gift_message}
                                <div class="form-group">
                                    <label class="control-label col-lg-3">{l s='Message'}</label>
                                    <div class="col-lg-9">
                                        <p class="form-control-static">{$order->gift_message|nl2br}</p>
                                    </div>
                                </div>
                                {/if}
                                {include file='controllers/orders/_shipping.tpl'}
                                {if $carrierModuleCall}
                                    {$carrierModuleCall}
                                {/if}
                                <hr />
                                {if $order->recyclable}
                                    <span class="label label-success"><i class="icon-check"></i> {l s='Emballage recyclé'}</span>
                                {else}
                                    <span class="label label-inactive"><i class="icon-remove"></i> {l s='Emballage recyclé'}</span>
                                {/if}

                                {if $order->gift}
                                    <span class="label label-success"><i class="icon-check"></i> {l s='Emballage cadeau'}</span>
                                {else}
                                    <span class="label label-inactive"><i class="icon-remove"></i> {l s='Emballage cadeau'}</span>
                                {/if}
                            </div>
                            {/if}
                        </div>
                        <!-- Tab returns -->
                        <div class="tab-pane" id="returns">
                            <h4 class="visible-print">{l s='Retours de marchandises'} <span class="badge">({$order->getReturn()|@count})</span></h4>
                            {if !$order->isVirtual()}
                            <!-- Return block -->
                                {if $order->getReturn()|count > 0}
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th><span class="title_box ">{l s='Date'}</span></th>
                                                <th><span class="title_box ">{l s='Type'}</span></th>
                                                <th><span class="title_box ">{l s='Transporteur'}</span></th>
                                                <th><span class="title_box ">{l s='Numéro de suivi'}</span></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            {foreach from=$order->getReturn() item=line}
                                            <tr>
                                                <td>{$line.date_add}</td>
                                                <td>{l s=$line.type}</td>
                                                <td>{$line.state_name}</td>
                                                <td class="actions">
                                                    <span class="shipping_number_show">{if isset($line.url) && isset($line.tracking_number)}<a href="{$line.url|replace:'@':$line.tracking_number|escape:'html':'UTF-8'}">{$line.tracking_number}</a>{elseif isset($line.tracking_number)}{$line.tracking_number}{/if}</span>
                                                    {if $line.can_edit}
                                                    <form method="post" action="{$link->getAdminLink('AdminOrders')|escape:'html':'UTF-8'}&amp;vieworder&amp;id_order={$order->id|intval}&amp;id_order_invoice={if $line.id_order_invoice}{$line.id_order_invoice|intval}{else}0{/if}&amp;id_carrier={if $line.id_carrier}{$line.id_carrier|escape:'html':'UTF-8'}{else}0{/if}">
                                                        <span class="shipping_number_edit" style="display:none;">
                                                            <button type="button" name="tracking_number">
                                                                {$line.tracking_number|htmlentities}
                                                            </button>
                                                            <button type="submit" class="btn btn-default" name="submitShippingNumber">
                                                                {l s='Mettre à jour'}
                                                            </button>
                                                        </span>
                                                        <button href="#" class="edit_shipping_number_link">
                                                            <i class="icon-pencil"></i>
                                                            {l s='Modifier'}
                                                        </button>
                                                        <button href="#" class="cancel_shipping_number_link" style="display: none;">
                                                            <i class="icon-remove"></i>
                                                            {l s='Annuler'}
                                                        </button>
                                                    </form>
                                                    {/if}
                                                </td>
                                            </tr>
                                            {/foreach}
                                        </tbody>
                                    </table>
                                </div>
                                {else}
                                <div class="list-empty hidden-print">
                                    <div class="list-empty-msg">
                                        <i class="icon-warning-sign list-empty-icon"></i>
                                        {l s='Aucune marchandise retournée'}
                                    </div>
                                </div>
                                {/if}
                                {if $carrierModuleCall}
                                    {$carrierModuleCall}
                                {/if}
                            {/if}
                        </div>
                    </div> *}
                    <script>
                        $('#myTab a').click(function (e) {
                            e.preventDefault()
                            $(this).tab('show')
                        })
                    </script>
                </div>
                <!-- Payments block -->
                <div id="form_add_payment_panel" class="panel reception-admin-only">
                    <div class="panel-heading">
                        <i class="icon-credit-card"></i> &nbsp;{l s="Payment"} <span class="badge">{$order->getOrderPayments()|@count}</span>
                    </div>
                    {if count($order->getOrderPayments()) > 0}
                        <p class="alert alert-danger"{if round($order->total_paid_tax_incl, 2) == round($total_paid, 2) || (isset($currentState) && $currentState->id == 6)} style="display: none;"{/if}>
                            {l s='Avertissement'}
                            <strong>{displayPrice price=$total_paid currency=$currency->id}</strong>
                            {l s='paid instead of'}
                            <strong class="total_paid">{displayPrice price=$order->total_paid_tax_incl currency=$currency->id}</strong>
                            {* {foreach $order->getBrother() as $brother_order}
                                {if $brother_order@first}
                                    {if count($order->getBrother()) == 1}
                                        <br />{l s='Cet avertissement concerne également la commande '}
                                    {else}
                                        <br />{l s='Cet avertissement concerne également les commandes suivantes :'}
                                    {/if}
                                {/if}
                                <a href="{$current_index}&amp;vieworder&amp;id_order={$brother_order->id}&amp;token={$smarty.get.token|escape:'html':'UTF-8'}">
                                    #{'%06d'|sprintf:$brother_order->id}
                                </a>
                            {/foreach} *}
                        </p>
                    {/if}
                    <div class="form-group">
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th><span class="title_box ">{l s='Date'}</span></th>
                                        <th><span class="title_box ">{l s='Méthode de paiement'}</span></th>
                                        <th><span class="title_box ">{l s='Source du paiement'}</span></th>
                                        <th><span class="title_box ">{l s='ID de transaction'}</span></th>
                                        <th><span class="title_box ">{l s='Montant'}</span></th>
                                        <th><span class="title_box ">{l s='Facture'}</span></th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {foreach from=$order_payment_detail item=payment}
                                        <tr>
                                            <td>{dateFormat date=$payment['date_add'] full=true}</td>
                                            <td>{$payment['payment_method']|escape:'html':'UTF-8'}</td>
                                            <td>{$payment_types[$payment['payment_type']]['name']|escape:'html'}</td>
                                            <td>{$payment['transaction_id']|escape:'html':'UTF-8'}</td>
                                            <td>{displayPrice price=$payment['real_paid_amount'] currency=$payment['id_currency']}</td>
                                            <td>{if isset($payment['invoice_number'])}{$payment['invoice_number']}{else}--{/if}</td>
                                            <td class="actions">
                                                <a class="open_payment_information btn btn-default" href="#" data-card_number="{if $payment['card_number']}{$payment['card_number']}{else}{l s='Non défini'}{/if}"  data-card_brand="{if $payment['card_brand']}{$payment['card_brand']}{else}{l s='Non défini'}{/if}"  data-card_expiration="{if $payment['card_expiration']}{$payment['card_expiration']}{else}{l s='Non défini'}{/if}"  data-card_holder="{if $payment['card_holder']}{$payment['card_holder']}{else}{l s='Non défini'}{/if}" data-payment_date="{if $payment['date_add']}{$payment['date_add']}{else}{l s='Non défini'}{/if}" data-payment_method="{if $payment['payment_method']}{$payment['payment_method']}{else}{l s='Non défini'}{/if}" data-payment_source="{if $payment_types[$payment['payment_type']]['name']}{$payment_types[$payment['payment_type']]['name']}{else}{l s='Non défini'}{/if}" data-transaction_id="{if $payment['transaction_id']}{$payment['transaction_id']}{else}{l s='Non défini'}{/if}" data-amount="{if $payment['amount']}{displayPrice currency={$payment['id_currency']} price={$payment['amount']}}{else}{l s='Non défini'}{/if}" data-invoice_number="{if isset($payment['invoice_number']) && $payment['invoice_number']}{$payment['invoice_number']}{else}{l s='Non défini'}{/if}"><i class="icon-search"></i> {l s='Détails'}</a>
                                            </td>
                                        </tr>
                                    {foreachelse}
                                        <tr>
                                            <td class="list-empty hidden-print" colspan="6">
                                                <div class="list-empty-msg">
                                                    <i class="icon-warning-sign list-empty-icon"></i>
                                                    {l s='Aucun enregistrement de paiement'}
                                                </div>
                                            </td>
                                        </tr>
                                    {/foreach}
                                </tbody>
                            </table>
                        </div>
                    </div>
                    {if $can_edit}
                        <div class="form-group">
                            <button class="btn btn-primary add_new_payment" id="add_new_payment">
                                <i class="icon-plus-sign"></i> {l s='Ajouter un nouveau paiement'}
                            </button>
                        </div>
                    {/if}
                    {if $can_edit && (!$order->valid && sizeof($currencies) > 1)}
                        <form class="form-horizontal well" method="post" action="{$currentIndex|escape:'html':'UTF-8'}&amp;vieworder&amp;id_order={$order->id}&amp;token={$smarty.get.token|escape:'html':'UTF-8'}">
                            <div class="form-group">
                                <label class="control-label col-lg-2 col-md-3 text-left">{l s='Changer la devise'}</label>
                                <div class="col-lg-4 col-md-5">
                                    <select name="new_currency">
                                    {foreach from=$currencies item=currency_change}
                                        {if $currency_change['id_currency'] != $order->id_currency}
                                        <option value="{$currency_change['id_currency']}">{$currency_change['name']} - {$currency_change['sign']}</option>
                                        {/if}
                                    {/foreach}
                                    </select>
                                </div>
                                <div class="col-lg-6 col-md-4">
                                    <button type="submit" class="btn btn-primary" name="submitChangeCurrency"><i class="icon-refresh"></i> {l s='Changer la devise'}</button>
                                </div>
                            </div>
                            <p class="help-block">{l s='N&#039;oubliez pas de mettre à jour votre taux de change avant d&#039;effectuer ce changement.'}</p>
                        </form>
                    {/if}
                </div>
                {hook h="displayAdminOrderLeft" id_order=$order->id}
            </div>
            <div class="col-lg-5">
                {* Traveller information *}
                {if $customerGuestDetail}
                    <div class="panel">
                        <div class="panel-heading">
                            <i class="icon icon-user"></i> &nbsp;{l s='Détails du voyageur'}
                             {if $can_edit}
                                <button id="edit_guest_details" class="btn btn-primary pull-right" type="button" >
                                    <i class="icon-pencil"></i> {l s='Modifier'}
                                </button>
                            {/if}
                        </div>
                        <div class="row">
                            <div class="col-xs-12" id="customer-guest-details">
                                <dl class="list-detail col-sm-6">
                                    <label class="label-title">{l s='Titre'}</label>
                                    <dd class="gender_name">{$customerGuestDetail->gender->name}</dd>
                                </dl>
                                <dl class="list-detail col-sm-6">
                                    <label class="label-title">{l s='Nom'}</label>
                                    <dd class="guest_name">{$customerGuestDetail->firstname} {$customerGuestDetail->lastname}</dd>
                                </dl>
                                <dl class="list-detail col-sm-6">
                                    <label class="label-title">{l s='E-mail'}</label>
                                    <dd class="guest_email"><a  href="mailto:{$customerGuestDetail->email}"><i class="icon-envelope-o"></i> {$customerGuestDetail->email}</a></dd>
                                </dl>
                                <dl class="list-detail col-sm-6">
                                    <label class="label-title">{l s='Téléphone'}</label>
                                    <dd class="guest_phone"><a  href="tel:{$customerGuestDetail->phone}"><i class="icon-phone"></i> {$customerGuestDetail->phone}</a></dd>
                                </dl>
                            </div>
                        </div>
                    </div>
                {/if}

                <!-- Customer informations -->
                <div class="panel panel-customer">
                    {if $customer->id}
                        <div class="panel-heading">
                            <i class="icon-user"></i> &nbsp;{l s='Client'} <span class="badge">{l s='#'}{$customer->id}</span>
                            <a href="?tab=AdminCustomers&amp;id_customer={$customer->id}&amp;viewcustomer&amp;token={getAdminToken tab='AdminCustomers'}" class="pull-right">{l s='Voir la fiche client'}</a>
                        </div>
                        <div class="row">
                            <div class="col-xs-12 customer_info">
                                {if ($customer->isGuest())}
                                    <p class="alert alert-warning">{l s='Cette réservation a été créée par un invité.'}</p>
                                    {if (!Customer::customerExists($customer->email))}
                                        <dl class="list-detail col-sm-12">
                                            <label class="label-title">{l s='Informations invité'}</label>

                                            <dd><i class="icon-user"></i> &nbsp;<b><a  href="?tab=AdminCustomers&amp;id_customer={$customer->id}&amp;viewcustomer&amp;token={getAdminToken tab='AdminCustomers'}">{$customer->firstname} {$customer->lastname}</a></b></dd>
                                            <dd><i class="icon-envelope"></i>  &nbsp;<b><a  href="mailto:{$customer->email}">{$customer->email}</a></b></dd>
                                            {if $customer->phone}
                                                <dd><i class="icon-phone"></i>  &nbsp;<b><a  href="tel:{$customer->phone}">{$customer->phone}</a></b></dd>
                                            {/if}
                                        </dl>
                                        <form method="post" action="index.php?tab=AdminCustomers&amp;id_customer={$customer->id}&amp;id_order={$order->id|intval}&amp;token={getAdminToken tab='AdminCustomers'}">
                                            <input type="hidden" name="id_lang" value="{$order->id_lang}" />

                                            {if $can_edit}
                                                <button class="btn btn-primary" type="submit" name="submitGuestToCustomer"><i class='icon-refresh'></i> {l s='Transformer cet invité en client'}</button>
                                                <p class="help-block">{l s='Cette fonctionnalité génère un mot de passe aléatoire et envoie un email au client.'}</p>
                                            {/if}
                                        </form>
                                    {else}
                                        <div class="alert alert-warning">
                                            {l s='Un compte client existant est déjà associé à cette adresse email'}
                                        </div>
                                    {/if}
                                {else}
                                    <dl class="list-detail col-sm-6">
                                        <label class="label-title">{l s='Client'}</label>

                                        <dd><i class="icon-user"></i> &nbsp;<b><a  href="?tab=AdminCustomers&amp;id_customer={$customer->id}&amp;viewcustomer&amp;token={getAdminToken tab='AdminCustomers'}">{$customer->firstname} {$customer->lastname}</a></b></dd>
                                        <dd><i class="icon-envelope"></i>  &nbsp;<b><a  href="mailto:{$customer->email}">{$customer->email}</a></b></dd>
                                        {if $customer->phone}
                                            <dd><i class="icon-phone"></i>  &nbsp;<b><a  href="tel:{$customer->phone}">{$customer->phone}</a></b></dd>
                                        {/if}
                                    </dl>
                                    <dl class="list-detail col-sm-6">
                                        <label class="label-title">{l s='Informations client'}</label>

                                        <dd><b><i class="icon-calendar"></i> &nbsp; {$customer->date_add|date_format:"%d %b, %Y"}</b> ({l s='Membre depuis'})</dd>
                                        <dd><b><i class="icon-list"></i> &nbsp; {$customerStats['nb_orders']|intval}</b> ({l s='Total des commandes valides'})</dd>
                                        <dd><b><i class="icon-credit-card"></i> &nbsp; {displayPrice price=Tools::ps_round(Tools::convertPrice($customerStats['total_spent']|floatval, $currency), _PS_PRICE_DISPLAY_PRECISION_) currency=$currency->id}</b> ({l s='Total dépensé depuis l&#039;inscription'})</dd>
                                        {if Configuration::get('PS_B2B_ENABLE')}
                                            <dd><b>{$customer->siret}</b> ({l s='Siret'})</dd>
                                            <dd><b>{$customer->ape|date_format:"%d %b, %Y"}</b> ({l s='APE'})</dd>
                                        {/if}
                                    </dl>
                                {/if}
                            </div>

                            <div class="col-xs-12">
                                <div class="panel panel-sm reception-admin-only">
                                    <div class="panel-heading">
                                        <i class="icon-eye-slash"></i> &nbsp;{l s='Note privée'}
                                    </div>
                                    <form id="customer_note" class="form-horizontal" action="ajax.php" method="post" onsubmit="saveCustomerNote({$customer->id});return false;" >
                                        <div class="form-group">
                                            <div class="col-lg-12">
                                                <textarea rows="3" name="note" id="noteContent" class="textarea-autosize" onkeyup="$(this).val().length > 0 ? $('#submitCustomerNote').removeAttr('disabled') : $('#submitCustomerNote').attr('disabled', 'disabled')">{$customer->note}</textarea>
                                            </div>
                                        </div>
                                        {if $can_edit}
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <button type="submit" id="submitCustomerNote" class="btn btn-primary pull-right" disabled="disabled">
                                                        <i class="icon-save"></i> {l s='Ajouter une note'}
                                                    </button>
                                                </div>
                                            </div>
                                        {/if}
                                        <span id="note_feedback"></span>
                                    </form>
                                </div>
                            </div>

                            <div class="col-xs-12">
                                {capture "TaxMethod"}
                                    {if ($order->getTaxCalculationMethod() == $smarty.const.PS_TAX_EXC)}
                                        {l s='HT'}
                                    {else}
                                        {l s='TTC'}
                                    {/if}
                                {/capture}
                                <div class="alert alert-warning">
                                    {l s='Pour ce groupe de client, les prix sont affichés comme : [1]%s[/1]' sprintf=[$smarty.capture.TaxMethod] tags=['<strong>']}
                                    {if !$refund_allowed}
                                        <br/><strong>{l s='Les remboursements sont désactivés'}</strong>
                                    {/if}
                                </div>
                            </div>
                        </div>

                    {/if}
                </div>

                <div class="panel panel-guest_address reception-admin-only">
                    <div class="panel-heading">
                        <span class="panel-title"><i class="icon icon-envelope"></i> &nbsp;{l s='Adresse du client'}</span>
                        {if $can_edit}
                            {if $idOrderAddressInvoice}
                                <button id="edit_guest_address" class="btn btn-primary pull-right fancybox" href="{$link->getAdminLink('AdminAddresses')}&amp;id_address={$idOrderAddressInvoice}&amp;updateaddress&amp;id_order={$order->id|intval}&amp;address_type=2&amp;realedit=1&amp;liteDisplaying=1&amp;submitFormAjax=1#">
                                    <i class="icon-pencil"></i> {l s='Modifier'}
                                </button>
                                {if (!$idCurrentAddress || ($idCurrentAddress != $idOrderAddressInvoice)) || $ordersWithDiffInvAddr}
                                    <div class="guest_address_actions dropdown">
                                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                                            <i class="icon-ellipsis-vertical"></i>
                                        </a>
                                        <ul class="dropdown-menu">
                                            {if $ordersWithDiffInvAddr}
                                                <li><a href="{$current_index}&amp;vieworder&amp;token={$smarty.get.token|escape:'html':'UTF-8'}&amp;id_order={$order->id|intval}&amp;action=set_old_orders_address">{l s='Appliquer à toutes les commandes'}</a></li>
                                            {/if}
                                            {if !$idCurrentAddress || ($idCurrentAddress != $idOrderAddressInvoice)}
                                                <li><a href="{$current_index}&amp;vieworder&amp;token={$smarty.get.token|escape:'html':'UTF-8'}&amp;id_order={$order->id|intval}&amp;action=set_address_current_address">{l s='Définir comme adresse actuelle'}</a></li>
                                            {/if}
                                        </ul>
                                    </div>
                                {/if}
                            {else}
                                <button id="add_guest_address" class="btn btn-primary pull-right fancybox" href="{$link->getAdminLink('AdminAddresses')}&amp;addaddress&amp;id_order={$order->id|intval}&amp;address_type=2&amp;id_customer={$order->id_customer}&amp;liteDisplaying=1&amp;submitFormAjax=1#">
                                    <i class="icon-plus-circle"></i> {l s='Ajouter une adresse'}
                                </button>
                                {if $idCurrentAddress}
                                    <div class="guest_address_actions dropdown">
                                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                                            <i class="icon-ellipsis-vertical"></i>
                                        </a>
                                        <ul class="dropdown-menu">
                                            <li><a href="{$current_index}&amp;vieworder&amp;token={$smarty.get.token|escape:'html':'UTF-8'}&amp;id_order={$order->id|intval}&amp;action=set_order_active_address">{l s='Définir l&#039;adresse actuelle pour cette commande'}</a></li>
                                        </ul>
                                    </div>
                                {/if}
                            {/if}
                        {/if}
                    </div>
                    <div class="row">
                        {if $guestFormattedAddress}
                            {$guestFormattedAddress}
                        {else}
                            <div class="list-empty">
                                <div class="list-empty-msg">
                                    <i class="icon-warning-sign list-empty-icon"></i>
                                    {l s='Adresse de l&#039;invité non trouvée.'}
                                </div>
                            </div>
                        {/if}
                    </div>
                </div>

                {* Order Internal notes *}
                {if isset($messages) && $messages}
                    <div class="panel order-notes">
                        <div class="panel-heading">
                            <i class="icon-undo"></i> &nbsp;{l s='Notes privées de la commande'}
                        </div>
                        <div class="panel-content">
                            {foreach from=$messages item=message name=customerMessage}
                                <div class="message-body">
                                    <p class="message-item-text">
                                        {$message['message']|escape:'html':'UTF-8'|nl2br}
                                    </p>
                                    <p>
                                        {if ($message['elastname']|escape:'html':'UTF-8')}{$message['efirstname']|escape:'html':'UTF-8'}
                                            <span>{$message['elastname']|escape:'html':'UTF-8'}{else}{$message['cfirstname']|escape:'html':'UTF-8'} {$message['clastname']|escape:'html':'UTF-8'}</span>
                                        {/if},
                                        <span class="message-date">&nbsp;<i class="icon-calendar"></i>
                                            {dateFormat date=$message['date_add']}
                                        </span>
                                        {if ($message['private'] == 1)}
                                            <span class="badge badge-info">{l s='Privé'}</span>
                                        {/if}
                                    </p>
                                </div>
                                {if !$smarty.foreach.customerMessage.last}<hr/>{/if}
                                {* {if ($message['is_new_for_me'])}
                                    <a class="new_message" title="{l s='Marquer ce message comme &#039;lu&#039;'}" href="{$smarty.server.REQUEST_URI}&amp;token={$smarty.get.token}&amp;messageReaded={$message['id_message']}">
                                        <i class="icon-ok"></i>
                                    </a>
                                {/if} *}
                            {/foreach}
                        </div>
                    </div>
                {/if}

                <div class="panel panel-refund-request reception-admin-only">
                    <div class="panel-heading">
                        <i class="icon-undo"></i> &nbsp;{l s='Demandes de remboursement'}
                    </div>
                    <div class="panel-content">
                        {if is_array($returns) && count($returns)}
                            <div class=table-responsive>
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>{l s='ID de la demande'}</th>
                                            {if isset($refundReqBookings) && $refundReqBookings}
                                                <th>{l s='Total des chambres'}</th>
                                            {/if}
                                            {if isset($refundReqProducts) && $refundReqProducts}
                                                <th>{l s='Total des produits'}</th>
                                            {/if}
                                            <th>{l s='Date de la demande'}</th>
                                            <th>{l s='Statut'}</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {foreach from=$returns item=return_info}
                                            <tr>
                                                <td>
                                                    <a  href="{$link->getAdminLink('AdminOrderRefundRequests')}&vieworder_return&id_order_return={$return_info.id_order_return}" target="_blank">#{$return_info.id_order_return}</a>
                                                </td>
                                                {if isset($refundReqBookings) && $refundReqBookings}
                                                    <td>{$return_info.total_rooms}</td>
                                                {/if}
                                                {if isset($refundReqProducts) && $refundReqProducts}
                                                    <td>{$return_info.total_products}</td>
                                                {/if}
                                                <td>
                                                    {$return_info.date_add}
                                                </td>
                                                <td>
                                                    <span class="badge" style="background-color:{$return_info.state_color}">{$return_info.state_name}</span>
                                                    {if $return_info.refunded_amount > 0}
                                                        &nbsp;<span class="badge badge-success refunded_amount">{displayPrice price=$return_info.refunded_amount currency=$currency->id}</span>
                                                    {/if}
                                                </td>
                                            </tr>
                                        {/foreach}
                                    </tbody>
                                </table>
                            </div>
                        {else}
                            <div class="list-empty">
                                <div class="list-empty-msg">
                                    <i class="icon-warning-sign list-empty-icon"></i>
                                    {l s='Aucune demande de remboursement créée.'}
                                </div>
                            </div>
                        {/if}
                    </div>
                </div>
                {if is_array($applicable_refund_policies) && count($applicable_refund_policies)}
                    <div class="panel">
                        <div class="panel-heading">
                            <i class="icon-remove-sign"></i> &nbsp;{l s='Politiques d&#039;annulation'}
                        </div>
                        <div class="panel-content">
                            {if is_array($applicable_refund_policies) && count($applicable_refund_policies)}
                                <ul>
                                    {foreach from=$applicable_refund_policies item=$applicable_refund_policy}
                                        <li class="form-group">
                                            <a  href="{$link->getAdminLink('AdminOrderRefundRules')|escape:'html':'UTF-8'}&id_refund_rule={$applicable_refund_policy.id_refund_rule}&updatehtl_order_refund_rules" target="_blank">
                                                {$applicable_refund_policy.name|escape:'html':'UTF-8'} &nbsp;<i class="icon icon-external-link-square"></i>
                                            </a>
                                        </li>
                                    {/foreach}
                                </ul>
                            {else}
                                <div class="list-empty">
                                    <div class="list-empty-msg">
                                        <i class="icon-warning-sign list-empty-icon"></i>
                                        {l s='Aucune politique d&#039;annulation applicable.'}
                                    </div>
                                </div>
                            {/if}
                        </div>
                    </div>
                {/if}
                {hook h="displayAdminOrderRight" id_order=$order->id}
            </div>
        </div>
        {hook h="displayAdminOrder" id_order=$order->id}
        <div class="row reception-admin-only" id="start_products">
            <div class="col-lg-12">
                <form class="container-command-top-spacing" action="{$current_index}&amp;vieworder&amp;token={$smarty.get.token|escape:'html':'UTF-8'}&amp;id_order={$order->id|intval}" method="post" onsubmit="return orderDeleteProduct('{l s='Ce produit ne peut pas être retourné.'}', '{l s='La quantité à annuler est supérieure à la quantité disponible.'}');">
                    <input type="hidden" name="id_order" value="{$order->id}" />
                    <div style="display: none">
                        <input type="hidden" value="{$order->getWarehouseList()|implode}" id="warehouse_list" />
                    </div>
                    {if $hotel_booking}
                        <div class="panel">
                            <div class="panel-heading">
                                <i class="icon-bed"></i> &nbsp;{l s='Détail de la réservation des chambres'} <span class="badge">{$order_detail_data|@count}</span>
                                {if $can_edit && (!$order->hasBeenDelivered() && $currentState->id != Configuration::get('PS_OS_REFUND') && $currentState->id != Configuration::get('PS_OS_CANCELED'))}
                                    <button type="button" id="add_room" class="btn btn-primary pull-right">
                                        <i class="icon-plus-sign"></i> {l s='Ajouter des chambres'}
                                    </button>
                                {/if}
                            </div>
                            {* by webkul this code is added for showing rooms information on the order detail page *}
                            {include file='controllers/orders/_rooms_informaion_table.tpl'}

                            {if ($order->getTaxCalculationMethod() == $smarty.const.PS_TAX_EXC)}
                                <input type="hidden" name="TaxMethod" value="0">
                            {else}
                                <input type="hidden" name="TaxMethod" value="1">
                            {/if}
                        </div>

                        {if $hotel_service_products || $hotelStandaloneProducts || $standaloneProducts}
                            <div class="panel">
                                <div class="panel-heading">
                                    <i class="icon-bed"></i> &nbsp;{l s='Détail des produits'} <span class="badge">{$hotel_service_products|count}</span>
                                    {if $can_edit && (!$order->hasBeenDelivered() && $currentState->id != Configuration::get('PS_OS_REFUND') && $currentState->id != Configuration::get('PS_OS_CANCELED'))}
                                        <button type="button" id="add_product" class="btn btn-primary pull-right">
                                            <i class="icon-plus-sign"></i> {l s='Ajouter un produit'}
                                        </button>
                                    {/if}
                                </div>
                                {include file='controllers/orders/_hotel_service_products_table.tpl'}

                                {if ($order->getTaxCalculationMethod() == $smarty.const.PS_TAX_EXC)}
                                    <input type="hidden" name="TaxMethod" value="0">
                                {else}
                                    <input type="hidden" name="TaxMethod" value="1">
                                {/if}
                            </div>
                        {/if}
                    {else}
                        {if $standalone_service_products || $standaloneProducts}
                            <div class="panel">
                                <div class="panel-heading">
                                    <i class="icon-bed"></i> &nbsp;{l s='Détail des produits'} <span class="badge">{$standalone_service_products|count}</span>
                                    {if $can_edit && (!$order->hasBeenDelivered() && $currentState->id != Configuration::get('PS_OS_REFUND') && $currentState->id != Configuration::get('PS_OS_CANCELED'))}
                                        <button type="button" id="add_product" class="btn btn-primary pull-right">
                                            <i class="icon-plus-sign"></i> {l s='Ajouter un produit'}
                                        </button>
                                    {/if}
                                </div>
                                {include file='controllers/orders/_standalone_service_products_table.tpl'}

                                {if ($order->getTaxCalculationMethod() == $smarty.const.PS_TAX_EXC)}
                                    <input type="hidden" name="TaxMethod" value="0">
                                {else}
                                    <input type="hidden" name="TaxMethod" value="1">
                                {/if}
                            </div>
                        {/if}
                    {/if}
                </form>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-4 col-sm-6 col-xs-12 pull-right">
                <div class="panel panel-total">
                    <div class="table-responsive">
                        <table class="table" id="order-details-price">
                            {* Assign order price *}
                            {if ($order->getTaxCalculationMethod() == $smarty.const.PS_TAX_EXC)}
                                {assign var=order_product_price value=($order->total_products)}
                                {assign var=order_discount_price value=$order->total_discounts_tax_excl}
                                {assign var=order_wrapping_price value=$order->total_wrapping_tax_excl}
                                {assign var=order_shipping_price value=$order->total_shipping_tax_excl}
                            {else}
                                {assign var=order_product_price value=$order->total_products_wt}
                                {assign var=order_discount_price value=$order->total_discounts_tax_incl}
                                {assign var=order_wrapping_price value=$order->total_wrapping_tax_incl}
                                {assign var=order_shipping_price value=$order->total_shipping_tax_incl}
                            {/if}

                            {* total extra demands prices *}
                            {* $totalDemandsPriceTE
                            $totalDemandsPriceTI *}

                            {* Get total rooms prices *}
                            {assign var=total_rooms_price_tax_excl value=$order->getTotalProductsWithoutTaxes(false, true)}
                            {assign var=total_rooms_price_tax_incl value=$order->getTotalProductsWithTaxes(false, true)}

                            {* Get total extra services including convenience fees prices *}
                            {assign var=total_products_price_tax_excl value=($order->getTotalProductsWithoutTaxes(false, false, Product::SELLING_PREFERENCE_HOTEL_STANDALONE) + $order->getTotalProductsWithoutTaxes(false, false, Product::SELLING_PREFERENCE_STANDALONE))}
                            {assign var=total_products_price_tax_incl value=($order->getTotalProductsWithTaxes(false, false, Product::SELLING_PREFERENCE_HOTEL_STANDALONE) + $order->getTotalProductsWithTaxes(false, false, Product::SELLING_PREFERENCE_STANDALONE))}

                            {* Get total of extra services and extra demands prices(excluding convenience fee) *}
                            {assign var=total_room_services_and_demands_tax_excl value=($order->getTotalProductsWithoutTaxes(false, false, Product::SELLING_PREFERENCE_WITH_ROOM_TYPE) + $totalDemandsPriceTE)}
                            {assign var=total_room_services_and_demands_tax_incl value=($order->getTotalProductsWithTaxes(false, false, Product::SELLING_PREFERENCE_WITH_ROOM_TYPE) + $totalDemandsPriceTI)}

                            {* Get total of only convenience fees prices *}
                            {assign var=total_convenience_fee_tax_excl value=$order->getTotalProductsWithoutTaxes(false, false, Product::SELLING_PREFERENCE_WITH_ROOM_TYPE, 1, Product::PRICE_ADDITION_TYPE_INDEPENDENT)}
                            {assign var=total_convenience_fee_tax_incl value=$order->getTotalProductsWithTaxes(false, false, Product::SELLING_PREFERENCE_WITH_ROOM_TYPE, 1, Product::PRICE_ADDITION_TYPE_INDEPENDENT)}

                            {assign var=order_total_price_tax_excl value=($total_rooms_price_tax_excl + $total_room_services_and_demands_tax_excl + $total_products_price_tax_excl)}
                            {assign var=order_total_price_tax_incl value=($total_rooms_price_tax_incl + $total_room_services_and_demands_tax_incl + $total_products_price_tax_incl)}

                            {if $total_rooms_price_tax_excl}
                                <tr id="total_products">
                                    <td class="text-right">{l s='Coût total des chambres (HT)'}</td>
                                    <td class="amount text-right nowrap">
                                        {displayPrice price=$total_rooms_price_tax_excl currency=$currency->id}
                                    </td>
                                    <td class="partial_refund_fields current-edit" style="display:none;"></td>
                                </tr>
                            {/if}
                            {if $total_products_price_tax_excl > 0}
                                <tr id="total_products">
                                    <td class="text-right">{l s='Total des produits (HT)'}</td>
                                    <td class="amount text-right nowrap">
                                        {displayPrice price=$total_products_price_tax_excl currency=$currency->id}
                                    </td>
                                    <td class="partial_refund_fields current-edit" style="display:none;"></td>
                                </tr>
                            {/if}
                            {if isset($total_room_services_and_demands_tax_excl) && $total_room_services_and_demands_tax_excl > 0}
                                <tr id="total_products">
                                    <td class="text-right">{l s='Total des services supplémentaires (HT)'}</td>
                                    <td class="amount text-right nowrap">
                                        {displayPrice price=($total_room_services_and_demands_tax_excl - $total_convenience_fee_tax_excl) currency=$currency->id}
                                    </td>
                                    <td class="partial_refund_fields current-edit" style="display:none;"></td>
                                </tr>
                            {/if}
                            {if isset($total_convenience_fee_tax_excl) && $total_convenience_fee_tax_excl > 0}
                                <tr id="total_products">
                                    <td class="text-right">
                                        {l s='Frais de commodité (HT)'}
                                        {if isset($order_convenience_fee_services) && count($order_convenience_fee_services)}
                                            <span role="button" id="view_convenience_services" class="pull-left"><i class="icon-angle-down icon-bold"></i><i class="icon-angle-up icon-bold" style="display:none;"></i></span>
                                        {/if}
                                    </td>
                                    <td class="amount text-right nowrap">
                                        {displayPrice price=$total_convenience_fee_tax_excl currency=$currency->id}
                                    </td>
                                    <td class="partial_refund_fields current-edit" style="display:none;"></td>
                                </tr>
                                {if isset($order_convenience_fee_services) && count($order_convenience_fee_services)}
                                    <tr id="convenience_services" style="display:none;">
                                        <td colspan="3" class="panel">
                                            <table class="table table-responsive">
                                                <tbody>
                                                    {foreach $order_convenience_fee_services as $service}
                                                        <tr>
                                                            <td class="text-left"><span>{$service.name}</span></td>
                                                            <td class="text-right"><span>{displayPrice price=$service.total_price_tax_excl currency=$currency->id}</span></td>
                                                        </tr>
                                                    {/foreach}
                                                </tbody>
                                            </table>
                                        </td>
                                    </tr>
                                {/if}
                            {/if}
                            {* {if ($order->getTaxCalculationMethod() == $smarty.const.PS_TAX_EXC)} *}
                            <tr id="total_taxes">
                                <td class="text-right">
                                    <strong>{l s='Total des taxes'} </strong>
                                    {if ($order_total_price_tax_incl - $order_total_price_tax_excl) > 0}
                                        <span role="button" id="view_order_tax_details" class="pull-left"><i class="icon-angle-down icon-bold"></i><i class="icon-angle-up icon-bold" style="display:none;"></i></span>
                                    {/if}
                                </td>
                                <td class="amount text-right nowrap" ><strong>{displayPrice price=($order_total_price_tax_incl - $order_total_price_tax_excl) currency=$currency->id}</strong>
                                </td>
                                <td class="partial_refund_fields current-edit" style="display:none;"></td>
                            </tr>
                            {if ($order_total_price_tax_incl - $order_total_price_tax_excl) > 0}
                                <tr id="order_tax_details" style="display:none;">
                                    <td colspan="3" class="panel">
                                        <table class="table table-responsive">
                                            <tbody>
                                                {if $total_rooms_price_tax_excl}
                                                    <tr>
                                                        <td class="text-left">{l s='Taxe des chambres'}</td>
                                                        <td class="text-right">
                                                            {displayPrice price=($total_rooms_price_tax_incl - $total_rooms_price_tax_excl) currency=$currency->id}
                                                        </td>
                                                    </tr>
                                                {/if}
                                                {if isset($total_room_services_and_demands_tax_incl) && (($total_room_services_and_demands_tax_incl - $total_room_services_and_demands_tax_excl) - ($total_convenience_fee_tax_incl - $total_convenience_fee_tax_excl)) > 0}
                                                    <tr>
                                                        <td class="text-left">{l s='Taxe des services supplémentaires'}</td>
                                                        <td class="text-right nowrap">
                                                            {displayPrice price=(($total_room_services_and_demands_tax_incl - $total_room_services_and_demands_tax_excl) - ($total_convenience_fee_tax_incl - $total_convenience_fee_tax_excl)) currency=$currency->id}
                                                        </td>
                                                        <td class="partial_refund_fields current-edit" style="display:none;"></td>
                                                    </tr>
                                                {/if}
                                                {if ($total_products_price_tax_incl - $total_products_price_tax_excl) > 0}
                                                    <tr id="total_products">
                                                        <td class="text-left">{l s='Taxe des produits'}</td>
                                                        <td class="amount text-right nowrap">
                                                            {displayPrice price=($total_products_price_tax_incl - $total_products_price_tax_excl) currency=$currency->id}
                                                        </td>
                                                        <td class="partial_refund_fields current-edit" style="display:none;"></td>
                                                    </tr>
                                                {/if}
                                                {if isset($total_convenience_fee_tax_excl) && $total_convenience_fee_tax_excl > 0}
                                                    <tr id="total_products">
                                                        <td class="text-left">{l s='Taxe des frais de commodité'}</td>
                                                        <td class="amount text-right nowrap">
                                                            {displayPrice price=($total_convenience_fee_tax_incl - $total_convenience_fee_tax_excl) currency=$currency->id}
                                                        </td>
                                                        <td class="partial_refund_fields current-edit" style="display:none;"></td>
                                                    </tr>
                                                {/if}
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                            {/if}
                            {* {/if} *}
                            <tr id="total_discounts" {if $order->total_discounts_tax_incl == 0}style="display: none;"{/if}>
                                <td class="text-right"><strong>{l s='Montant total de la réservation'}</strong></td>
                                <td class="amount text-right nowrap">
                                    <strong>{displayPrice price=($order_total_price_tax_incl) currency=$currency->id}</strong>
                                </td>
                                <td class="partial_refund_fields current-edit" style="display:none;"></td>
                            </tr>
                            <tr id="total_discounts" {if $order->total_discounts_tax_incl == 0}style="display: none;"{/if}>
                                <td class="text-right"><strong>{l s='Remises'}</strong></td>
                                <td class="amount text-right nowrap">
                                    <strong>-{displayPrice price=$order->total_discounts_tax_incl currency=$currency->id}</strong>
                                </td>
                                <td class="partial_refund_fields current-edit" style="display:none;"></td>
                            </tr>
                            <tr id="total_wrapping" {if $order->total_wrapping_tax_incl == 0}style="display: none;"{/if}>
                                <td class="text-right">{l s='Emballage'}</td>
                                <td class="amount text-right nowrap">
                                    {displayPrice price=$order_wrapping_price currency=$currency->id}
                                </td>
                                <td class="partial_refund_fields current-edit" style="display:none;"></td>
                            </tr>
                            <tr id="total_order">
                                <td class="text-right"><strong>{l s='Total final de la réservation'}</strong></td>
                                <td class="amount text-right nowrap">
                                    <strong>{displayPrice price=$order->total_paid_tax_incl currency=$currency->id}</strong>
                                </td>
                                <td class="partial_refund_fields current-edit" style="display:none;"></td>
                            </tr>

                            {if (isset($refundReqBookings) && $refundReqBookings) || (isset($refundReqProducts) && $refundReqProducts)}
                                <tr id="total_order">
                                    <td class="text-right"><strong>* {l s='Montant remboursé'}</strong></td>
                                    <td class="amount text-right nowrap">
                                        <strong>{displayPrice price=$refundedAmount currency=$currency->id}</strong>
                                    </td>
                                    <td class="partial_refund_fields current-edit" style="display:none;"></td>
                                </tr>
                            {/if}

                            <tr>
                                <td class="text-right"><strong>{l s='Montant dû'}</strong></td>
                                <td class="amount text-right nowrap">
                                    <strong>
                                        {displayPrice currency=$order->id_currency price=($order->total_paid_tax_incl - $order->total_paid_real)}
                                    </strong>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>

            {* Discount block *}
            <div class="col-lg-4 col-sm-6 col-xs-12 pull-right">
                <div class="panel panel-vouchers reception-admin-only">
                    <div class="panel-heading">
                        <span><i class="icon-tag"></i> &nbsp;{l s='Bon de réduction'}</span>
                        {if $can_edit && $order->total_paid > 0}
                            <button id="add_voucher" class="btn btn-primary pull-right" type="button" >
                                <i class="icon-ticket"></i> {l s='Ajouter un nouveau bon de réduction'}
                            </button>
                        {/if}
                    </div>
                    <div class="panel-content">
                        {if sizeof($discounts)}
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>
                                                <span class="title_box ">{l s='Nom du bon de réduction'}</span>
                                            </th>
                                            <th>
                                                <span class="title_box ">{l s='Valeur'}</span>
                                            </th>
                                            {if $can_edit}
                                                <th class="text-center">
                                                    <span class="title_box ">{l s='Supprimer'}</span>
                                                </th>
                                            {/if}
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {foreach from=$discounts item=discount}
                                            <tr>
                                                <td>{$discount['name']}</td>
                                                <td>
                                                {if $discount['value'] != 0.00}
                                                    -
                                                {/if}
                                                {displayPrice price=$discount['value'] currency=$currency->id}
                                                </td>
                                                {if $can_edit}
                                                    <td class="text-center">
                                                        <a class="btn btn-default delete-voucher" href="{$current_index}&amp;submitDeleteVoucher&amp;id_order_cart_rule={$discount['id_order_cart_rule']}&amp;id_order={$order->id}&amp;token={$smarty.get.token|escape:'html':'UTF-8'}"><i class="icon-trash"></i></a>
                                                    </td>
                                                {/if}
                                            </tr>
                                        {/foreach}
                                    </tbody>
                                </table>
                            </div>
                        {else}
                            <div class="list-empty">
                                <div class="list-empty-msg">
                                    <i class="icon-warning-sign list-empty-icon"></i>
                                    {l s='Aucun bon de réduction créé.'}
                                </div>
                            </div>
                        {/if}
                    </div>
                </div>
            </div>

            <!-- linked orders block -->
            {if count($order->getBrother()) > 0}
                <div class="col-lg-4 col-sm-6 col-xs-12 pull-right">
                    <div class="panel">
                        <div class="panel-heading">
                            <i class="icon-link"></i> &nbsp;{l s='Commandes liées'}
                        </div>
                        <div class="panel-content">
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>
                                                {l s='Commande n° '}
                                            </th>
                                            <th>
                                                {l s='Statut'}
                                            </th>
                                            <th>
                                                {l s='Montant'}
                                            </th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {foreach $order->getBrother() as $brother_order}
                                        <tr>
                                            <td>
                                                <a  href="{$current_index}&amp;vieworder&amp;id_order={$brother_order->id}&amp;token={$smarty.get.token|escape:'html':'UTF-8'}">#{$brother_order->id}</a>
                                            </td>
                                            <td>
                                                {$brother_order->getCurrentOrderState()->name[$current_id_lang]}
                                            </td>
                                            <td>
                                                {displayPrice price=$brother_order->total_paid_tax_incl currency=$currency->id}
                                            </td>
                                            <td>
                                                <a  href="{$current_index}&amp;vieworder&amp;id_order={$brother_order->id}&amp;token={$smarty.get.token|escape:'html':'UTF-8'}">
                                                    <i class="icon-eye-open"></i>
                                                    {l s='Voir la commande'}
                                                </a>
                                            </td>
                                        </tr>
                                        {/foreach}
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            {/if}

            <div class="col-lg-4 col-sm-6 col-xs-12 hidden-print reception-admin-only">
                <div class="panel">
                    <div class="panel-heading">
                        <i class="icon-envelope"></i> &nbsp;{l s='Messages'} <span class="badge">{sizeof($customer_thread_message)}</span>
                        {if $id_customer_thread}
                            <a href="{$link->getAdminLink('AdminCustomerThreads')|escape:'html':'UTF-8'}&amp;viewcustomer_thread&id_customer_thread={$id_customer_thread|intval}" class="pull-right ">{l s='Afficher tous les messages'}</a>
                        {else}
                            <a href="{$link->getAdminLink('AdminCustomerThreads')|escape:'html':'UTF-8'}" class="pull-right">{l s='Afficher tous les messages'}</a>
                        {/if}
                    </div>
                    <div id="messages">
                        {if $can_edit}
                            <form action="{$smarty.server.REQUEST_URI|escape:'html':'UTF-8'}&amp;token={$smarty.get.token|escape:'html':'UTF-8'}" method="post" onsubmit="if (getE('visibility').checked == true) return confirm('{l s='Voulez-vous envoyer ce message au client ?'}');">
                                <div id="message" class="form-horizontal">
                                    <div class="form-group">
                                        <label class="control-label">{l s='Choisir un message standard'}</label>
                                        <p>
                                            <select class="chosen form-control" name="order_message" id="order_message" onchange="orderOverwriteMessage(this, '{l s='Voulez-vous remplacer votre message existant ?'}')">
                                                <option value="0" selected="selected">-</option>
                                                {foreach from=$orderMessages item=orderMessage}
                                                <option value="{$orderMessage['message']|escape:'html':'UTF-8'}">{$orderMessage['name']}</option>
                                                {/foreach}
                                            </select>
                                        </p>
                                        <div>
                                            <a  href="{$link->getAdminLink('AdminOrderMessage')|escape:'html':'UTF-8'}">
                                                {l s='Configurer les messages prédéfinis'}
                                                <i class="icon-external-link"></i>
                                            </a>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <label class="control-label">{l s='Message'}</label>
                                        <textarea rows="3" id="txt_msg" class="textarea-autosize" name="message">{Tools::getValue('message')|escape:'html':'UTF-8'}</textarea>
                                    </div>

                                <div class="form-group">
                                        <p class="checkbox">
                                            <label class="control-label" for="visibility">
                                                <input type="checkbox" name="visibility" id="visibility" value="1" />
                                                {l s='Afficher le message au client ?'}
                                            </label>
                                        </p>
                                    </div>
                                    <input type="hidden" name="id_order" value="{$order->id}" />
                                    <input type="hidden" name="id_customer" value="{$order->id_customer}" />

                                    <div class="row">
                                        <button type="submit" id="submitMessage" class="btn btn-primary pull-right" name="submitMessage">
                                            <i class="icon-paper-plane"></i> {l s='Envoyer le message'}
                                        </button>
                                    </div>
                                </div>
                            </form>
                        {else}
                            <div class="alert alert-warning">{l s='Vous n&#039;avez pas la permission de modifier cette commande.'}</div>
                        {/if}
                    </div>
                </div>
            </div>

            <!-- Sources block -->
            {if (sizeof($sources))}
                <div class="col-lg-4 col-sm-6 col-xs-12">
                    <div class="panel">
                        <div class="panel-heading">
                            <i class="icon-globe"></i> &nbsp;{l s='Sources'} <span class="badge">{$sources|@count}</span>
                        </div>
                        <ul {if sizeof($sources) > 3}style="height: 200px; overflow-y: scroll;"{/if}>
                        {foreach from=$sources item=source}
                            <li class="form-group">
                                {l s='De'} {if $source['http_referer'] != ''}<a  href="{$source['http_referer']}">{parse_url($source['http_referer'], $smarty.const.PHP_URL_HOST)|regex_replace:'/^www./':''}</a>{else}-{/if} {l s='Au'} <a  href="http://{$source['request_uri']}">{$source['request_uri']|truncate:100:'...'}</a> <br />
                                {if $source['keywords']}<b>{l s='Mots-clés'}</b>: {$source['keywords']}<br />{/if}
                                {dateFormat date=$source['date_add'] full=true}<br />
                            </li>
                        {/foreach}
                        </ul>
                    </div>
                </div>
            {/if}
        </div>
    </div>

    {strip}
        {addJsDefL name=no_rm_avail_txt}{l s='Aucune chambre disponible.' js=1}{/addJsDefL}
        {addJsDefL name=no_realloc_rm_avail_txt}{l s='Aucune chambre disponible pour la réallocation.' js=1}{/addJsDefL}
        {addJsDefL name=no_realloc_rm_type_avail_txt}{l s='Aucun type de chambre disponible pour la réallocation.' js=1}{/addJsDefL}
        {addJsDefL name=no_swap_rm_avail_txt}{l s='Aucune chambre disponible pour l&#039;échange.' js=1}{/addJsDefL}
        {addJsDefL name=slct_rm_type_err}{l s='Veuillez d&#039;abord sélectionner un type de chambre.' js=1}{/addJsDefL}
        {addJsDefL name=slct_rm_err}{l s='Veuillez d&#039;abord sélectionner une chambre.' js=1}{/addJsDefL}
        {addJsDefL name=txtExtraDemandSucc}{l s='Mise à jour réussie' js=1}{/addJsDefL}
        {addJsDefL name=atleastSelectTxt}{l s='Sélectionnez au moins un équipement à mettre à jour.' js=1}{/addJsDefL}

        {addJsDefL name=txtSomeErr}{l s='Une erreur s&#039;est produite. Veuillez réessayer.' js=1}{/addJsDefL}
        {addJsDefL name=txtDeleteSucc}{l s='Supprimé avec succès' js=1}{/addJsDefL}
        {addJsDefL name=txtInvalidDemandVal}{l s='Valeur de demande invalide trouvée' js=1}{/addJsDefL}
        {addJsDefL name='select_age_txt'}{l s='Sélectionner l&#039;âge' js=1}{/addJsDefL}
        {addJsDefL name='under_1_age'}{l s='Moins de 1 an' js=1}{/addJsDefL}
        {addJsDefL name='room_txt'}{l s='Chambre' js=1}{/addJsDefL}
        {addJsDefL name='rooms_txt'}{l s='Chambres' js=1}{/addJsDefL}
        {addJsDefL name='remove_txt'}{l s='Supprimer' js=1}{/addJsDefL}
        {addJsDefL name='adult_txt'}{l s='Adulte' js=1}{/addJsDefL}
        {addJsDefL name='adults_txt'}{l s='Adultes' js=1}{/addJsDefL}
        {addJsDefL name='child_txt'}{l s='Enfant' js=1}{/addJsDefL}
        {addJsDefL name='children_txt'}{l s='Enfants' js=1}{/addJsDefL}
        {addJsDefL name='below_txt'}{l s='Moins de' js=1}{/addJsDefL}
        {addJsDefL name='years_txt'}{l s='ans' js=1}{/addJsDefL}
        {addJsDefL name='all_children_txt'}{l s='Tous les enfants' js=1}{/addJsDefL}
        {addJsDefL name='max_occupancy_reached_txt'}{l s='Occupation maximale de la chambre atteinte' js=1}{/addJsDefL}
        {addJsDefL name='max_adults_txt'}{l s='Occupation maximale d&#039;adultes atteinte' js=1}{/addJsDefL}
        {addJsDefL name='max_children_txt'}{l s='Occupation maximale d&#039;enfants atteinte' js=1}{/addJsDefL}
        {addJsDefL name='no_children_allowed_txt'}{l s='Seuls les adultes peuvent être hébergés' js=1}{/addJsDefL}
        {addJsDefL name='invalid_occupancy_txt'}{l s='Occupation invalide (adultes/enfants) détectée.' js=1}{/addJsDefL}
        {addJsDefL name='select_room_txt'}{l s='Sélectionner une chambre' js=1}{/addJsDefL}
        {addJsDef max_child_age=$max_child_age|escape:'quotes':'UTF-8'}
        {addJsDef max_child_in_room=$max_child_in_room|escape:'quotes':'UTF-8'}
        {addJsDef ROOM_STATUS_CHECKED_IN=$ROOM_STATUS_CHECKED_IN|escape:'quotes':'UTF-8'}
        {addJsDef ROOM_STATUS_CHECKED_OUT=$ROOM_STATUS_CHECKED_OUT|escape:'quotes':'UTF-8'}
        {addJsDef ALLOTMENT_MANUAL=$ALLOTMENT_MANUAL|escape:'quotes':'UTF-8'}
        {addJsDef PS_OS_CANCELED=Configuration::get('PS_OS_CANCELED')|escape:'quotes':'UTF-8'}
        {addJsDef PS_OS_REFUND=Configuration::get('PS_OS_REFUND')|escape:'quotes':'UTF-8'}
        {addJsDefL name=txt_booking_document_upload_success}{l s='Document téléchargé avec succès.' js=1}{/addJsDefL}
        {addJsDefL name=txt_booking_document_delete_confirm}{l s='Êtes-vous sûr ?' js=1}{/addJsDefL}
        {addJsDefL name=txt_booking_document_delete_success}{l s='Document supprimé avec succès.' js=1}{/addJsDefL}
        {addJsDefL name='error_found_txt'}{l s='Erreurs trouvées' js=1}{/addJsDefL}
    {/strip}
{/block}
