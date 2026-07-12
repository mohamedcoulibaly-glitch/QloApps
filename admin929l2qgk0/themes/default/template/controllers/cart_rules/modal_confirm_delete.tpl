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
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal"><i class="icon-remove-sign"></i></button>
    <h4 class="modal-title"><i class="icon icon-exclamation-triangle"></i> {l s='Confirmer la suppression'}</h4>
    <p>{l s='Êtes-vous sûr de vouloir supprimer cette règle de panier ?'}</p>
</div>
{if isset($cartRule)}
    <div class="modal-body">
        <div class="row">
            <div class="col-sm-4">
                <label>{l s='Bon de réduction'}</label>
                <p class="control-value">
                    {$cartRule->code} (<a href="{$link->getAdminLink('AdminCartRules')}&updatecart_rule&id_cart_rule={$cartRule->id}" target="_blank">#{$cartRule->id}</a>)
                </p>
            </div>
            <div class="col-sm-4">
                <label>{l s='Raison'}</label>
                <p class="control-value">
                    {if $generatedBy == CartRule::GENERATED_BY_REFUND}
                        {l s='Généré contre un remboursement'}
                        (<a href="{$link->getAdminLink('AdminOrderRefundRequests')}&vieworder_return&id_order_return={$generatedById}" target="_blank">#{$generatedById}</a>)
                    {else if $generatedBy == CartRule::GENERATED_BY_ORDER_SLIP}
                        {l s='Généré contre un avoir'}
                        (<a href="{$link->getAdminLink('AdminPdf')}&submitAction=generateOrderSlipPDF&id_order_slip={$generatedById}" target="_blank">#{$generatedById}</a>)
                    {/if}
                </p>
            </div>
            <div class="col-sm-4">
                <label>{l s='Montant'}</label>
                <p class="control-value">{displayPrice price=$cartRule->reduction_amount currency=$cartRule->reduction_currency}</p>
            </div>
            <div class="col-sm-4">
                <label>{l s='Client'}</label>
                <p class="control-value">
                    {$customer->firstname} {$customer->lastname} (<a href="{$link->getAdminLink('AdminCustomers')}&viewcustomer&id_customer={$customer->id}" target="_blank">#{$customer->id}</a>)
                </p>
            </div>
            <div class="col-sm-4">
                <label>{l s='Commande'}</label>
                <p class="control-value">
                    {$order->reference} (<a href="{$link->getAdminLink('AdminOrders')}&vieworder&id_order={$order->id}" target="_blank">#{$order->id}</a>)
                </p>
            </div>
            {if !$cartRule->quantity}
                <div class="col-sm-4">
                    <label>{l s='Statut'}</label>
                    <p class="control-value">
                        <span class="badge badge-danger">{l s='Utilisé'}</span>
                    </p>
                </div>
            {/if}
        </div>
    </div>
{/if}