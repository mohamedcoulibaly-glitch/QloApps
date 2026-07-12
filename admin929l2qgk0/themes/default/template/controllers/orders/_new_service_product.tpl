{*
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
<tr id="new_normal_product" style="display:none">
	<td style="display:none;" colspan="2">
		<input type="hidden" id="add_normal_product_product_id" name="add_product[product_id]" value="0" />

		<div class="form-group">
			<label>{l s='Produit :'}</label>
			<div class="input-group">
				<input type="text" id="add_normal_product_product_name" value=""/>
				<div class="input-group-addon">
					<i class="icon-search"></i>
				</div>
			</div>
		</div>

		{* <div id="add_product_product_attribute_area" class="form-group" style="display: none;">
			<label>{l s='Combinaisons'}</label>
			<select name="add_product[product_attribute_id]" id="add_normal_product_attribute_id"></select>
		</div>

		<div id="add_product_product_warehouse_area" class="form-group" style="display: none;">
			<label>{l s='Entrepôt'}</label>
			<select  id="add_product_warehouse" name="add_product_warehouse"></select>
		</div> *}
	</td>
	{if ($order->getTaxCalculationMethod() != $smarty.const.PS_TAX_EXC)}
	<td></td>
	{/if}
	<td style="display:none;">
		<div class="row">
			<div class="input-group fixed-width-xl">
				{if $currency->format % 2}<div class="input-group-addon">{$currency->sign} {l s='HT'}</div>{/if}
				<input type="text" name="add_product[product_price_tax_excl]" id="add_normal_product_price_tax_excl" value="" disabled="disabled" readonly="true"/>
				{if !($currency->format % 2)}<div class="input-group-addon">{$currency->sign} {l s='HT'}</div>{/if}
			</div>
		</div>
		<br/>
		<div class="row">
			<div class="input-group fixed-width-xl">
				{if $currency->format % 2}<div class="input-group-addon">{$currency->sign} {l s='TTC'}</div>{/if}
				<input type="text" name="add_product[product_price_tax_incl]" id="add_normal_product_price_tax_incl" value="" disabled="disabled" readonly="true" />
				{if !($currency->format % 2)}<div class="input-group-addon">{$currency->sign} {l s='TTC'}</div>{/if}
			</div>
		</div>
	</td>

	<td style="display:none;" class="productQuantity">
		<input type="number" class="form-control fixed-width-sm" name="add_product[product_quantity]" id="add_normal_product_quantity" value="1" disabled="disabled" />
	</td>
	{if ($order->hasBeenPaid())}<td style="display:none;" class="productQuantity"></td>{/if}
	{if $display_warehouse}<td></td>{/if}
	{if ($order->hasBeenDelivered())}<td style="display:none;" class="productQuantity"></td>{/if}
	<td style="display:none;" class="productQuantity" id="add_normal_product_stock">0</td>
	<td style="display:none;" id="add_normal_product_total">{displayPrice price=0 currency=$currency->id}</td>
	<td style="display:none;" colspan="2">
		{if sizeof($invoices_collection)}
		<select class="form-control" name="add_product[invoice]" id="add_normal_product_invoice" disabled="disabled">
			<optgroup class="existing" label="{l s='Existant'}">
				{foreach from=$invoices_collection item=invoice}
				<option value="{$invoice->id}">{$invoice->getInvoiceNumberFormatted($current_id_lang)}</option>
				{/foreach}
			</optgroup>
			<optgroup label="{l s='Nouveau'}">
				<option value="0">{l s='Créer une nouvelle facture'}</option>
			</optgroup>
		</select>
		{/if}
	</td>
	<td style="display:none;">
		<button type="button" class="btn btn-default" id="cancelAddNormalProduct">
			<i class="icon-remove text-danger"></i>
			{l s='Annuler'}
		</button>
		<button type="button" class="btn btn-default" id="submitAddNormalProduct" disabled="disabled">
			<i class="icon-ok text-success"></i>
			{l s='Ajouter'}
		</button>
	</td>
</tr>

{* <tr id="new_invoice" style="display:none">
	<td colspan="10">
		<h4>{l s='New invoice information'}</h4>
		<div class="form-horizontal">
			<div class="form-group">
				<label class="control-label col-lg-3">{l s='Transporteur'}</label>
				<div class="col-lg-9">
					<p class="form-control-static"><strong>{$carrier->name}</strong></p>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-lg-3">{l s='Shipping Cost'}</label>
				<div class="col-lg-9">
					<div class="checkbox">
						<label>
							<input type="checkbox" name="add_invoice[free_shipping]" value="1" />
							{l s='Livraison gratuite'}
						</label>
						<p class="help-block">{l s='If you don&#039;t select "Free shipping," the normal shipping cost will be applied.'}</p>
					</div>
				</div>
			</div>
		</div>
	</td>
</tr> *}