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

{assign var=module_name value='<strong><span class="module-display-name-placeholder"></span></strong>'}

<div class="modal-body">
	<div class="alert alert-warning">
		<h4>{l s='You are about to install "%s", a module which is not compatible with your country.' sprintf=$module_name}</h4>
		<p>
			{l s='Ce module n&#039;a pas été vérifié par PrestaShop, nous ne pouvons donc pas certifier qu&#039;il fonctionne bien dans votre pays et qu&#039;il respecte nos exigences de qualité.'}
			<strong>{l s='Utilisez à vos propres risques.'}</strong>
		</p>
	</div>
	<h3>{l s='Que dois-je faire ?'}</h3>
	<p>
		{l s='If you are unsure about this, you should contact the Customer Service of %s to ask them to make the module compatible with your country.' sprintf=$module_name}<br />
		{l s='De plus, nous vous recommandons d&#039;utiliser un module équivalent : les modules compatibles avec votre pays sont listés dans l&#039;onglet « Modules » de votre back office.'}
	</p>
	<p>
		{l s='Si vous n&#039;êtes pas sûr de ce module, vous pouvez rechercher des modules similaires sur le marketplace officiel.'}
		<a class="_blank" href="http://addons.prestashop.com/">{l s='Cliquez ici pour parcourir PrestaShop Addons.'}</a>
	</p>
</div>

<div class="modal-footer">
	<div class="row">
		<div class="col-sm-12 text-center">
			<a id="proceed-install-anyway" href="#" class="btn btn-warning">{l s='Procéder à l&#039;installation'}</a>
			<button type="button" class="btn btn-default" data-dismiss="modal">{l s='Retour à la liste des modules'}</button>
		</div>
	</div>
</div>
