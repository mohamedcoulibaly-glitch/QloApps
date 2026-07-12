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

<!--start filter module-->
<form method="post" class="form-inline">
<div class="row">
	<div class="col-lg-8">
		<div class="form-group">
			<label>{l s='Filtrer par'}</label>
		</div>

		<div class="form-group">
			<select name="module_status" id="module_status_filter" class="form-control {if isset($showEnabledModules) && $showEnabledModules && $showEnabledModules != enabledDisabled}active{/if}">
				<option value="enabledDisabled" {if $showEnabledModules eq 'enabledDisabled'}selected="selected"{/if}>{l s='Activés & Désactivés'}</option>
				<option value="enabled" {if $showEnabledModules eq 'enabled'}selected="selected"{/if}>{l s='Modules activés'}</option>
				<option value="disabled" {if $showEnabledModules eq 'disabled'}selected="selected"{/if}>{l s='Modules désactivés'}</option>
			</select>
		</div>
	</div>
	<div class="col-lg-4">
		<div class="form-group">
			<label>{l s='Auteurs'}</label>
			<select class="filter {if isset($showTypeModules) && $showTypeModules && $showTypeModules != allModules}active{/if}" name="module_type" id="module_type_filter">
				<!-- <option value="allModules" {if $showTypeModules eq 'allModules'}selected="selected"{/if}>{l s='Tous les modules'}</option>
				<option value="nativeModules" {if $showTypeModules eq 'nativeModules'}selected="selected"{/if}>{l s='Modules gratuits'}</option>
				<option value="partnerModules" {if $showTypeModules eq 'partnerModules'}selected="selected"{/if}>{l s='Modules partenaires (Gratuits)'}</option>
				<option value="mustHaveModules" {if $showTypeModules eq 'mustHaveModules'}selected="selected"{/if}>{l s='Indispensables'}</option>
				{if isset($logged_on_addons)}<option value="addonsModules" {if $showTypeModules eq 'addonsModules'}selected="selected"{/if}>{l s='Modules achetés sur Addons'}</option>{/if} -->
				<option value="allModules" {if $showTypeModules eq 'allModules'}selected="selected"{/if}>{l s='Tous les auteurs'}</option>
				{foreach from=$list_modules_authors key=module_author item=status}
					<option value="authorModules[{$module_author}]" {if $status eq "selected"}selected{/if}>{$module_author|truncate:20:'...'}</option>
				{/foreach}
				<!-- <option value="otherModules" {if $showTypeModules eq 'otherModules'}selected="selected"{/if}>{l s='Autres modules'}</option> -->
			</select>
		</div>
	</div>
</div>
	<!-- <span>
		<select class="filter fixed-width-lg" name="country_module_value" id="country_module_value_filter">
			<option value="0" >{l s='Tous les pays'}</option>
			<option value="1" {if $showCountryModules eq 1}selected="selected"{/if}>{l s='Pays actuel :'} {$nameCountryDefault}</option>
		</select>
	</span> -->
	<!-- <span class="pull-right">
		<button class="btn btn-default " type="submit" name="resetFilterModules">
			<i class="icon-eraser"></i>
			{l s='Réinitialiser'}
		</button>
		<button class="btn btn-default " name="filterModules" id="filterModulesButton" type="submit">
			<i class="icon-filter"></i>
			{l s='Filtrer'}
		</button>
	</span> -->
</form>
<!--end filter module-->
