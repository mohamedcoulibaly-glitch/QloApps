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

{block name="override_tpl"}
<div class="row">
	<div class="col-lg-6">
		<div class="panel">
			<h3><i class="icon-group"></i> {l s='Informations du groupe'}</h3>
			<h2><i class="icon-group"></i> {$group->name[$language->id]}</h2>
			<div class="form-horizontal">
				<div class="form-group">
					<label class="col-lg-3 control-label">{l s='Remise :'}</label>
					<div class="col-lg-3"><p class="form-control-static">{l s='Discount: %.2f%%' sprintf=$group->reduction}</p></div>
				</div>
				<div class="form-group">
					<label class="col-lg-3 control-label">{l s='Méthode d&#039;affichage du prix :'}</label>
					<div class="col-lg-3"><p class="form-control-static">{if $group->price_display_method}
					{l s='HT'}
				{else}
					{l s='TTC'}
				{/if}</p></div>
				</div>
				<div class="form-group">
					<label class="col-lg-3 control-label">{l s='Afficher les prix :'}</label>
					<div class="col-lg-3"><p class="form-control-static">{if $group->show_prices}{l s='Oui'}{else}{l s='Non'}{/if}</p></div>
				</div>
			</div>
		</div>
	</div>
	<div class="col-lg-6">
		<div class="panel">
			<h3><i class="icon-dollar"></i> {l s='Remise de catégorie actuelle'}</h3>
			{if !$categorieReductions}
				<div class="alert alert-warning">{l s='Aucun'}</div>
			{else}
				<table class="table">
					<thead>
						<tr>
							<th><span class="title_box">{l s='Catégorie'}</span></th>
							<th><span class="title_box">{l s='Remise'}</span></th>
						</tr>
					</thead>
					<tbody>
					{foreach $categorieReductions key=key item=category }
						<tr class="alt_row">
							<td>{$category.path}</td>
							<td>{l s='Discount: %.2f%%' sprintf=$category.reduction}</td>
						</tr>
					{/foreach}
					<tbody>
				</table>
			{/if}
		</div>
	</div>
</div>
<div class="row">
	<div class="col-lg-12">
		<h2>{l s='Membres de ce groupe de clients'}</h2>
		<p>{l s='Limité aux 100 premiers clients.'} {l s='Veuillez utiliser les filtres pour affiner votre recherche.'}</p>
		{$customerList}
	</div>
</div>
{/block}
