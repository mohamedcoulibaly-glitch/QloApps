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

<div class="panel">
	<div class="panel-heading">
		{if isset($edit)}
			<i class='icon-pencil'></i>&nbsp{l s='Modifier la règle de prix avancée' mod='hotelreservationsystem'}
		{else}
			<i class='icon-plus'></i>&nbsp{l s='Ajouter une nouvelle règle de prix avancée' mod='hotelreservationsystem'}
		{/if}
	</div>
	<form id="{$table}_form" class="defaultForm form-horizontal" action="{$current}&{if !empty($submit_action)}{$submit_action}{/if}&token={$token}" method="post" enctype="multipart/form-data" {if isset($style)}style="{$style}"{/if}>
		{if isset($edit)}
			<input type="hidden" value="{$objFeaturePrice->id|escape:'html':'UTF-8'}" name="id_feature_price" />
		{/if}

		<div class="form-group">
			<label class="col-sm-3 control-label required" for="feature_price_name" >
				{l s='Nom de la règle de prix avancée ' mod='hotelreservationsystem'}
			</label>
			<div class="col-lg-3">
				{foreach from=$languages item=language}
					{assign var="feature_price_name" value="feature_price_name_`$language.id_lang`"}
					<input type="text" id="{$feature_price_name}" name="{$feature_price_name}" value="{if isset($objFeaturePrice->feature_price_name[$language.id_lang]) && $objFeaturePrice->feature_price_name[$language.id_lang]}{$objFeaturePrice->feature_price_name[$language.id_lang]}{else if isset($smarty.post.$feature_price_name)}{$smarty.post.$feature_price_name}{/if}" data-lang-name="{$language.name}" placeholder="{l s='Saisissez le nom de la règle de prix avancée' mod='hotelreservationsystem'}" class="form-control feature_price_name_all" {if $currentLang.id_lang != $language.id_lang}style="display:none;"{/if}/>
				{/foreach}
			</div>
			{if $languages|@count > 1}
				<div class="col-lg-2">
					<button type="button" id="feature_price_rule_lang_btn" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
						{$currentLang.iso_code}
						<span class="caret"></span>
					</button>
					<ul class="dropdown-menu">
						{foreach from=$languages item=language}
							<li>
								<a href="javascript:void(0)" onclick="showFeaturePriceRuleLangField('{$language.iso_code}', {$language.id_lang});">{$language.name}</a>
							</li>
						{/foreach}
					</ul>
				</div>
			{/if}
			<div class="col-lg-9 col-lg-offset-3">
				<div class="help-block">
					{l s='Utilisez {room_type_name} pour générer des noms de règles de prix dynamiques.' mod='hotelreservationsystem'}
				</div>
			</div>
		</div>

		{if !isset($objFeaturePrice) || !$objFeaturePrice->id}
			<div class="form-group">
				<label class="control-label col-lg-3">
					<span class="label-tooltip" data-toggle="tooltip" data-html="true" title="" data-original-title="{l s='Activer cette option pour créer des règles de prix avancées pour plusieurs types de chambres.' mod='hotelreservationsystem'}">
						{l s='Créer pour plusieurs types de chambres' mod='hotelreservationsystem'}
					</span>
				</label>
				<div class="col-lg-9 ">
					<span class="switch prestashop-switch fixed-width-lg">
						<input type="radio" {if isset($smarty.post.create_multiple) && $smarty.post.create_multiple == 1}checked="checked" {/if} value="1" id="create_multiple_on" name="create_multiple">
						<label for="create_multiple_on">{l s='Oui' mod='hotelreservationsystem'}</label>
						<input {if !isset($smarty.post.create_multiple) || isset($smarty.post.create_multiple) && $smarty.post.create_multiple == 0} checked="checked" {/if} type="radio" value="0" id="create_multiple_off" name="create_multiple">
						<label for="create_multiple_off">{l s='Non' mod='hotelreservationsystem'}</label>
						<a class="slide-button btn"></a>
					</span>
				</div>
			</div>
			{if isset($hotel_tree)}
				<div class="form-group room-type-name-tree" style="display:none;">
					<label class="col-sm-3 control-label required" for="room_types">
						<span class="label-tooltip" data-toggle="tooltip" data-html="true" title="" data-original-title="{l s='Sélectionnez les types de chambres pour lesquels vous allez créer cette règle de prix avancée.' mod='hotelreservationsystem'}">
							{l s='Types de chambres' mod='hotelreservationsystem'}
						</span>
					</label>
					<div class="col-sm-7">
						{$hotel_tree}
					</div>
				</div>
			{/if}
		{/if}

		<div class="form-group room-type-name">
			<label class="col-sm-3 control-label required" for="room_type_name" >
				{l s='Type de chambre' mod='hotelreservationsystem'}
			</label>
			<div class="col-sm-3">
				<input autocomplete="off" type="text" id="room_type_name" name="room_type_name" class="form-control" placeholder= "{l s='Saisissez le nom du type de chambre' mod='hotelreservationsystem'}" value="{if isset($smarty.post.room_type_name)}{$smarty.post.room_type_name}{elseif isset($productName)}{$productName}{/if}"/>
				<input type="hidden" id="room_type_id" name="room_type_id" class="form-control" value="{if isset($smarty.post.room_type_id)}{$smarty.post.room_type_id}{elseif isset($objFeaturePrice->id_product)}{$objFeaturePrice->id_product}{else}0{/if}"/>
				<div class="dropdown">
					<ul class="room_type_search_results_ul"></ul>
				</div>
				<p class="error-block" style="display:none; color: #CD5D5D;">{l s='Aucune correspondance trouvée pour cette recherche. Veuillez essayer avec un nom existant.' mod='hotelreservationsystem'}</p>
			</div>
			<div class="col-lg-9 col-lg-offset-3">
				<div class="help-block">
					{l s='Saisissez le nom du type de chambre et sélectionnez la chambre pour laquelle vous allez créer cette règle de prix avancée.' mod='hotelreservationsystem'}
				</div>
			</div>
		</div>

		<div class="row">
			<label class="col-sm-3 control-label required" for="feature_price_name" >
				{l s='Restrictions' mod='hotelreservationsystem'}
			</label>
			<div class="col-sm-6 col-xs-9">
				<div class="panel">
					<div id="advanced_price_rule_group">
						{if isset($smarty.post.restriction) && $smarty.post.restriction}
							{assign var='restrictions' value=$smarty.post.restriction}
						{/if}
						{if isset($restrictions) && $restrictions}
							{foreach $restrictions as $key => $restriction}
								{include file="../../../_partials/feature_price_rules.tpl" key=$key}
							{/foreach}
						{else}
							{include file="../../../_partials/feature_price_rules.tpl" key=0 collapse=true}
						{/if}
					</div>
					<a id="add_more_dates_button" class="btn btn-default">
						<i class="icon icon-plus"></i> {l s='Ajouter plus de restrictions' mod='hotelreservationsystem'}
					</a>
				</div>
			</div>
		</div>

		<div class="form-group">
            <label for="Price Impact Way" class="control-label col-lg-3">
              {l s='Mode d\'impact' mod='hotelreservationsystem'}
            </label>
            <div class="col-lg-3">
				<select class="form-control" name="price_impact_way" id="price_impact_way">
					<option value="{HotelRoomTypeFeaturePricing::IMPACT_WAY_DECREASE}" {if (isset($smarty.post.price_impact_way) && $smarty.post.price_impact_way == HotelRoomTypeFeaturePricing::IMPACT_WAY_DECREASE) || (isset($objFeaturePrice->impact_way) && $objFeaturePrice->impact_way == HotelRoomTypeFeaturePricing::IMPACT_WAY_DECREASE && !isset($smarty.post.price_impact_way))}selected = "selected"{/if}>
					  {l s='Diminuer le prix' mod='hotelreservationsystem'}
					</option>
					<option value="{HotelRoomTypeFeaturePricing::IMPACT_WAY_INCREASE}" {if (isset($smarty.post.price_impact_way) && $smarty.post.price_impact_way == HotelRoomTypeFeaturePricing::IMPACT_WAY_INCREASE) || (isset($objFeaturePrice->impact_way) && $objFeaturePrice->impact_way == HotelRoomTypeFeaturePricing::IMPACT_WAY_INCREASE && !isset($smarty.post.price_impact_way))}selected = "selected"{/if}>
					  {l s='Augmenter le prix' mod='hotelreservationsystem'}
					</option>
					<option value="{HotelRoomTypeFeaturePricing::IMPACT_WAY_FIX_PRICE}" {if (isset($smarty.post.price_impact_way) && $smarty.post.price_impact_way == HotelRoomTypeFeaturePricing::IMPACT_WAY_FIX_PRICE) || (isset($objFeaturePrice->impact_way) && $objFeaturePrice->impact_way == HotelRoomTypeFeaturePricing::IMPACT_WAY_FIX_PRICE && !isset($smarty.post.price_impact_way))}selected = "selected"{/if}>
						{l s='Prix fixe' mod='hotelreservationsystem'}
					</option>
				</select>
			</div>
		</div>

		<div class="form-group">
            <label for="Price Impact Type" class="control-label col-lg-3">
              {l s='Type d\'impact' mod='hotelreservationsystem'}
            </label>
            <div class="col-lg-3">
				<select class="form-control" name="price_impact_type" id="price_impact_type" {if (isset($smarty.post.price_impact_way) && $smarty.post.price_impact_way == HotelRoomTypeFeaturePricing::IMPACT_WAY_FIX_PRICE) || (isset($objFeaturePrice->impact_way) && $objFeaturePrice->impact_way == HotelRoomTypeFeaturePricing::IMPACT_WAY_FIX_PRICE && !isset($smarty.post.price_impact_way))}disabled="disabled"{/if}>
					<option value="{HotelRoomTypeFeaturePricing::IMPACT_TYPE_PERCENTAGE}" {if (isset($smarty.post.price_impact_type) && $smarty.post.price_impact_type == HotelRoomTypeFeaturePricing::IMPACT_TYPE_PERCENTAGE) || (isset($objFeaturePrice->impact_type) && $objFeaturePrice->impact_type == HotelRoomTypeFeaturePricing::IMPACT_TYPE_PERCENTAGE && !isset($smarty.post.price_impact_type))}selected = "selected"{/if}>
					  {l s='Pourcentage' mod='hotelreservationsystem'}
					</option>
					<option value="{HotelRoomTypeFeaturePricing::IMPACT_TYPE_FIXED_PRICE}" {if (isset($smarty.post.price_impact_way) && $smarty.post.price_impact_way == HotelRoomTypeFeaturePricing::IMPACT_WAY_FIX_PRICE) || (isset($objFeaturePrice->impact_way) && $objFeaturePrice->impact_way == HotelRoomTypeFeaturePricing::IMPACT_WAY_FIX_PRICE && !isset($smarty.post.price_impact_way)) || (isset($smarty.post.price_impact_type) && $smarty.post.price_impact_type == HotelRoomTypeFeaturePricing::IMPACT_TYPE_FIXED_PRICE) || (isset($objFeaturePrice->impact_type) && $objFeaturePrice->impact_type == HotelRoomTypeFeaturePricing::IMPACT_TYPE_FIXED_PRICE && !isset($smarty.post.price_impact_type))}selected = "selected"{/if}>
					  {l s='Montant' mod='hotelreservationsystem'}
					</option>
				</select>
			</div>
		</div>

		<div class="form-group">
			<label class="col-sm-3 control-label required" for="impact_value" >
				{l s='Valeur d\'impact' mod='hotelreservationsystem'}({l s='ht.' mod='hotelreservationsystem'})
			</label>
			<div class="col-lg-3">
				<div class="input-group">
					<span class="input-group-addon payment_type_icon">{if isset($edit)} {if $objFeaturePrice->impact_type == HotelRoomTypeFeaturePricing::IMPACT_TYPE_FIXED_PRICE}{$defaultcurrency_sign}{else}%{/if}{else}%{/if}</span>
					<input type="text" id="impact_value" name="impact_value" value="{if isset($smarty.post.impact_value) && $smarty.post.impact_value}{$smarty.post.impact_value}{elseif isset($objFeaturePrice->impact_value)}{$objFeaturePrice->impact_value}{/if}"/>
				</div>
			</div>
		</div>

		<div class="form-group">
			<label class="control-label col-lg-3">
				<span>
					{l s='Activer la règle de prix avancée' mod='hotelreservationsystem'}
				</span>
			</label>
			<div class="col-lg-9 ">
				<span class="switch prestashop-switch fixed-width-lg">
					<input type="radio" {if isset($smarty.post.enable_feature_price)} {if $smarty.post.enable_feature_price} checked="checked" {/if}{elseif isset($edit) && $objFeaturePrice->active==1} checked="checked" {else}checked="checked"{/if} value="1" id="enable_feature_price_on" name="enable_feature_price">
					<label for="enable_feature_price_on">{l s='Oui' mod='hotelreservationsystem'}</label>
					<input  {if isset($smarty.post.enable_feature_price)} {if !$smarty.post.enable_feature_price} checked="checked"{/if} {elseif isset($edit) && $objFeaturePrice->active==0} checked="checked" {/if} type="radio" value="0" id="enable_feature_price_off" name="enable_feature_price">
					<label for="enable_feature_price_off">{l s='Non' mod='hotelreservationsystem'}</label>
					<a class="slide-button btn"></a>
				</span>
			</div>
		</div>

		{* select group accesses *}
		<div class="form-group">
			<label class="control-label required col-lg-3">
				<span class="label-tooltip required" data-toggle="tooltip" data-html="true" data-original-title="{l s='Sélectionnez tous les groupes que vous souhaitez appliquer à cette règle de prix avancée.' mod='hotelreservationsystem'}">{l s='Accès aux groupes' mod='hotelreservationsystem'}</span>
			</label>
			<div class="col-lg-6">
				<div class="table-responsive">
					<table class="table table-bordered">
						<thead>
							<tr>
								<th class="text-center"></th>
								<th class="text-center">{l s='Groupe' mod='hotelreservationsystem'}</th>
							</tr>
						</thead>
						<tbody>
							{if isset($groups) && $groups}
								{foreach $groups as $group}
									<tr>
										<td class="text-center">
											<input type="checkbox" name="groupBox[]" value="{$group['id_group']|escape:'html':'UTF-8'}"
												{if isset($feature_price_groups) && $feature_price_groups && $group['id_group']|in_array:$feature_price_groups}
													checked
												{elseif empty($objFeaturePrice->id)}
													checked
												{/if}
											/>
										</td>
										<td class="text-center">{$group['name']|escape:'html':'UTF-8'}</td>
									</tr>
								{/foreach}
							{else}
								<tr>
									<td class="list-empty" colspan="2">
										<div class="list-empty-msg">
											<i class="icon-warning-sign list-empty-icon"></i>
											{l s='Aucun groupe disponible' mod='hotelreservationsystem'}
										</div>
									</td>
								</tr>
							{/if}
						</tbody>
					</table>
				</div>
			</div>
		</div>

		<div class="panel-footer">
			<a href="{$link->getAdminLink('AdminHotelFeaturePricesSettings')|escape:'html':'UTF-8'}" class="btn btn-default">
				<i class="process-icon-cancel"></i>{l s='Annuler' mod='hotelreservationsystem'}
			</a>
			<button type="submit" name="submitAdd{$table|escape:'html':'UTF-8'}" class="btn btn-default pull-right">
				<i class="process-icon-save"></i> {l s='Enregistrer' mod='hotelreservationsystem'}
			</button>
			<button type="submit" name="submitAdd{$table|escape:'html':'UTF-8'}AndStay" class="btn btn-default pull-right">
				<i class="process-icon-save"></i> {l s='Enregistrer et rester' mod='hotelreservationsystem'}
			</button>
		</div>
	</form>
</div>

{strip}
	{addJsDef autocomplete_room_search_url = $link->getAdminLink('AdminHotelFeaturePricesSettings')}
	{addJsDef defaultcurrency_sign = $defaultcurrency_sign mod='hotelreservationsystem'}
	{addJsDef booking_date_from = $date_from mod='hotelreservationsystem'}
{/strip}

{block name=script}
	<script type="text/javascript">
		var id_language = {$defaultFormLanguage|intval};
		allowEmployeeFormLang = {$allowEmployeeFormLang|intval};
	</script>
{/block}
