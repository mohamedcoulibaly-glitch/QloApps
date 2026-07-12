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

<script type="text/javascript">
var Customer = new Object();
var product_url = '{$link->getAdminLink('AdminProducts', true)|addslashes}';
var ecotax_tax_excl = parseFloat({$ecotax_tax_excl});
var priceDisplayPrecision = {$smarty.const._PS_PRICE_DISPLAY_PRECISION_|intval};

$(document).ready(function () {
	Customer = {
		"hiddenField": jQuery('#id_customer'),
		"field": jQuery('#customer'),
		"container": jQuery('#customers'),
		"loader": jQuery('#customerLoader'),
		"init": function() {
			jQuery(Customer.field).typeWatch({
				"captureLength": 1,
				"highlight": true,
				"wait": 50,
				"callback": Customer.search
			}).focus(Customer.placeholderIn).blur(Customer.placeholderOut);
		},
		"placeholderIn": function() {
			if (this.value == '{l s='Tous les clients'}') {
				this.value = '';
			}
		},
		"placeholderOut": function() {
			if (this.value == '') {
				this.value = '{l s='Tous les clients'}';
			}
		},
		"search": function()
		{
			Customer.showLoader();
			jQuery.ajax({
				"type": "POST",
				"url": "{$link->getAdminLink('AdminCustomers')|addslashes}",
				"async": true,
				"dataType": "json",
				"data": {
					"ajax": "1",
					"token": "{getAdminToken tab='AdminCustomers'}",
					"tab": "AdminCustomers",
					"action": "searchCustomers",
					"customer_search": Customer.field.val()
				},
				"success": Customer.success
			});
		},
		"success": function(result)
		{
			if(result.found) {
				var html = '<ul class="list-unstyled">';
				jQuery.each(result.customers, function() {
					html += '<li><a class="fancybox" href="{$link->getAdminLink('AdminCustomers')}&id_customer='+this.id_customer+'&viewcustomer&liteDisplaying=1">'+this.firstname+' '+this.lastname+'</a>'+(this.birthday ? ' - '+this.birthday:'');
					html += ' - '+this.email;
					html += '<a onclick="Customer.select('+this.id_customer+', &#039;'+this.firstname+' '+this.lastname+'&#039;); return false;" href="#" class="btn btn-default">{l s='Choisir'}</a></li>';
				});
				html += '</ul>';
			}
			else
				html = '<div class="alert alert-warning">{l s='Aucun client trouvé'}</div>';
			Customer.hideLoader();
			Customer.container.html(html);
			jQuery('.fancybox', Customer.container).fancybox();
		},
		"select": function(id_customer, fullname)
		{
			Customer.hiddenField.val(id_customer);
			Customer.field.val(fullname);
			Customer.container.empty();
			return false;
		},
		"showLoader": function() {
			Customer.loader.fadeIn();
		},
		"hideLoader": function() {
			Customer.loader.fadeOut();
		}
	};
	Customer.init();
});
</script>
{capture assign=priceDisplayPrecisionFormat}{'%.'|cat:$smarty.const._PS_PRICE_DISPLAY_PRECISION_|cat:'f'}{/capture}
<div id="product-prices" class="panel product-tab">
	<input type="hidden" name="submitted_tabs[]" value="Prices" />
	<h3>{l s='Prix du type de chambre'}</h3>
	<div class="alert alert-info" {if !$country_display_tax_label || $tax_exclude_taxe_option}style="display:none;"{/if}>
		{l s='Vous devez entrer soit le prix de vente HT, soit le prix de vente TTC. Le champ sera calculé automatiquement.'}
	</div>
	{include file="controllers/products/multishop/check_fields.tpl" product_tab="Prices"}
	<div class="form-group">
		<div class="col-lg-1"><span class="pull-right">{include file="controllers/products/multishop/checkbox.tpl" field="wholesale_price" type="default"}</span></div>
		<label class="control-label col-lg-2" for="wholesale_price">
			<span class="label-tooltip" data-toggle="tooltip" title="{l s='Le coût opérationnel est la dépense liée à l&#039;exploitation du type de chambre. N&#039;incluez pas la taxe.'}">{if !$country_display_tax_label || $tax_exclude_taxe_option}{l s='Coût opérationnel'}{else}{l s='Coût opérationnel hors taxes'}{/if}</span>
		</label>
		<div class="col-lg-2">
			<div class="input-group">
				<span class="input-group-addon">{$currency->prefix}{$currency->suffix}</span>
				<input maxlength="27" name="wholesale_price" id="wholesale_price" type="text" value="{{toolsConvertPrice price=$product->wholesale_price}|string_format:$priceDisplayPrecisionFormat}" onchange="this.value = this.value.replace(/,/g, '.');" />
			</div>
			{if isset($pack) && $pack->isPack($product->id)}<p class="help-block">{l s='La somme des prix de gros des types de chambres dans le pack est de %s%s%s' sprintf=[$currency->prefix,{toolsConvertPrice price=$pack->noPackWholesalePrice($product->id)|string_format:$priceDisplayPrecisionFormat},$currency->suffix]}</p>{/if}
		</div>
	</div>
	<div class="form-group">
		<div class="col-lg-1"><span class="pull-right">{include file="controllers/products/multishop/checkbox.tpl" field="price" type="price"}</span></div>
		<label class="control-label col-lg-2" for="priceTE">
			<span class="label-tooltip" data-toggle="tooltip" title="{l s='Le prix de vente HT est le prix auquel vous comptez vendre ce type de chambre à vos clients. Il doit être supérieur au coût opérationnel HT : la différence entre les deux sera votre marge.'}">{if !$country_display_tax_label || $tax_exclude_taxe_option}{l s='Prix de vente'}{else}{l s='Prix de vente hors taxes'}{/if}</span>
		</label>
		<div class="col-lg-2">
			<div class="input-group">
				<span class="input-group-addon">{$currency->prefix}{$currency->suffix}</span>
				<input type="hidden" id="priceTEReal" name="price" value="{toolsConvertPrice price=$product->price}"/>
				<input size="11" maxlength="27" id="priceTE" name="price_displayed" type="text" value="{{toolsConvertPrice price=$product->price}|string_format:'%.6f'}" onchange="noComma('priceTE'); $('#priceTEReal').val(this.value);" onkeyup="$('#priceType').val('TE'); $('#priceTEReal').val(this.value.replace(/,/g, '.')); if (isArrowKey(event)) return; calcPriceTI();" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<div class="col-lg-1"><span class="pull-right">{include file="controllers/products/multishop/checkbox.tpl" field="id_tax_rules_group" type="default"}</span></div>
		<label class="control-label col-lg-2" for="id_tax_rules_group">
			{l s='Règle de taxe :'}
		</label>
		<div class="col-lg-8">
			<script type="text/javascript">
				noTax = {if $tax_exclude_taxe_option}true{else}false{/if};
				taxesArray = new Array();
				{foreach $taxesRatesByGroup as $tax_by_group}
					taxesArray[{$tax_by_group.id_tax_rules_group}] = {$tax_by_group|json_encode};
				{/foreach}
				ecotaxTaxRate = {$ecotaxTaxRate / 100};
			</script>
			<div class="row">
				<div class="col-lg-6">
					<select onchange="javascript:calcPrice(); {*unitPriceWithTax('unit');*}" name="id_tax_rules_group" id="id_tax_rules_group" {if $tax_exclude_taxe_option}disabled="disabled"{/if} >
						<option value="0">{l s='Pas de taxe'}</option>
					{foreach from=$tax_rules_groups item=tax_rules_group}
						<option value="{$tax_rules_group.id_tax_rules_group}" {if $product->getIdTaxRulesGroup() == $tax_rules_group.id_tax_rules_group}selected="selected"{/if} >
					{$tax_rules_group['name']|htmlentitiesUTF8}
						</option>
					{/foreach}
					</select>
				</div>
				<div class="col-lg-2">
					<a class="btn btn-link confirm_leave" href="{$link->getAdminLink('AdminTaxRulesGroup')|escape:'html':'UTF-8'}&amp;addtax_rules_group&amp;id_product={$product->id}"{if $tax_exclude_taxe_option} disabled="disabled"{/if}>
						<i class="icon-plus-sign"></i> {l s='Créer une nouvelle taxe'} <i class="icon-external-link-sign"></i>
					</a>
				</div>
			</div>
		</div>
	</div>
	{if $tax_exclude_taxe_option}
	<div class="form-group">
		<div class="col-lg-9 col-lg-offset-3">
			<div class="alert">
				{l s='Les taxes sont actuellement désactivées :'}
				<a href="{$link->getAdminLink('AdminTaxes')|escape:'html':'UTF-8'}">{l s='Cliquez ici pour ouvrir la page de configuration des taxes.'}</a>
				<input type="hidden" value="{$product->getIdTaxRulesGroup()}" name="id_tax_rules_group" />
			</div>
		</div>
	</div>
	{/if}
	<div class="form-group" {if !$ps_use_ecotax} style="display:none;"{/if}>
		<div class="col-lg-1"><span class="pull-right">{include file="controllers/products/multishop/checkbox.tpl" field="ecotax" type="default"}</span></div>
		<label class="control-label col-lg-2" for="ecotax">
			<span class="label-tooltip" data-toggle="tooltip" title="{l s='L&#039;écotaxe est un ensemble de taxes locales visant à « promouvoir des activités écologiquement durables via des incitations économiques ». Elle est déjà incluse dans le prix de vente : plus l&#039;écotaxe est élevée, plus votre marge sera faible.'}">{l s='Écotaxe (TTC)'}</span>
		</label>
		<div class="input-group col-lg-2">
			<span class="input-group-addon">{$currency->prefix}{$currency->suffix}</span>
			<input maxlength="27" id="ecotax" name="ecotax" type="text" value="{$product->ecotax|string_format:$priceDisplayPrecisionFormat}" onkeyup="$('#priceType').val('TI');if (isArrowKey(event))return; calcPriceTE(); this.value = this.value.replace(/,/g, '.'); if (parseInt(this.value) > getE('priceTE').value) this.value = getE('priceTE').value; if (isNaN(this.value)) this.value = 0;" />
		</div>
	</div>
	<div class="form-group" {if !$country_display_tax_label || $tax_exclude_taxe_option}style="display:none;"{/if} >
		<label class="control-label col-lg-3" for="priceTI">{l s='Prix de vente TTC'}</label>
		<div class="input-group col-lg-2">
			<span class="input-group-addon">{$currency->prefix}{$currency->suffix}</span>
			<input id="priceType" name="priceType" type="hidden" value="TE" />
			<input id="priceTI" name="priceTI" type="text" value="" onchange="noComma('priceTI');" maxlength="27" onkeyup="$('#priceType').val('TI');if (isArrowKey(event)) return;  calcPriceTE();" />
		</div>
		{if isset($pack) && $pack->isPack($product->id)}<p class="col-lg-9 col-lg-offset-3 help-block">{l s='La somme des prix des types de chambres dans le pack est de %s%s%s' sprintf=[$currency->prefix,{toolsConvertPrice price=$pack->noPackPrice($product->id)|string_format:$priceDisplayPrecisionFormat},$currency->suffix]}</p>{/if}
	</div>
	{* As no use in QloApps currently so commented *}
	{* <div class="form-group">
		<div class="col-lg-1"><span class="pull-right">{include file="controllers/products/multishop/checkbox.tpl" field="unit_price" type="unit_price"}</span></div>
		<label class="control-label col-lg-2" for="unit_price">
			<span class="label-tooltip" data-toggle="tooltip" title="{l s='When selling a pack of items, you can indicate the unit price for each item of the pack. For instance, "per bottle" or "per pound".'}">{l s='Unit price (tax excl.)'}</span>
		</label>
		<div class="col-lg-4">
			<div class="input-group">
				<span class="input-group-addon">{$currency->prefix}{$currency->suffix}</span>
				<input id="unit_price" name="unit_price" type="text" value="{$unit_price|string_format:'%.6f'}" maxlength="27" onkeyup="if (isArrowKey(event)) return ;this.value = this.value.replace(/,/g, '.'); unitPriceWithTax('unit');"/>
				<span class="input-group-addon">{l s='per'}</span>
				<input id="unity" name="unity" type="text" value="{$product->unity|htmlentitiesUTF8}"  maxlength="255" onkeyup="if (isArrowKey(event)) return ;unitySecond();" onchange="unitySecond();"/>
			</div>
		</div>
	</div> *}
	{if isset($product->unity) && $product->unity}
	<div class="form-group">
		<div class="col-lg-9 col-lg-offset-3">
			<div class="alert alert-warning">
				<span>{l s='or'}
					{$currency->prefix}<span id="unit_price_with_tax">0.00</span>{$currency->suffix}
					{l s='per'} <span id="unity_second">{$product->unity}</span>{if $ps_tax && $country_display_tax_label} {l s='(tax incl.)'}{/if}
				</span>
			</div>
		</div>
	</div>
	{/if}
	<div class="form-group">
		<div class="col-lg-1"><span class="pull-right">{include file="controllers/products/multishop/checkbox.tpl" field="on_sale" type="default"}</span></div>
		<label class="control-label col-lg-2" for="on_sale">&nbsp;</label>
		<div class="col-lg-9">
			<div class="checkbox">
				<label class="control-label" for="on_sale" >
					<input type="checkbox" name="on_sale" id="on_sale" {if $product->on_sale}checked="checked"{/if} value="1" />
					{l s='Afficher l&#039;icône « en solde » sur la page du type de chambre, et dans le texte de la liste des types de chambres.'}
				</label>
			</div>
		</div>
	</div>
	<div class="form-group">
		<div class="col-lg-9 col-lg-offset-3">
			<div class="alert alert-warning">
				<strong>{l s='Prix de vente final :'}</strong>
				<span>
					{$currency->prefix}
					<span id="finalPrice" >0.00</span>
					{$currency->suffix}
					<span{if !$ps_tax} style="display:none;"{/if}> ({l s='TTC'})</span>
				</span>
				<span{if !$ps_tax} style="display:none;"{/if} >
				{if $country_display_tax_label}
					/
				{/if}
					{$currency->prefix}
				<span id="finalPriceWithoutTax"></span>
					{$currency->suffix}
					{if $country_display_tax_label}({l s='HT'}){/if}
				</span>
			</div>
		</div>
	</div>

	<!-- by webkul -->
	{if isset($WK_ALLOW_ADVANCED_PAYMENT) && $WK_ALLOW_ADVANCED_PAYMENT}
		<div class="form-group">
			<div class="col-lg-1"><span class="pull-right">{include file="controllers/products/multishop/checkbox.tpl" field="price" type="price"}</span></div>
			<label class="control-label col-sm-2">
				<input type="hidden" name="id_adv_pmt" {if isset($adv_pay_dtl)}value="{$adv_pay_dtl['id']}"{/if}>
				<span class="label-tooltip" data-toggle="tooltip" title="{l s='Si désactivé, le paiement d&#039;acompte ne s&#039;appliquera pas à ce type de chambre.'}">
					{l s='Autoriser le paiement d&#039;acompte'}
				</span>
			</label>
			<div class="col-lg-9">
				<span class="switch prestashop-switch fixed-width-lg">
					<input type="radio" value="1" id="adv_payment_active_on" name="adv_payment_active" class="adv_payment_active" {if ((isset($adv_pay_dtl) && $adv_pay_dtl['active']) || !isset($adv_pay_dtl))}checked="checked"{/if}>
					<label for="adv_payment_active_on">{l s='Oui'}</label>
					<input type="radio" value="0" id="adv_payment_active_off" name="adv_payment_active" class="adv_payment_active" {if (isset($adv_pay_dtl) && !$adv_pay_dtl['active'])}checked="checked"{/if}>
					<label for="adv_payment_active_off">{l s='Non'}</label>
					<a class="slide-button btn"></a>
				</span>
			</div>
		</div>
		<div class="adv_payment_field">
			<div class="form-group">
				<div class="col-lg-1"><span class="pull-right">{include file="controllers/products/multishop/checkbox.tpl" field="price" type="price"}</span></div>
				<label class="control-label col-sm-2">
					<span class="label-tooltip" data-toggle="tooltip" title="{l s='Si désactivé, le paiement d&#039;acompte du type de chambre sera calculé selon les paramètres globaux.'}">
						{l s='Appliquer le paramètre de paiement d&#039;acompte du type de chambre.'}
					</span>
				</label>
				<div class="col-lg-9">
					<span class="switch prestashop-switch fixed-width-lg">
						<input type="radio" value="1" id="cal_from_on" name="cal_from" {if (isset($adv_pay_dtl) && $adv_pay_dtl['calculate_from'])}checked="checked"{/if}>
						<label for="cal_from_on">{l s='Oui'}</label>
						<input type="radio" value="0" id="cal_from_off" name="cal_from" {if ((isset($adv_pay_dtl) && !$adv_pay_dtl['calculate_from']) || !isset($adv_pay_dtl))}checked="checked"{/if}>
						<label for="cal_from_off">{l s='Non'}</label>
						<a class="slide-button btn"></a>
					</span>
				</div>
			</div>
			<div class="room_type_adv_payment_field">
				<div class="form-group">
					<div class="col-lg-1"><span class="pull-right">{include file="controllers/products/multishop/checkbox.tpl" field="price" type="price"}</span></div>
					<label class="control-label col-sm-2">{l s='Type de paiement'}</label>
					<div class="col-lg-9">
						<div class="radio">
							<label for="percent_type">
								<input type="radio" name="payment_type" class="payment_type" value="1" {if ((isset($adv_pay_dtl) && ($adv_pay_dtl['payment_type'] == 1)) || !isset($adv_pay_dtl) || !$adv_pay_dtl['payment_type'])}checked="checked"{/if}>
								{l s='Pourcentage (%) '}
							</label>
						</div>
						<div class="radio">
							<label for="fixed_type">
								<input type="radio" name="payment_type" class="payment_type" value="2" {if isset($adv_pay_dtl) && ($adv_pay_dtl['payment_type'] == 2)}checked="checked"{/if}>
								{l s='Montant'}
							</label>
						</div>
					</div>
				</div>
				<div class="form-group">
					<div class="col-lg-1"><span class="pull-right">{include file="controllers/products/multishop/checkbox.tpl" field="price" type="price"}</span></div>
					<div class="col-lg-11">

						<div class="row" id="type_percent">
							<label class="control-label col-sm-2">{l s='Valeur'}</label>
							<div class="col-sm-4 col-lg-3">
								<div class="input-group">
									<span class="input-group-addon">%</span>
									<input type="text" value="{if isset($adv_pay_dtl) && ($adv_pay_dtl['payment_type'] == 1)}{$adv_pay_dtl['value']}{/if}" name="adv_pay_percent" />
								</div>
							</div>
						</div>

						<div class="row" id="type_amount">
							<label class="control-label col-sm-2">{l s='Montant'}</label>
							<div class="col-sm-9">
								<div class="row">
									<div class="col-sm-4 col-lg-3">
										<div class="input-group">
											<span class="input-group-addon">{$currency->prefix}{$currency->suffix}</span>
											<input name="adv_pay_amount" type="text" value="{if isset($adv_pay_dtl) && ($adv_pay_dtl['payment_type'] == 2)}{{toolsConvertPrice price=$adv_pay_dtl['value']}|string_format:'%.6f'}{/if}"/>
										</div>
									</div>
								</div>
								<div class="help-block">
									{l s='Si le prix final du type de chambre est inférieur au montant du paiement d&#039;acompte pour le client, alors le client paiera le prix final (inférieur) du type de chambre.'}
								</div>
							</div>
						</div>

					</div>
				</div>
				<div class="form-group">
				<div class="col-lg-1"><span class="pull-right">{include file="controllers/products/multishop/checkbox.tpl" field="price" type="price"}</span></div>
				<label class="control-label col-sm-2">
					<span class="label-tooltip" data-toggle="tooltip" title="{l s='Si activé, le client paiera : (Prix de l&#039;acompte + taxe) et si désactivé, le client ne paiera que le prix de l&#039;acompte'}">
						{l s='Inclure la taxe'}
					</span>
				</label>
				<div class="col-lg-9">
					<span class="switch prestashop-switch fixed-width-lg">
						<input type="radio" value="1" id="adv_tax_include_on" name="adv_tax_include" {if (isset($adv_pay_dtl) && $adv_pay_dtl['tax_include']) || !isset($adv_pay_dtl)}checked="checked"{/if}>
						<label for="adv_tax_include_on">{l s='Oui'}</label>
						<input type="radio" value="0" id="adv_tax_include_off" name="adv_tax_include" {if isset($adv_pay_dtl) && !$adv_pay_dtl['tax_include']}checked="checked"{/if}>
						<label for="adv_tax_include_off">{l s='Non'}</label>
						<a class="slide-button btn"></a>
					</span>
				</div>
				</div>
			</div>
		</div>

	{/if}

	<div class="panel-footer">
		<a href="{$link->getAdminLink('AdminProducts')|escape:'html':'UTF-8'}{if isset($smarty.request.page) && $smarty.request.page > 1}&amp;submitFilterproduct={$smarty.request.page|intval}{/if}" class="btn btn-default"><i class="process-icon-cancel"></i> {l s='Annuler'}</a>
		<button type="submit" name="submitAddproduct" class="btn btn-default pull-right" disabled="disabled"><i class="process-icon-loading"></i> {l s='Enregistrer'}</button>
		<button type="submit" name="submitAddproductAndStay" class="btn btn-default pull-right" disabled="disabled"><i class="process-icon-loading"></i> {l s='Enregistrer et rester'}</button>
	</div>
</div>

<div class="panel">
	<h3>{l s='Règles de prix avancées'}</h3>
	<div class="alert alert-info">
		{l s='Vous pouvez définir des règles de prix avancées en visitant '}
		<a target="_blank" href="{$link->getAdminLink('AdminHotelFeaturePricesSettings')}">{l s='créez des règles de prix avancées.'}</a>
	</div>
	<div class="table-responsive">
		<table class="table">
			<thead>
				<tr>
					<th>#{l s='Id'}</th>
					<th>{l s='Nom de la règle'}</th>
					<th>{l s='Mode d&#039;impact'}</th>
					<th>{l s='Type d&#039;impact'}</th>
					<th>{l s='Valeur de l&#039;impact'}</th>
					<th>{l s='Date de début'}</th>
					<th>{l s='Date de fin'}</th>
					<th class="text-center">{l s='Statut'}</th>
				</tr>
			</thead>
			<tbody>
				{if isset($productFeaturePrices) && $productFeaturePrices}
					{foreach $productFeaturePrices as $featurePlan}
						<tr>
							<td>
								{$featurePlan['id_feature_price']}
							</td>
							<td>
								{$featurePlan['feature_price_name']}
							</td>
							<td>
								{if $featurePlan['impact_way'] == HotelRoomTypeFeaturePricing::IMPACT_WAY_DECREASE}
									{l s='Diminuer'}
								{else}
									{l s='Augmenter'}
								{/if}
							</td>
							<td>
								{if $featurePlan['impact_type'] == HotelRoomTypeFeaturePricing::IMPACT_TYPE_PERCENTAGE}
									{l s='Pourcentage'}
								{else}
									{l s='Montant fixe'}
								{/if}
							</td>
							<td>
								{if $featurePlan['impact_type'] == HotelRoomTypeFeaturePricing::IMPACT_TYPE_PERCENTAGE}
									{$featurePlan['impact_value']|round:2}%
								{else}
									{displayPrice price=$featurePlan['impact_value']}
								{/if}
							</td>
							<td>
								{dateFormat date=$featurePlan['date_from'] full=0}
							</td>
							<td>
								{if $featurePlan['date_selection_type'] == HotelRoomTypeFeaturePricing::DATE_SELECTION_TYPE_RANGE}
									{dateFormat date=$featurePlan['date_to'] full=0}
								{else}
									<span class="badge badge-success">{l s='Date spécifique'}</span>
								{/if}
							</td>
							<td class="text-center">
								{if $featurePlan['active'] == 1}
									<i class="icon-check text-success"></i>
								{else}
									<i class="icon-times text-danger"></i>
								{/if}
							</td>
						</tr>
					{/foreach}
				{else}
					<tr>
						<td class="text-center" colspan="6">
							<i class="icon-warning-sign"></i> {l s='Aucune règle de prix avancée.'}
						</td>
					</tr>
				{/if}
			</tbody>
		</table>
	</div>
</div>

{if isset($specificPriceModificationForm)}
<div class="panel">
	<h3>{l s='Prix spécifiques'}</h3>
	<div class="alert alert-info">
		{l s='Vous pouvez définir des prix spécifiques pour les clients appartenant à différents groupes, différents pays, etc.'}
	</div>
	<div class="form-group">
		<div class="col-lg-12">
			<a class="btn btn-default" href="#" id="show_specific_price">
				<i class="icon-plus-sign"></i> {l s='Ajouter un nouveau prix spécifique'}
			</a>
			<a class="btn btn-default" href="#" id="hide_specific_price" style="display:none">
				<i class="icon-remove text-danger"></i> {l s='Annuler le nouveau prix spécifique'}
			</a>
		</div>
	</div>
	<script type="text/javascript">
		var product_prices = new Array();
		{foreach from=$combinations item='combination'}
			product_prices['{$combination.id_product_attribute}'] = '{$combination.price|@addcslashes:'\''}';
		{/foreach}
	</script>
	<div id="add_specific_price" class="well clearfix" style="display: none;">
		<div class="col-lg-12">
			<div class="form-group">
				<label class="control-label col-lg-2" for="{if !$multi_shop}spm_currency_0{else}sp_id_shop{/if}">{l s='For'}</label>
				<div class="col-lg-9">
					<div class="row">
					{if !$multi_shop}
						<input type="hidden" name="sp_id_shop" value="1" />
					{else}
						<div class="col-lg-3">
							<select name="sp_id_shop" id="sp_id_shop">
								{if !$admin_one_shop}<option value="0">{l s='Toutes les boutiques'}</option>{/if}
								{foreach from=$shops item=shop}
								<option value="{$shop.id_shop}">{$shop.name|htmlentitiesUTF8}</option>
								{/foreach}
							</select>
						</div>
					{/if}
						<div class="col-lg-3">
							<select name="sp_id_currency" id="spm_currency_0" onchange="changeCurrencySpecificPrice(0);">
								<option value="0">{l s='Toutes les devises'}</option>
								{foreach from=$currencies item=curr}
								<option value="{$curr.id_currency}">{$curr.name|htmlentitiesUTF8}</option>
								{/foreach}
							</select>
						</div>
						<div class="col-lg-3">
							<select name="sp_id_country" id="sp_id_country">
								<option value="0">{l s='Tous les pays'}</option>
								{foreach from=$countries item=country}
								<option value="{$country.id_country}">{$country.name|htmlentitiesUTF8}</option>
								{/foreach}
							</select>
						</div>
						<div class="col-lg-3">
							<select name="sp_id_group" id="sp_id_group">
								<option value="0">{l s='Tous les groupes'}</option>
								{foreach from=$groups item=group}
								<option value="{$group.id_group}">{$group.name}</option>
								{/foreach}
							</select>
						</div>
					</div>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-lg-2" for="customer">{l s='Client'}</label>
				<div class="col-lg-4">
					<input type="hidden" name="sp_id_customer" id="id_customer" value="0" />
					<div class="input-group">
						<input type="text" name="customer" value="{l s='Tous les clients'}" id="customer" autocomplete="off" />
						<span class="input-group-addon"><i id="customerLoader" class="icon-refresh icon-spin" style="display: none;"></i> <i class="icon-search"></i></span>
					</div>
				</div>
			</div>
			<div class="form-group">
				<div class="col-lg-10 col-lg-offset-2">
					<div id="customers"></div>
				</div>
			</div>
			{if $combinations|@count != 0}
			<div class="form-group">
				<label class="control-label col-lg-2" for="sp_id_product_attribute">{l s='Combinaison :'}</label>
				<div class="col-lg-4">
					<select id="sp_id_product_attribute" name="sp_id_product_attribute">
						<option value="0">{l s='Appliquer à toutes les combinaisons'}</option>
					{foreach from=$combinations item='combination'}
						<option value="{$combination.id_product_attribute}">{$combination.attributes}</option>
					{/foreach}
					</select>
				</div>
			</div>
			{/if}
			<div class="form-group">
				<label class="control-label col-lg-2" for="sp_from">{l s='Disponible'}</label>
				<div class="col-lg-9">
					<div class="row">
						<div class="col-lg-4">
							<div class="input-group">
								<span class="input-group-addon">{l s='depuis'}</span>
								<input type="text" name="sp_from" class="datepicker" value="" style="text-align: center" id="sp_from" />
								<span class="input-group-addon"><i class="icon-calendar-empty"></i></span>
							</div>
						</div>
						<div class="col-lg-4">
							<div class="input-group">
								<span class="input-group-addon">{l s='to'}</span>
								<input type="text" name="sp_to" class="datepicker" value="" style="text-align: center" id="sp_to" />
								<span class="input-group-addon"><i class="icon-calendar-empty"></i></span>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-lg-2" for="sp_price">{l s='Prix du type de chambre'}
					{if $country_display_tax_label}
						{l s='(tax excl.)'}
					{/if}
				</label>
				<div class="col-lg-9">
					<div class="row">
						<div class="col-lg-4">
							<div class="input-group">
								<span class="input-group-addon">{$currency->prefix}{$currency->suffix}</span>
								<input type="text" disabled="disabled" name="sp_price" id="sp_price" value="{$product->price|string_format:$priceDisplayPrecisionFormat}" onchange="noComma('sp_price');" />
							</div>
							<p class="checkbox">
								<label for="leave_bprice">{l s='Laisser le prix de base :'}</label>
								<input type="checkbox" id="leave_bprice" name="leave_bprice"  value="1" checked="checked"  />
							</p>
						</div>
					</div>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-lg-2" for="sp_reduction">{l s='Appliquer une remise de'}</label>
				<div class="col-lg-4">
					<div class="row">
						<div class="col-lg-3">
							<input type="text" name="sp_reduction" id="sp_reduction" value="0.00" onchange="noComma('sp_reduction');"/>
						</div>
						<div class="col-lg-6">
							<select name="sp_reduction_type" id="sp_reduction_type">
								<option value="amount" selected="selected">{$currency->name|escape:'html':'UTF-8'}</option>
								<option value="percentage">{l s='%'}</option>
							</select>
						</div>
						<div class="col-lg-3">
							<select name="sp_reduction_tax" id="sp_reduction_tax">
								<option value="0">{l s='HT'}</option>
								<option value="1" selected="selected">{l s='TTC'}</option>
							</select>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		var currencyName = '{$currency->name|escape:'html':'UTF-8'|@addcslashes:'\''}';
		$(document).ready(function(){
			var adv_payment = $(".adv_payment_active:checked").val();
			if (adv_payment == 1)
				$(".adv_payment_field").show();
			else
				$(".adv_payment_field").hide();

			$(".adv_payment_active").on('change',function(){
				var adv_payment = $(".adv_payment_active:checked").val();
				if (adv_payment == 1)
					$(".adv_payment_field").show();
				else if (adv_payment == 0)
					$(".adv_payment_field").hide();
			});
			var cal_from = $('[name="cal_from"]:checked').val();
			if (cal_from == 1)
				$(".room_type_adv_payment_field").show();
			else
				$(".room_type_adv_payment_field").hide();
			$('[name="cal_from"]').on('change',function(){
				var cal_from = $('[name="cal_from"]:checked').val();
				if (cal_from == 1)
					$(".room_type_adv_payment_field").show();
				else if (cal_from == 0)
					$(".room_type_adv_payment_field").hide();
			});
			var payment_type = $(".payment_type:checked").val();
			if (payment_type == 1)
			{
				$("#type_percent").show();
				$("#type_amount").hide();
			}
			else if (payment_type == 2)
			{
				$("#type_percent").hide();
				$("#type_amount").show();
			}

			$(".payment_type").on('change',function()
			{
				var payment_type = $(".payment_type:checked").val();
				if (payment_type == 1)
				{
					$("#type_percent").show();
					$("#type_amount").hide();
				}
				else if (payment_type == 2)
				{
					$("#type_percent").hide();
					$("#type_amount").show();
				}
			});

			product_prices['0'] = $('#sp_current_ht_price').html();
			$('#id_product_attribute').change(function() {
				$('#sp_current_ht_price').html(product_prices[$('#id_product_attribute option:selected').val()]);
			});
			$('#leave_bprice').click(function() {
				if (this.checked)
					$('#sp_price').attr('disabled', 'disabled');
				else
					$('#sp_price').removeAttr('disabled');
			});
			$('.datepicker').datetimepicker({
				prevText: '',
				nextText: '',
				dateFormat: 'yy-mm-dd',
				// Define a custom regional settings in order to use PrestaShop translation tools
				currentText: '{l s='Maintenant' js=1}',
				closeText: '{l s='Terminé' js=1}',
				ampm: false,
				amNames: ['AM', 'A'],
				pmNames: ['PM', 'P'],
				timeFormat: 'hh:mm:ss tt',
				timeSuffix: '',
				timeOnlyTitle: '{l s='Choisir l&#039;heure' js=1}',
				timeText: '{l s='Heure' js=1}',
				hourText: '{l s='Heure' js=1}',
				minuteText: '{l s='Minute' js=1}'
			});
			$('#sp_reduction_type').on('change', function() {
				if (this.value == 'percentage')
					$('#sp_reduction_tax').hide();
				else
					$('#sp_reduction_tax').show();
			});
		});
	</script>
	<div class="table-responsive">
	<table id="specific_prices_list" class="table table-bordered">
		<thead>
			<tr>
				<th>{l s='Règle'}</th>
				{* <th>{l s='Combinaison'}</th> *}
				{if $multi_shop}<th>{l s='Boutique'}</th>{/if}
				<th>{l s='Devise'}</th>
				<th>{l s='Pays'}</th>
				<th>{l s='Group'}</th>
				<th>{l s='Client'}</th>
				{if $country_display_tax_label}
					<th>{l s='Prix fixe (HT)'}</th>
				{else}
					<th>{l s='Prix fixe'}</th>
				{/if}
				<th>{l s='Impact'}</th>
				<th>{l s='Période'}</th>
				<th>{l s='Action'}</th>
			</tr>
		</thead>
		<tbody>
			{$specificPriceModificationForm}
				<script type="text/javascript">
					$(document).ready(function() {
						delete_price_rule = '{l s="Voulez-vous vraiment supprimer cette règle de prix ?"}';
						calcPriceTI();
						//unitPriceWithTax('unit');
					});
				</script>
			{/if}
