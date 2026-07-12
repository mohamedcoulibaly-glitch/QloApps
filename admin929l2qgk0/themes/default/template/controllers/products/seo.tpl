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
<div id="product-seo" class="panel product-tab">
	<input type="hidden" name="submitted_tabs[]" value="Seo" />
	<h3>{l s='SEO'}</h3>
	{include file="controllers/products/multishop/check_fields.tpl" product_tab="Seo"}
	<div class="form-group">
		<div class="col-lg-1"><span class="pull-right">{include file="controllers/products/multishop/checkbox.tpl" field="meta_title" type="default" multilang="true"}</span></div>
		<label class="control-label col-lg-2" for="meta_title_{$id_lang}">
			<span class="label-tooltip" data-toggle="tooltip"
				title="{l s='Titre public pour la page du produit, et pour les moteurs de recherche. Laissez vide pour utiliser le nom du type de chambre.'} {l s='Le nombre de caractères restants est affiché à gauche du champ.'}">
				{l s='Titre meta'}
			</span>
		</label>
		<div class="col-lg-8">
			{include file="controllers/products/input_text_lang.tpl"
				languages=$languages
				input_name='meta_title'
				input_value=$product->meta_title
				maxchar=70
			}
		</div>
	</div>
	<div class="form-group">
		<div class="col-lg-1"><span class="pull-right">{include file="controllers/products/multishop/checkbox.tpl" field="meta_description" type="default" multilang="true"}</span></div>
		<label class="control-label col-lg-2" for="meta_description_{$id_lang}">
			<span class="label-tooltip" data-toggle="tooltip"
				title="{l s='Cette description apparaîtra dans les moteurs de recherche. Vous avez besoin d&#039;une seule phrase, plus courte que 160 caractères (espaces inclus).'}">
				{l s='Description meta'}
			</span>
		</label>
		<div class="col-lg-8">
			{include file="controllers/products/textarea_lang.tpl"
				languages=$languages
				input_name='meta_description'
				input_value=$product->meta_description
				maxchar=160
			}
		</div>
	</div>
	{* Removed for simplicity *}
	<div class="form-group hide">
		<div class="col-lg-1"><span class="pull-right">{include file="controllers/products/multishop/checkbox.tpl" field="meta_keywords" type="default" multilang="true"}</span></div>
		<label class="control-label col-lg-2" for="meta_keywords_{$id_lang}">
			<span class="label-tooltip" data-toggle="tooltip"
				title="{l s='Mots-clés pour les moteurs de recherche, séparés par des virgules.'}">
				{l s='Mots-clés meta'}
			</span>
		</label>
		<div class="col-lg-8">
			{include file="controllers/products/input_text_lang.tpl" languages=$languages
				input_value=$product->meta_keywords
				input_name='meta_keywords'}
		</div>
	</div>
	<div class="form-group">
		<div class="col-lg-1"><span class="pull-right">{include file="controllers/products/multishop/checkbox.tpl" field="link_rewrite" type="seo_friendly_url" multilang="true"}</span></div>
		<label class="control-label col-lg-2" for="link_rewrite_{$id_lang}">
			<span class="label-tooltip" data-toggle="tooltip"
				title="{l s='Ceci est l&#039;URL lisible, générée à partir du nom du type de chambre. Vous pouvez la modifier si vous le souhaitez.'}">
				{l s='URL lisible :'}
			</span>

		</label>
		<div class="col-lg-6">
				{include file="controllers/products/input_text_lang.tpl"
					languages=$languages
					input_value=$product->link_rewrite
					input_name='link_rewrite'}
		</div>
		<div class="col-lg-2">
			<button type="button" class="btn btn-default" id="generate-friendly-url" onmousedown="updateFriendlyURLByName();"><i class="icon-random"></i> {l s='Générer'}</button>
		</div>
	</div>
	<div class="row">
		<div class="col-lg-9 col-lg-offset-3">
			{foreach from=$languages item=language}
			<div class="alert alert-warning translatable-field lang-{$language.id_lang}">
				<i class="icon-link"></i> {l s='Le lien du produit ressemblera à ceci :'}<br/>
				<strong>{if isset($rewritten_links[$language.id_lang][0])}{$rewritten_links[$language.id_lang][0]|escape:'html':'UTF-8'}{/if}<span id="friendly-url_{$language.id_lang}">{if isset($product->id)}{$product->link_rewrite[$language.id_lang]|escape:'html':'UTF-8'}{/if}</span>{if isset($rewritten_links[$language.id_lang][1])}{$rewritten_links[$language.id_lang][1]|escape:'html':'UTF-8'}{/if}</strong>
			</div>
			{/foreach}
		</div>
	</div>
	<div class="panel-footer">
		<a href="{$link->getAdminLink('AdminProducts')|escape:'html':'UTF-8'}{if isset($smarty.request.page) && $smarty.request.page > 1}&amp;submitFilterproduct={$smarty.request.page|intval}{/if}" class="btn btn-default"><i class="process-icon-cancel"></i> {l s='Annuler'}</a>
		<button type="submit" name="submitAddproduct" class="btn btn-default pull-right" disabled="disabled"><i class="process-icon-loading"></i> {l s='Enregistrer'}</button>
		<button type="submit" name="submitAddproductAndStay" class="btn btn-default pull-right" disabled="disabled"><i class="process-icon-loading"></i> {l s='Enregistrer et rester'}</button>
	</div>
</div>
<script type="text/javascript">
	if (tabs_manager.allow_hide_other_languages)
		hideOtherLanguage({$default_form_language});
</script>
