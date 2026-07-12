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
<div id="login-panel">
	<div id="login-header">
		<h1 class="text-center">
			<img id="logo" src="{$img_dir}qloapps@2x.png" width="123" alt="QloApps" />
		</h1>
		<div class="text-center">{$qloapps_version}</div>
		<div id="error" class="hide alert alert-danger" role="alert" aria-live="assertive">
		{if isset($errors)}
			<h4>
				{if isset($nbErrors) && $nbErrors > 1}
					{l s='Il y a %d erreurs.' sprintf=$nbErrors}
				{else}
					{l s='Il y a %d erreur.' sprintf=$nbErrors}
				{/if}
			</h4>
			<ol>
				{foreach from=$errors item="error"}
				<li>{$error}</li>
				{/foreach}
			</ol>
		{/if}
		</div>

		{if isset($warningSslMessage)}
		<div class="alert alert-warning">{$warningSslMessage}</div>
		{/if}
	</div>
	<div id="shop-img"><img src="{$img_dir}qloapps-login@2x.png" alt="{$shop_name}" width="136" height="136" /></div>
	<div class="flip-container">
		<div class="flipper">
			<div class="front panel">
				<h4 id="shop_name">{$shop_name}</h4>
				{if !isset($wrong_folder_name) && !isset($wrong_install_name)}
				<form action="#" id="login_form" method="post">
					<input type="hidden" name="redirect" id="redirect" value="{$redirect}"/>
					<div class="form-group">
						<label class="control-label" for="email">{l s='Adresse e-mail'}</label>
						<input name="email" type="email" id="email" class="form-control" value="{if isset($email)}{$email|escape:'html':'UTF-8'}{/if}" autofocus tabindex="1" placeholder="&#xf0e0 test@example.com" />
					</div>
					<div class="form-group">
						<label class="control-label" for="passwd">
							{l s='Mot de passe'}
						</label>
						<input name="passwd" type="password" id="passwd" class="form-control" value="{if isset($password)}{$password|escape:'html':'UTF-8'}{/if}" tabindex="2" placeholder="&#xf084 {l s='Mot de passe'}" />
					</div>
					{hook h="displayAdminLoginFormFieldsAfter"}
					<div class="form-group row-padding-top">
						<button name="submitLogin" type="submit" tabindex="4" class="btn btn-primary btn-lg btn-block ladda-button" data-style="slide-up" data-spinner-color="white">
							<span class="ladda-label">
								{l s='Se connecter'}
							</span>
						</button>
					</div>
					<div class="form-group login-actions">
						<div id="remind-me" class="checkbox pull-left">
							<label for="stay_logged_in">
								<input name="stay_logged_in" type="checkbox" id="stay_logged_in" value="1"	tabindex="3"/>
								{l s='Rester connecté'}
							</label>
						</div>
						<a href="#" class="show-forgot-password pull-right" >
							{l s='J&#039;ai oublié mon mot de passe'}
						</a>
					</div>
				</form>
			</div>

			<div class="back panel">
				<form action="#" id="forgot_password_form" method="post">
					<div class="alert alert-info">
						<h4>{l s='Mot de passe oublié ?'}</h4>
						<p>{l s='Pour recevoir votre code d&#039;accès par e-mail, veuillez saisir l&#039;adresse que vous avez fournie lors du processus d&#039;inscription.'}</p>
					</div>
					<div class="form-group">
						<label class="control-label" for="email_forgot">
							{l s='E-mail'}
						</label>
						<input type="email" name="email_forgot" id="email_forgot" class="form-control" autofocus tabindex="5" placeholder="&#xf0e0 test@example.com" />
					</div>
					<div class="panel-footer login-actions">
						<button type="button" class="btn btn-default show-login-form" tabindex="7">
							<i class="icon-caret-left"></i>
							{l s='Retour à la connexion'}
						</button>
						<button class="btn btn-default pull-right" name="submitLogin" type="submit" tabindex="6">
							<i class="icon-ok text-success"></i>
							{l s='Envoyer le lien de réinitialisation'}
						</button>
					</div>
				</form>
			</div>
		</div>
		{else}
		<div class="alert alert-danger">
			<p>{l s='Pour des raisons de sécurité, vous ne pouvez pas vous connecter à l&#039;arrière-saute tant que vous n&#039;avez pas :'}</p>
			<ul>
				{if isset($wrong_install_name) && $wrong_install_name == true}
					<li>{l s='supprimé le dossier /install'}</li>
				{/if}
				{if isset($wrong_folder_name) && $wrong_folder_name == true}
					<li>{l s='renommé le dossier /admin (ex. %s)' sprintf=$randomNb}</li>
				{/if}
			</ul>
			<p>
				<a href="{$adminUrl|escape:'html':'UTF-8'}">
					{l s='Veuillez ensuite accéder à cette page par la nouvelle URL (ex. %s)' sprintf=$adminUrl}
				</a>
			</p>
		</div>
		{/if}
	</div>
	{hook h="displayAdminLogin"}
	<div id="login-footer">
		<p class="text-center text-muted">
			<a href="https://webkul.com" target="_blank" rel="noopener noreferrer">
				&copy; Webkul&#8482; 2015-{$smarty.now|date_format:"%Y"} - Tous droits réservés
			</a>
		</p>
		<p class="text-center">
			<a class="link-social link-twitter" href="https://twitter.com/qloapps" target="_blank" rel="noopener noreferrer" aria-label="Twitter">
				<i class="icon-twitter"></i>
			</a>
			<a class="link-social link-facebook" href="https://www.facebook.com/qloapps" target="_blank" rel="noopener noreferrer" aria-label="Facebook">
				<i class="icon-facebook"></i>
			</a>
			<a class="link-social link-github" href="https://github.com/webkul/hotelcommerce" target="_blank" rel="noopener noreferrer" aria-label="GitHub">
				<i class="icon-github"></i>
			</a>
		</p>
	</div>
</div>
