{*
* NOTICE OF LICENSE
*
* This source file is subject to the Open Software License version 3.0
* that is bundled with this package in the file LICENSE.md
* It is also available through the world-wide-web at this URL:
* https://opensource.org/license/osl-3-0-php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to support@qloapps.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade this module to a newer
* versions in the future. If you wish to customize this module for your needs
* please refer to https://store.webkul.com/customisation-guidelines for more information.
*
* @author Webkul IN
* @copyright Since 2010 Webkul
* @license https://opensource.org/license/osl-3-0-php Open Software License version 3.0
*}

{if isset($product->id)}
    <input type="hidden" name="occupancy_loaded" value="1">
	<div id="product-occupancy" class="panel product-tab">
		<input type="hidden" name="submitted_tabs[]" value="Occupancy" />
		<h3 class="tab"> <i class="icon-users"></i> {l s='Occupation'}</h3>

        <div class="alert alert-info">
            {l s='Ci-dessous, entrez l&#039;occupation de base de ce type de chambre.'}
            <p><b>{l s='Note'}</b>: {l s='Minimum 1 adulte est obligatoire dans l&#039;occupation de base du type de chambre'}</p>
        </div>

		<div class="form-group">
			<label class="control-label col-sm-2" for="base_adults">
                <span class="label-tooltip" data-toggle="tooltip"
				title="{l s=''}">
                    {l s='Adultes de base'}
                </span>
			</label>
			<div class="col-sm-3">
				<input id="base_adults" type="text" name="base_adults" class="form-control" value="{if isset($smarty.post.base_adults)}{$smarty.post.base_adults|escape:'html':'UTF-8'}{elseif isset($roomTypeInfo['adults'])}{$roomTypeInfo['adults']|escape:'html':'UTF-8'}{else}2{/if}">
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-2" for="base_children">
                <span class="label-tooltip" data-toggle="tooltip"
				title="{l s=''}">
                    {l s='Enfants de base'}
                </span>
			</label>
			<div class="col-sm-3">
				<input id="base_children" type="text" name="base_children" class="form-control" value="{if isset($smarty.post.base_children)}{$smarty.post.base_children|escape:'html':'UTF-8'}{elseif isset($roomTypeInfo['children'])}{$roomTypeInfo['children']|escape:'html':'UTF-8'}{else}0{/if}">
			</div>
		</div>
        <input id="is_occupancy_submit" type="hidden" name="is_occupancy_submit" class="form-control" value="0">

        <hr>

        <div class="alert alert-info">
            {l s='Ci-dessous, entrez le nombre maximum d&#039;adultes et d&#039;enfants pouvant être hébergés dans une chambre de ce type.'}
			<br>
            {l s='Pour l&#039;occupation maximale de la chambre, le nombre total d&#039;invités pouvant être hébergés dans une chambre de ce type.'}
        </div>

        <div class="form-group">
			<label class="control-label col-sm-2" for="max_adults">
                <span class="label-tooltip" data-toggle="tooltip"
				title="{l s='Entrez le nombre maximum d&#039;adultes pouvant être hébergés dans une chambre de ce type.'}">
                    {l s='Adultes maximum'}
                </span>
			</label>
			<div class="col-sm-3">
				<input id="max_adults" type="text" name="max_adults" class="form-control" value="{if isset($smarty.post.max_adults)}{$smarty.post.max_adults|escape:'html':'UTF-8'}{elseif isset($roomTypeInfo['max_adults'])}{$roomTypeInfo['max_adults']|escape:'html':'UTF-8'}{/if}">
			</div>
		</div>
        <div class="form-group">
			<label class="control-label col-sm-2" for="max_children">
                <span class="label-tooltip" data-toggle="tooltip"
				title="{l s='Entrez le nombre maximum d&#039;enfants pouvant être hébergés dans une chambre de ce type.'}">
                    {l s='Enfants maximum'}
                </span>
			</label>
			<div class="col-sm-3">
				<input id="max_children" type="text" name="max_children" class="form-control" value="{if isset($smarty.post.max_children)}{$smarty.post.max_children|escape:'html':'UTF-8'}{elseif isset($roomTypeInfo['max_children'])}{$roomTypeInfo['max_children']|escape:'html':'UTF-8'}{/if}">
			</div>
		</div>
        <div class="form-group">
			<label class="control-label col-sm-2" for="max_guests">
                <span class="label-tooltip" data-toggle="tooltip"
				title="{l s='Entrez le nombre maximum d&#039;invités pouvant être hébergés dans une chambre de ce type.'}">
                    {l s='Occupation maximale de la chambre'}
                </span>
			</label>
			<div class="col-sm-3">
				<input id="max_guests" type="text" name="max_guests" class="form-control" value="{if isset($smarty.post.max_guests)}{$smarty.post.max_guests|escape:'html':'UTF-8'}{elseif isset($roomTypeInfo['max_guests'])}{$roomTypeInfo['max_guests']|escape:'html':'UTF-8'}{/if}">
			</div>
		</div>

		<div class="panel-footer">
			<a href="{$link->getAdminLink('AdminProducts')|escape:'html':'UTF-8'}{if isset($smarty.request.page) && $smarty.request.page > 1}&amp;submitFilterproduct={$smarty.request.page|intval}{/if}" class="btn btn-default">
				<i class="process-icon-cancel"></i>
				{l s='Annuler'}
			</a>
			<button type="submit" name="submitAddproduct" class="btn btn-default pull-right checkOccupancySubmit" disabled="disabled">
				<i class="process-icon-loading"></i>
				{l s='Enregistrer'}
			</button>
			<button type="submit" name="submitAddproductAndStay" class="btn btn-default pull-right checkOccupancySubmit"  disabled="disabled">
				<i class="process-icon-loading"></i>
					{l s='Enregistrer et rester'}
			</button>
		</div>
	</div>
{/if}

<script>
    $(document).ready(function() {
        $(".checkOccupancySubmit").on("click", function() {
            $("#is_occupancy_submit").val(1);
            return true;
        });
    });
</script>