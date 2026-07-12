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
    <h4 class="modal-title"><i class="icon icon-exclamation-triangle"></i>&nbsp;{l s='Confirmer la suppression'}</h4>
    {if isset($cartRules)}
        <p>{l s='Les règles de panier suivantes ont été créées dynamiquement à partir de remboursements ou d&#039;avoirs. Veuillez confirmer si vous souhaitez également les supprimer.'}</p>
    {else}
        <p>{l s='Êtes-vous sûr de vouloir supprimer les règles de panier sélectionnées ?'}</p>

    {/if}
</div>
{if isset($cartRules)}
    <div class="modal-body">
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>
                        </th>
                        <th>
                            {l s='Règle de panier'}
                        </th>
                        <th>
                            {l s='Raison'}
                        </th>
                        <th>
                            {l s='Commande'}
                        </th>
                        <th>
                            {l s='Montant'}
                        </th>
                    </tr>
                </thead>
                {foreach $cartRules as $cartRule}
                    <tr>
                        <td>
                            <input type="checkbox" class="cart_rule_to_delete" value="{$cartRule['id_cart_rule']}" checked>
                        </td>
                        <td>
                            <a href="{$link->getAdminLink('AdminCartRules')}&updatecart_rule&id_cart_rule={$cartRule['id_cart_rule']}" target="_blank">#{$cartRule['id_cart_rule']}</a>
                        </td>
                        <td>
                            {if $cartRule['generated_by'] == CartRule::GENERATED_BY_REFUND}
                                <b>{l s='Généré contre un remboursement'}</b>
                                (<a href="{$link->getAdminLink('AdminOrderRefundRequests')}&vieworder_return&id_order_return={$cartRule['id_generated_by']}" target="_blank">#{$cartRule['id_generated_by']}</a>)
                            {else if $cartRule['generated_by'] == CartRule::GENERATED_BY_ORDER_SLIP}
                                <b>{l s='Généré contre un avoir'}</b>
                                (<a href="{$link->getAdminLink('AdminPdf')}&submitAction=generateOrderSlipPDF&id_order_slip={$cartRule['id_generated_by']}" target="_blank">#{$cartRule['id_generated_by']}</a>)
                            {/if}
                            {if !$cartRule['cart_rule']->quantity}
                                <span class="badge badge-danger">{l s='Utilisé'}</span>
                            {/if}
                        </td>
                        <td>
                            <a href="{$link->getAdminLink('AdminOrders')}&vieworder&id_order={$cartRule['order']->id}" target="_blank">#{$cartRule['order']->id}</a>
                        </td>
                        <td>
                            {displayPrice price=$cartRule['cart_rule']->reduction_amount currency=$cartRule['cart_rule']->reduction_currency}
                        </td>

                    </tr>
                {/foreach}
            </table>
        </div>
    </div>
{/if}