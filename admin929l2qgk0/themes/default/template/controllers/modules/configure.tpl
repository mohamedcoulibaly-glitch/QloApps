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
{extends file="page_header_toolbar.tpl"}


{block name=pageTitle}
<h2 class="page-title configure">
	{l s='Configurer'}
</h2>
<h4 class="page-subtitle">{$module_display_name}</h4>
{/block}
{block name=pageBreadcrumb}
<ul class="breadcrumb page-breadcrumb">
	{if $breadcrumbs2.container.name != ''}
		<li class="breadcrumb-current">
			{if $breadcrumbs2.container.href != ''}<a href="{$breadcrumbs2.container.href|escape}">{/if}
			{$breadcrumbs2.container.name|escape}
			{if $breadcrumbs2.container.href != ''}</a>{/if}
		</li>
	{/if}
	<li>{$module_name}</li>
	<li>
		<i class="icon-wrench"></i>
		{l s='Configurer'}
	</li>
</ul>
{/block}
{block name=toolbarBox}
<script type="text/javascript">
	var header_confirm_reset = '{l s='Confirmer la réinitialisation'}';
	var body_confirm_reset = '{l s='Souhaitez-vous supprimer le contenu lié à ce module ?'}';
	var left_button_confirm_reset = '{l s='Non - réinitialiser uniquement les paramètres'}';
	var right_button_confirm_reset = '{l s='Oui - tout réinitialiser'}';
</script>
<div class="page-bar toolbarBox">
	<div class="btn-toolbar">
		<ul class="nav nav-pills pull-right">
			<li>
				<a id="desc-module-back" class="toolbar_btn" href="javascript: window.history.back();" title="{l s='Retour'}">
					<i class="process-icon-back"></i>
					<div>{l s='Retour'}</div>
				</a>
			</li>
			<!-- <li>
				<a id="desc-module-disable" class="toolbar_btn" href="{$module_disable_link}" title="{l s='Désactiver'}">
					<i class="process-icon-off"></i>
					<div>{l s='Désactiver'}</div>
				</a>
			</li>
			<li>
				<a id="desc-module-uninstall" class="toolbar_btn" href="{$module_uninstall_link}" title="{l s='Désinstaller'}">
					<i class="process-icon-uninstall"></i>
					<div>{l s='Désinstaller'}</div>
				</a>
			</li>
			<li>
				<a id="desc-module-reset" class="toolbar_btn {if $is_reset_ready}reset_ready{/if}" href="{$module_reset_link}" title="{l s='Réinitialiser'}">
					<i class="process-icon-reset"></i>
					<div>{l s='Réinitialiser'}</div>
				</a>
			</li> -->
			{if isset($trad_link)}
			<li>
				<a id="desc-module-translate" data-toggle="modal" data-target="#moduleTradLangSelect" class="toolbar_btn" href="#" title="{l s='Traduire'}">
					<i class="process-icon-flag"></i>
					<div>{l s='Traduire'}</div>
				</a>
			</li>
			{/if}
			{if isset($module_update_link)}
				{* <li>
					<a id="desc-module-update" class="toolbar_btn" href="{$module_update_link}" title="{l s='Mettre à jour'}">
						<i class="process-icon-refresh"></i>
						<div>{l s='Vérifier la mise à jour'}</div>
					</a>
				</li> *}
			{/if}
			<li>
				<a id="desc-module-hook" class="toolbar_btn" href="{$module_hook_link}" title="{l s='Gérer les hooks'}">
					<i class="process-icon-anchor"></i>
					<div>{l s='Gérer les hooks'}</div>
				</a>
			</li>
		</ul>
	</div>
</div>


{/block}
