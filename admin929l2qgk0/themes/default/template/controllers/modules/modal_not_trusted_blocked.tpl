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

<div class="modal-body">
	<div class="alert alert-warning">
		<h3>{l s='Ce module n&#039;a pas pu être vérifié par PrestaShop.'}</h3>

		<p>{l s="This generally happens when the module isn't distributed through our official marketplace, PrestaShop Addons - or when your server failed to communicate with PrestaShop Addons."}</p>
	</div>

	<div class="row">
		<div class="col-sm-2" style="text-align: center;">
			<img id="untrusted-module-logo" class="" src="" alt="">
		</div>
		<div class="col-sm-10">
			<table class="table">
				<tr>
					<td>{l s='Module'}</td>
					<td><strong><span class="module-display-name-placeholder"></span></strong></td>
				</tr>
				<tr>
					<td>{l s='Auteur'}</td>
					<td><strong><span class="author-name-placeholder"></span></strong></td>
				</tr>
			</table>
		</div>

		<div class="col-sm-12" style="text-align: center; padding-top: 12px;">
			<button type="button" class="btn btn-default" data-dismiss="modal">{l s='Retour à la liste des modules'}</button>
		</div>
	</div>
</div>

<div class="modal-footer">
	<div class="alert alert-info">
		<p>{l s='Comme vous n&#039;avez peut-être pas installé ce module depuis PrestaShop Addons, nous ne pouvons pas affirmer que le module respecte nos exigences de sécurité (par exemple, qu&#039;il n&#039;ajoute pas de fonctionnalités non divulguées telles que des publicités, des liens cachés, du spam, etc.).'}</p>

		<p>{l s='Vous pouvez rechercher des modules similaires sur le marketplace officiel.'}</p>

		<p>{l s="[1]Click here to browse our catalog on PrestaShop Addons[/1]." tags=['<a class="catalog-link" href="#">']}
	</div>
</div>