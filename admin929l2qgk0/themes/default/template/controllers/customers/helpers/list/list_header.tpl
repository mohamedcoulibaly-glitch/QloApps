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

{extends file="helpers/list/list_header.tpl"}
{block name='override_header'}
{if $submit_form_ajax}
	<script type="text/javascript">
		$('#customer', window.parent.document).val('{$new_customer->email|escape:'html':'UTF-8'}');
		parent.setupCustomer({$new_customer->id|intval});
		parent.$.fancybox.close();
	</script>
{/if}
{/block}
{block name=leadin}
	{if isset($delete_customer) && $delete_customer}
		<form action="{$REQUEST_URI|escape:'html':'UTF-8'}" method="post">
			<div class="alert alert-warning">
				<h4>{l s='Comment souhaitez-vous supprimer les clients sélectionnés ?'}</h4>
				<p>{l s='Il existe deux façons de supprimer un client. Veuillez choisir votre méthode préférée.'}</p>
				<br>
				<ul class="listForm list-unstyled">
					<li>
						<label for="deleteMode_real" class="control-label">
							<input type="radio" name="deleteMode" value="real" id="deleteMode_real" />
							{l s='Je souhaite que mes clients puissent se réinscrire avec la même adresse e-mail. Toutes les données seront supprimées de la base de données.'}
						</label>
					</li>
					<li>
						<label for="deleteMode_deleted" class="control-label">
							<input type="radio" name="deleteMode" value="deleted" id="deleteMode_deleted" />
							{l s='Je ne souhaite pas que mon/mes client(s) puissent se réinscrire avec la même adresse e-mail. Tous les clients sélectionnés seront supprimés de cette liste mais leurs données correspondantes seront conservées dans la base de données.'}
						</label>
					</li>
				</ul>
				{foreach $POST as $key => $value}
					{if is_array($value)}
						{foreach $value as $val}
							<input type="hidden" name="{$key|escape:'html':'UTF-8'}[]" value="{$val|escape:'html':'UTF-8'}" />
						{/foreach}
					{else}
						<input type="hidden" name="{$key|escape:'html':'UTF-8'}" value="{$value|escape:'html':'UTF-8'}" />
					{/if}
				{/foreach}
				<input type="submit" class="btn btn-default" value="{l s='Supprimer'}" />
			</div>
		</form>
		<script>
			$(document).ready(function() {
				$('table[name=\'list_table\']').hide();
			});
		</script>
	{/if}
{/block}
