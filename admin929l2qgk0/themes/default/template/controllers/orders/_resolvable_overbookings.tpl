{**
* NOTICE OF LICENSE
*
* This source file is subject to the Open Software License version 3.0
* that is bundled with this package in the file LICENSE.md
* It is also available through the world-wide-web at this URL:
* https://opensource.org/license/osl-3-0-php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to support@qloapps.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade this module to a newer
* versions in the future. If you wish to customize this module for your needs
* please refer to https://store.webkul.com/customisation-guidelines for more information.
*
* @author Webkul IN
* @copyright Since 2010 Webkul
* @license https://opensource.org/license/osl-3-0-php Open Software License version 3.0
*}

{if isset($resolvableOverBookings) && $resolvableOverBookings}
    <div class="panel">
        <div class="panel-heading">
            <i class="icon-refresh"></i> {l s='Surbookings résolvables'}
        </div>
        <div class="panel-content">
            {if isset($smarty.get.resolvable_overbooked_orders) && $smarty.get.resolvable_overbooked_orders}
                <div class="alert alert-warning">
                    <b>{l s='Les commandes avec surbookings résolvables sont filtrées.'}  <a href="{$link->getAdminLink('AdminOrders')|escape:'html':'UTF-8'}" class="btn btn-warning"><i class="icon-refresh"></i> {l s='Voir toutes les commandes'}</a></b>
                </div>
            {/if}
            <div class="alert alert-info">
                <p>{l s='Certains surbookings sont maintenant résolvables. Vous pouvez les résoudre directement dans la liste ci-dessous.'}</p>
                {if !isset($smarty.get.resolvable_overbooked_orders) || !$smarty.get.resolvable_overbooked_orders}
                    <br>
                    <p>{l s='Vous pouvez également filtrer les commandes dont les surbookings sont résolvables.'}  <a href="{$link->getAdminLink('AdminOrders')|escape:'html':'UTF-8'}&amp;resolvable_overbooked_orders=1" class="btn btn-default"><i class="icon-search"></i> {l s='Filtrer les commandes avec surbookings résolvables'}</a></p>
                {/if}
            </div>
            <div class="table-responsive form-group">
                <table class="table table-striped">
                    <tr>
                        <th>{l s='N° de chambre'}</th>
                        <th>{l s='Type de chambre'}</th>
                        <th>{l s='Hôtel'}</th>
                        <th>{l s='Durée'}</th>
                        <th>{l s='Commande'}</th>
                        <th>{l s='Résoudre'}</th>
                    </tr>
                    {foreach from=$resolvableOverBookings item=data}
                        {if !$data.is_refunded}
                            <tr>
                                <td>{$data['room_num']}</td>
                                <td>
                                    <a href="{$link->getAdminLink('AdminProducts')}&amp;id_product={$data['id_product']|escape:'html':'UTF-8'}&amp;updateproduct">{$data['room_type_name']|escape:'html':'UTF-8'}</a>
                                </td>
                                <td>
                                    <a href="{$link->getAdminLink('AdminAddHotel')}&amp;id={$data['id_hotel']|escape:'html':'UTF-8'}&amp;updatehtl_branch_info" target="_blank"><span>{$data['hotel_name']}</span></a>
                                </td>
                                {assign var="is_full_date" value=($show_full_date && ($data['date_from']|date_format:'%D' == $data['date_to']|date_format:'%D'))}
                                <td>{dateFormat date=$data['date_from']|escape:'html':'UTF-8' full=$is_full_date} {l s='Au'} {dateFormat date=$data['date_to']|escape:'html':'UTF-8' full=$is_full_date}</td>
                                <td>
                                    <a href="{$link->getAdminLink('AdminOrders')|escape:'html':'UTF-8'}&amp;vieworder&amp;id_order={$data['id_order']|escape:'html':'UTF-8'}">#{$data['id_order']|escape:'html':'UTF-8'}</a>
                                </td>
                                <td>
                                    {if isset($data['booked_room_info']) && $data['booked_room_info']}
                                        <span class="badge badge-information">{l s='Déjà réservé'}</span>
                                    {else}
                                        <a href="{$link->getAdminLink('AdminOrders')|escape:'html':'UTF-8'}&amp;resolve_overbooking={$data['id']|escape:'html':'UTF-8'}" class="btn btn-default resolve_overbooking" id_htl_booking="{$data['id']|escape:'html':'UTF-8'}"><i class="icon-refresh"></i> {l s='Résoudre'}</a>
                                    {/if}
                                </td>
                            </tr>
                        {/if}
                    {/foreach}
                </table>
            </div>
        </div>
    </div>

{/if}
