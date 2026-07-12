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
	{if !$host_mode}
	<script type="text/javascript">
		$(document).ready(function()
		{
			$.ajax({
				type: 'GET',
				url: '{$link->getAdminLink('AdminInformation')|addslashes}',
				data: {
					'action': 'checkFiles',
					'ajax': 1
				},
				dataType: 'json',
				success: function(json)
				{
					var tab = {
						'missing': '{l s='Fichiers manquants'}',
						'updated': '{l s='Fichiers mis à jour'}'
					};

					if (json.missing.length || json.updated.length)
						$('#changedFiles').html('<div class="alert alert-warning">{l s='Des fichiers modifiés/manquants ont été détectés.'}</div>');
					else
						$('#changedFiles').html('<div class="alert alert-success">{l s='Aucun changement n&#039;a été détecté dans vos fichiers.'}</div>');

					$.each(tab, function(key, lang)
					{
						if (json[key].length)
						{
							var html = $('<ul>').attr('id', key+'_files');
							$(json[key]).each(function(key, file)
							{
								html.append($('<li>').html(file))
							});
							$('#changedFiles')
								.append($('<h4>').html(lang+' ('+json[key].length+')'))
								.append(html);
						}
					});
				}
			});
		});
	</script>
	{/if}
	<div class="row">
		<div class="col-lg-6">
			<div class="panel">
				<h3>
					<i class="icon-info"></i>
					{l s='Informations de configuration'}
				</h3>
				<p>{l s='Cette information doit être fournie lorsque vous signalez un problème sur notre tracker de bugs ou forum.'}</p>
			</div>
			{if !$host_mode}
			<div class="panel">
				<h3>
					<i class="icon-info"></i>
					{l s='Informations serveur'}
				</h3>
				{if Tools::strlen($uname) > 0}
				<p>
					<strong>{l s='Informations serveur :'}</strong> {$uname|escape:'html':'UTF-8'}
				</p>
				{/if}
				<p>
					<strong>{l s='Version du logiciel serveur :'}</strong> {$version.server|escape:'html':'UTF-8'}
				</p>
				<p>
					<strong>{l s='Version PHP :'}</strong> {$version.php|escape:'html':'UTF-8'}
				</p>
				<p>
					<strong>{l s='Limite mémoire :'}</strong> {$version.memory_limit|escape:'html':'UTF-8'}
				</p>
				<p>
					<strong>{l s='Temps d&#039;exécution max :'}</strong> {$version.max_execution_time|escape:'html':'UTF-8'}
				</p>
				{if $apache_instaweb}
					<p>{l s='PageSpeed module for Apache installed (mod_instaweb)'}</p>
				{/if}
			</div>
			<div class="panel">
				<h3>
					<i class="icon-info"></i>
					{l s='Informations base de données'}
				</h3>
				<p>
					<strong>{l s='Version MySQL :'}</strong> {$database.version|escape:'html':'UTF-8'}
				</p>
				<p>
					<strong>{l s='Serveur MySQL :'}</strong> {$database.server|escape:'html':'UTF-8'}
				</p>
				<p>
					<strong>{l s='Nom MySQL :'}</strong> {$database.name|escape:'html':'UTF-8'}
				</p>
				<p>
					<strong>{l s='Utilisateur MySQL :'}</strong> {$database.user|escape:'html':'UTF-8'}
				</p>
				<p>
					<strong>{l s='Préfixe des tables :'}</strong> {$database.prefix|escape:'html':'UTF-8'}
				</p>
				<p>
					<strong>{l s='Moteur MySQL :'}</strong> {$database.engine|escape:'html':'UTF-8'}
				</p>
				<p>
					<strong>{l s='Pilote MySQL :'}</strong> {$database.driver|escape:'html':'UTF-8'}
				</p>
			</div>
		</div>
		{/if}
		<div class="col-lg-6">
			<div class="panel">
				<h3>
					<i class="icon-info"></i>
					{l s='Informations du site'}
				</h3>
				<p>
					<strong>{l s='Version QloApps :'}</strong> {$shop.qloappsV|escape:'html':'UTF-8'}
				</p>
				<p>
					<strong>{l s='URL du site :'}</strong> {$shop.url|escape:'html':'UTF-8'}
				</p>
				<p>
					<strong>{l s='Thème actuel utilisé :'}</strong> {$shop.theme|escape:'html':'UTF-8'}
				</p>
			</div>
			<div class="panel">
				<h3>
					<i class="icon-info"></i>
					{l s='Configuration des e-mails'}
				</h3>
				<p>
					<strong>{l s='Méthode d&#039;e-mail :'}</strong>

			{if $mail}
				{l s='You are using the PHP mail() function.'}</p>
			{else}
				{l s='Vous utilisez vos propres paramètres SMTP.'}</p>
				<p>
					<strong>{l s='Serveur SMTP'}:</strong> {$smtp.server|escape:'html':'UTF-8'}
				</p>
				<p>
					<strong>{l s='Utilisateur SMTP'}:</strong>
					{if $smtp.user neq ''}
						{l s='Défini'}
					{else}
						<span style="color:red;">{l s='Non défini'}</span>
					{/if}
				</p>
				<p>
					<strong>{l s='Mot de passe SMTP'}:</strong>
					{if $smtp.password neq ''}
						{l s='Défini'}
					{else}
						<span style="color:red;">{l s='Non défini'}</span>
					{/if}
				</p>
				<p>
					<strong>{l s='Chiffrement :'}</strong> {$smtp.encryption|escape:'html':'UTF-8'}
				</p>
				<p>
					<strong>{l s='Port SMTP :'}</strong> {$smtp.port|escape:'html':'UTF-8'}
				</p>
			{/if}
			</div>
			<div class="panel">
				<h3>
					<i class="icon-info"></i>
					{l s='Vos informations'}
				</h3>
				<p>
					<strong>{l s='Votre navigateur web :'}</strong> {$user_agent|escape:'html':'UTF-8'}
				</p>
			</div>

			<div class="panel" id="checkConfiguration">
				<h3>
					<i class="icon-info"></i>
					{l s='Vérifiez votre configuration'}
				</h3>
				<p>
					<strong>{l s='Paramètres requis :'}</strong>
				{if !$failRequired}
					<span class="text-success">{l s='OK'}</span>
				</p>
				{else}
					<span class="text-danger">{l s='Veuillez corriger la(les) erreur(s) suivante(s)'}</span>
				</p>
				<ul>
					{foreach from=$testsRequired item='value' key='key'}
						{if $value eq 'fail' && isset($testsErrors[$key])}
							<li>{$testsErrors[$key]}</li>
						{/if}
					{/foreach}
				</ul>
				{/if}
				{if isset($failOptional)}
					<p>
						<strong>{l s='Paramètres optionnels :'}</strong>
					{if !$failOptional}
						<span class="text-success">{l s='OK'}</span>
					</p>
					{else}
						<span class="text-danger">{l s='Veuillez corriger la(les) erreur(s) suivante(s)'}</span>
					</p>
					<ul>
						{foreach from=$testsOptional item='value' key='key'}
							{if $value eq 'fail' && isset($testsErrors[$key])}
								<li>{$testsErrors[$key]}</li>
							{/if}
						{/foreach}
					</ul>
					{/if}
				{/if}
			</div>
		</div>
	</div>
	{if !$host_mode}
	<div class="panel">
		<h3>
			<i class="icon-info"></i>
			{l s='Liste des fichiers modifiés'}
		</h3>
		<div id="changedFiles"><i class="icon-spin icon-refresh"></i> {l s='Vérification des fichiers...'}</div>
	</div>
	{/if}
{/block}
