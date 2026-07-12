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
			<h3>
				<i class="icon-info"></i>
				{if isset($is_template) && $is_template == 1} {l s='Modèle'} {/if}{l s='Informations générales'}
			</h3>
			<table class="table">
				<tr>
					<td>{l s='Date de création :'}</td>
					<td>{$supply_order_creation_date}</td>
				</tr>
				<tr>
					<td>{l s='Fournisseur :'}</td>
					<td>{$supply_order_supplier_name}</td>
				</tr>
				<tr>
					<td>{l s='Dernière mise à jour :'}</td>
					<td>{$supply_order_last_update}</td>
				</tr>
				<tr>
					<td>{l s='Livraison prévue :'}</td>
					<td>{$supply_order_expected}</td>
				</tr>
				<tr>
					<td>{l s='Entrepôt :'}</td>
					<td>{$supply_order_warehouse}</td>
				</tr>
				<tr>
					<td>{l s='Devise :'}</td>
					<td>{$supply_order_currency->name}</td>
				</tr>
				<tr>
					<td>{l s='Taux de remise global :'}</td>
					<td>{$supply_order_discount_rate} %</td>
				</tr>
			</table>
		</div>
	</div>
	<div class="col-lg-6">
		<div class="panel">
			<h3>
				<i class="icon-th-list"></i>
				{if isset($is_template) && $is_template == 1} {l s='Modèle'} {/if}{l s='Résumé'}
			</h3>
			<table class="table">
				<thead>
					<tr>
						<th><span class="title_box">{l s='Désignation'}</span></th>
						<th><span class="title_box">{l s='Valeur'}</span></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>{l s='Total (HT)'}</td>
						<td>{$supply_order_total_te}</td>
					</tr>
					<tr>
						<td>{l s='Remise'}</td>
						<td>{$supply_order_discount_value_te}</td>
					</tr>
					<tr>
						<td>{l s='Total avec remise (HT)'}</td>
						<td>{$supply_order_total_with_discount_te}</td>
					</tr>
					<tr>
						<td>{l s='Taxe totale'}</td>
						<td>{$supply_order_total_tax}</td>
					</tr>
					<tr>
						<td>{l s='Total (TTC)'}</td>
						<td>{$supply_order_total_ti}</td>
					</tr>
					<tr>
						<td>{l s='Total à payer.'}</td>
						<td>{$supply_order_total_ti}</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>
{$supply_order_detail_content}
{/block}
