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
<!DOCTYPE html>
<html lang="{$iso}">
<head>
	<meta charset="utf-8">

	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<link rel="icon" type="image/x-icon" href="{$img_dir}favicon.ico" />
	<link rel="apple-touch-icon" href="{$img_dir}app_icon.png" />

	<meta name="robots" content="NOFOLLOW, NOINDEX">
	<title>{if $meta_title != ''}{$meta_title} • {/if}{$shop_name}</title>
	{if !isset($display_header_javascript) || $display_header_javascript}
	<script type="text/javascript">
		var help_class_name = '{$controller_name|@addcslashes:'\''}';
		var iso_user = '{$iso_user|@addcslashes:'\''}';
		var full_language_code = '{$full_language_code|@addcslashes:'\''}';
		var country_iso_code = '{$country_iso_code|@addcslashes:'\''}';
		var _PS_VERSION_ = '{$smarty.const._PS_VERSION_|@addcslashes:'\''}';
		var roundMode = {$round_mode|intval};
{if isset($shop_context)}
	{if $shop_context == Shop::CONTEXT_ALL}
		var youEditFieldFor = '{l s='Ce champ sera modifié pour tous vos magasins.' js=1}';
	{elseif $shop_context == Shop::CONTEXT_GROUP}
		var youEditFieldFor = '{l s='Ce champ sera modifié pour tous les magasins de ce groupe :' js=1} <b>{$shop_name|@addcslashes:'&#039;'}</b>';
	{else}
		var youEditFieldFor = '{l s='Ce champ sera modifié pour ce magasin :' js=1} <b>{$shop_name|@addcslashes:'&#039;'}</b>';
	{/if}
{else}
		var youEditFieldFor = '';
{/if}
		var autorefresh_notifications = '{$autorefresh_notifications|@addcslashes:'\''}';
		var new_order_msg = '{l s='Une nouvelle commande a été passée sur votre magasin.' js=1}';
		var order_number_msg = '{l s='Numéro de commande :' js=1} ';
		var total_msg = '{l s='Total :' js=1} ';
		var from_msg = '{l s='De :' js=1} ';
		var see_order_msg = '{l s='Voir cette commande' js=1}';
		var new_customer_msg = '{l s='Un nouveau client s&#039;est inscrit sur votre magasin.' js=1}';
		var customer_name_msg = '{l s='Nom du client :' js=1} ';
		var new_msg = '{l s='Un nouveau message a été posté sur votre magasin.' js=1}';
		var see_msg = '{l s='Lire ce message' js=1}';
		var token = '{$token|addslashes}';
		var token_admin_orders = '{getAdminToken tab='AdminOrders'}';
		var token_admin_customers = '{getAdminToken tab='AdminCustomers'}';
		var token_admin_customer_threads = '{getAdminToken tab='AdminCustomerThreads'}';
		var currentIndex = '{$currentIndex|@addcslashes:'\''}';
		var employee_token = '{getAdminToken tab='AdminEmployees'}';
		var choose_language_translate = '{l s='Choisir la langue' js=1}';
		var default_language = '{$default_language|intval}';
		var admin_modules_link = '{$link->getAdminLink("AdminModules")|addslashes}';
		var tab_modules_list = '{if isset($tab_modules_list) && $tab_modules_list}{$tab_modules_list|addslashes}{/if}';
		var update_success_msg = '{l s='Mise à jour réussie' js=1}';
		var errorLogin = '{l s='Le service externe est momentanément indisponible. Veuillez vérifier vos identifiants et votre connexion Internet.' js=1}';
		var search_product_msg = '{l s='Rechercher un produit' js=1}';
	</script>
{/if}
{if isset($css_files)}
{foreach from=$css_files key=css_uri item=media}
	{if $css_uri == 'lteIE9'}
		<!--[if lte IE 9]>
		{foreach from=$css_files[$css_uri] key=css_uriie9 item=mediaie9}
		<link rel="stylesheet" href="{$css_uriie9|escape:'html':'UTF-8'}" type="text/css" media="{$mediaie9|escape:'html':'UTF-8'}" />
		{/foreach}
		<![endif]-->
	{else}
		<link rel="stylesheet" href="{$css_uri|escape:'html':'UTF-8'}" type="text/css" media="{$media|escape:'html':'UTF-8'}" />
	{/if}
{/foreach}
{/if}
	{if (isset($js_def) && count($js_def) || isset($js_files) && count($js_files))}
		{include file=$smarty.const._PS_ALL_THEMES_DIR_|cat:"javascript.tpl"}
	{/if}

	{if isset($displayBackOfficeHeader)}
		{$displayBackOfficeHeader}
	{/if}
	{if isset($brightness)}
	<!--
		// @todo: multishop color
		<style type="text/css">
			div#header_infos, div#header_infos a#header_shopname, div#header_infos a#header_logout, div#header_infos a#header_foaccess {ldelim}color:{$brightness}{rdelim}
		</style>
	-->
	{/if}
	<link rel="stylesheet" href="themes/default/css/reception-modern.css?v=2026071208" type="text/css" media="all" />
</head>

{if $display_header}
	<body class="ps_back-office{if $employee->bo_menu} page-sidebar{if $collapse_menu} page-sidebar-closed{/if}{else} page-topbar{/if} {$smarty.get.controller|escape|strtolower}">
	{* begin  HEADER *}
	<header id="header" class="bootstrap">
		<nav id="header_infos" role="navigation">
			<div class="navbar-header">
				<button id="header_nav_toggle" type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse-primary" aria-label="{l s='Basculer la navigation'}" aria-expanded="false">
					<i class="icon-reorder" aria-hidden="true"></i>
				</button>
				<a id="header_shopversion" class="hotel-brand-mark" href="{$default_tab_link|escape:'html':'UTF-8'}" aria-label="Hotel Prime"><span id="shop_version">HP</span></a>
				{* Shop *}
				{if isset($is_multishop) && $is_multishop && $shop_list && (isset($multishop_context) && $multishop_context & Shop::CONTEXT_GROUP || $multishop_context & Shop::CONTEXT_SHOP)}
					<ul id="header_shop">
						<li class="dropdown">
							{$shop_list}
						</li>
					</ul>
				{else}
					<a id="header_shopname" href="{$default_tab_link|escape:'html':'UTF-8'}">{$shop_name}</a>
				{/if}
				<ul id="header_notifs_icon_wrapper" aria-label="{l s='Notifications'}">
					{if {$show_new_orders} == 1}
						<li id="orders_notif" class="dropdown" data-type="order">
							<a href="javascript:void(0);" class="dropdown-toggle notifs" data-toggle="dropdown" aria-label="{l s='Notifications de commandes'}">
								<i class="icon-shopping-cart" aria-hidden="true"></i>
								<span id="orders_notif_number_wrapper" class="notifs_badge hide">
									<span id="orders_notif_value">0</span>
								</span>
							</a>
							<div class="dropdown-menu notifs_dropdown">
								<section id="orders_notif_wrapper" class="notifs_panel">
									<div class="notifs_panel_header">
										<h3>{l s='Dernières commandes'}</h3>
									</div>
									<div id="list_orders_notif" class="list_notif">
										<span class="no_notifs">
											{l s='Aucune nouvelle commande n&#039;a été passée sur votre magasin.'}
										</span>
									</div>
									<div class="notifs_panel_footer">
										<a href="index.php?controller=AdminOrders&amp;token={getAdminToken tab='AdminOrders'}">{l s='Voir toutes les commandes'}</a>
									</div>
								</section>
							</div>
						</li>
					{/if}
					{if {$show_new_customers} == 1}
						<li id="customers_notif" class="dropdown" data-type="customer">
							<a href="javascript:void(0);" class="dropdown-toggle notifs" data-toggle="dropdown" aria-label="{l s='Notifications de clients'}">
								<i class="icon-user" aria-hidden="true"></i>
								<span id="customers_notif_number_wrapper" class="notifs_badge hide">
									<span id="customers_notif_value">0</span>
								</span>
							</a>
							<div class="dropdown-menu notifs_dropdown">
								<section id="customers_notif_wrapper" class="notifs_panel">
									<div class="notifs_panel_header">
										<h3>{l s='Dernières inscriptions'}</h3>
									</div>
									<div id="list_customers_notif" class="list_notif">
										<span class="no_notifs">
											{l s='Aucun nouveau client ne s&#039;est inscrit sur votre magasin.'}
										</span>
									</div>
									<div class="notifs_panel_footer">
										<a href="index.php?controller=AdminCustomers&amp;token={getAdminToken tab='AdminCustomers'}">{l s='Voir tous les clients'}</a>
									</div>
								</section>
							</div>
						</li>
					{/if}
					{if {$show_new_messages} == 1}
						<li id="customer_messages_notif" class="dropdown" data-type="customer_message">
							<a href="javascript:void(0);" class="dropdown-toggle notifs" data-toggle="dropdown" aria-label="{l s='Notifications de messages'}">
								<i class="icon-envelope" aria-hidden="true"></i>
								<span id="customer_messages_notif_number_wrapper" class="notifs_badge hide">
									<span id="customer_messages_notif_value" >0</span>
								</span>
							</a>
							<div class="dropdown-menu notifs_dropdown">
								<section id="customer_messages_notif_wrapper" class="notifs_panel">
									<div class="notifs_panel_header">
										<h3>{l s='Derniers messages'}</h3>
									</div>
									<div id="list_customer_messages_notif" class="list_notif">
										<span class="no_notifs">
											{l s='Aucun nouveau message n&#039;a été posté sur votre magasin.'}
										</span>
									</div>
									<div class="notifs_panel_footer">
										<a href="index.php?controller=AdminCustomerThreads&amp;token={getAdminToken tab='AdminCustomerThreads'}">{l s='Voir tous les messages'}</a>
									</div>
								</section>
							</div>
						</li>
					{/if}
					{hook h='displayBackOfficeTopNotificaiton'}
				</ul>
				{if count($quick_access) > 0}
					<ul id="header_quick">
						<li class="dropdown">
							<a href="javascript:void(0)" id="quick_select" class="dropdown-toggle" data-toggle="dropdown">{l s='Accès rapide'} <i class="icon-caret-down"></i></a>
							<ul class="dropdown-menu">
								{foreach $quick_access as $quick}
									<li {if $link->matchQuickLink({$quick.link})}{assign "matchQuickLink" $quick.id_quick_access}class="active"{/if}>
										<a href="{$quick.link|escape:'html':'UTF-8'}"{if $quick.new_window} target="_blank" rel="noopener noreferrer"{/if}>
											{if isset($quick.icon)}
												<i class="icon-{$quick.icon} icon-fw"></i>
											{else}
												<i class="icon-chevron-right icon-fw"></i>
											{/if}
											{$quick.name}
										</a>
									</li>
								{/foreach}
								<li class="divider"></li>
								{if isset($matchQuickLink)}
									<li>
										<a href="javascript:void(0);" class="ajax-quick-link" data-method="remove" data-quicklink-id="{$matchQuickLink}" role="button">
											<i class="icon-minus-circle"></i>
											{l s='Retirer de l&#039;accès rapide'}
										</a>
									</li>
								{/if}
								<li {if isset($matchQuickLink)}class="hide"{/if}>
									<a href="javascript:void(0);" class="ajax-quick-link" data-method="add" role="button">
										<i class="icon-plus-circle"></i>
										{l s='Ajouter la page actuelle à l&#039;accès rapide'}
									</a>
								</li>
							</ul>
						</li>
					</ul>
					{$quick_access_current_link_name = " - "|explode:$quick_access_current_link_name}
					<script>
						$(function() {
							$('.ajax-quick-link').on('click', function(e){
								e.preventDefault();

								var method = $(this).data('method');

								if(method == 'add')
									var name = prompt('{l s='Veuillez nommer ce raccourci :' js=1}', '{$quick_access_current_link_name.0|truncate:32}');

								if(method == 'add' && name || method == 'remove')
								{
										$.ajax({
										type: 'POST',
										headers: { "cache-control": "no-cache" },
										async: true,
										url: "{$link->getAdminLink('AdminQuickAccesses')}" + "&action=GetUrl" + "&rand={1|rand:200}" + "&ajax=1" + "&method=" + method + ( $(this).data('quicklink-id') ? "&id_quick_access=" + $(this).data('quicklink-id') : ""),
										data: {
											"url": "{$link->getQuickLink($smarty.server['REQUEST_URI'])}",
											"name": name,
											"icon": "{$quick_access_current_link_icon}"
										},
										dataType: "json",
										success: function(data) {
											var quicklink_list ='';
											$.each(data, function(index,value){
												if (typeof data[index]['name'] !== 'undefined')
													quicklink_list += '<li><a href="' + data[index]['link'] + '&token=' + data[index]['token'] + '"><i class="icon-chevron-right"></i> ' + data[index]['name'] + '</a></li>';
											});

											if (typeof data['has_errors'] !== 'undefined' && data['has_errors'])
												$.each(data, function(index, value)
												{
													if (typeof data[index] == 'string')
														$.growl.error({ title: "", message: data[index]});
												});
											else
											{
												$("#header_quick ul.dropdown-menu").html(quicklink_list);
												showSuccessMessage(update_success_msg);
											}
										}
									});
								}
							});
						});
					</script>
				{/if}

				<ul id="header_employee_box">
					{if {$base_url}}
						<li>
							<a href="{if isset($base_url_tc)}{$base_url_tc|escape:'html':'UTF-8'}{else}{$base_url|escape:'html':'UTF-8'}{/if}" id="header_foaccess" target="_blank" rel="noopener noreferrer" title="{l s='Voir mon magasin'}">
								<span class="string-long">{l s='Mon site'}</span>
								<span class="string-short">{l s='Site'}</span>
							</a>
							{if isset($maintenance_mode) && $maintenance_mode == true}
								<span class="maintenance-mode">
									&mdash;
									<span class="label-tooltip" data-toggle="tooltip" data-placement="bottom" data-html="true"
									title="<p class='text-left text-nowrap'><strong>{l s='Votre site est en maintenance.'}</strong></p><p class='text-left'>{l s='Vos visiteurs et clients ne peuvent pas accéder à votre magasin en mode maintenance.%s Pour gérer les paramètres de maintenance, allez dans Préférences > Maintenance.' sprintf='<br />'}</p>">{l s='Mode maintenance'}</span>
								</span>
							{/if}
						</li>
					{/if}
					<li id="employee_infos" class="dropdown">
						<a href="{$link->getAdminLink('AdminEmployees')|escape:'html':'UTF-8'}&amp;id_employee={$employee->id|intval}&amp;updateemployee" class="dropdown-toggle" data-toggle="dropdown">
							<span class="string-long">{$employee->firstname}&nbsp;{$employee->lastname}</span>
							<span class="string-short">{l s='Moi'}</span>
							<i class="caret"></i>
						</a>
						<ul id="employee_links" class="dropdown-menu">
							<li><a href="{$link->getAdminLink('AdminEmployees')|escape:'html':'UTF-8'}&amp;id_employee={$employee->id|intval}&amp;updateemployee"><i class="icon-wrench"></i> {l s='Mes préférences'}</a></li>
							<li><a id="header_logout" href="{$login_link|escape:'html':'UTF-8'}&amp;logout"><i class="icon-signout"></i> {l s='Déconnexion'}</a></li>
						</ul>
					</li>
				</ul>


				<span id="ajax_running" role="status" aria-live="polite">
					<i class="icon-refresh icon-spin icon-fw" aria-hidden="true"></i>
				</span>

				{if isset($displayBackOfficeTop)}{$displayBackOfficeTop}{/if}
			</div>
		</nav>{* end header_infos*}
	</header>

	<div id="main">
		{include file='nav.tpl'}

		<div id="content" class="{if !$bootstrap}nobootstrap{else}bootstrap{/if}">
			{if isset($page_header_toolbar)}{$page_header_toolbar}{/if}
			{if isset($modal_module_list)}{$modal_module_list}{/if}

		{if $install_dir_exists}
			<div class="alert alert-warning">
				{l s='Pour des raisons de sécurité, vous devez également supprimer le dossier /install.'}
			</div>
		{/if}

		{hook h='displayAdminAfterHeader'}


{* end display_header*}

{else}
	<body{if isset($lite_display) && $lite_display} class="ps_back-office display-modal"{/if}>
		<div id="main">
			<div id="content" class="{if !$bootstrap}nobootstrap{else}bootstrap{/if}">
{/if}
				<div id="page-loader"><span><i class="icon-refresh icon-spin icon-fw"></i></span></div>
