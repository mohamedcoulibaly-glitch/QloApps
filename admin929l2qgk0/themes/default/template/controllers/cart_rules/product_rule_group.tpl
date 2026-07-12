<tr id="product_rule_group_{$product_rule_group_id|intval}_tr">
	<td>
		<a class="btn btn-default" href="javascript:removeProductRuleGroup({$product_rule_group_id|intval});">
			<i class="icon-remove text-danger"></i>
		</a>
	</td>
	<td>


		<div class="form-group">
			<label class="control-label col-lg-4">{l s='Le panier doit contenir au moins'}</label>
			<div class="col-lg-1">
				<input type="hidden" name="product_rule_group[]" value="{$product_rule_group_id|intval}" />
				<input class="form-control" type="text" name="product_rule_group_{$product_rule_group_id|intval}_quantity" value="{$product_rule_group_quantity|intval}" />
			</div>
			<div class="col-lg-7">
				<label  class="control-label pull-left">{l s='Type(s) de chambre correspondant aux règles suivantes :'}</label>
			</div>
		</div>



		<div class="form-group">

			<label class="control-label col-lg-4">{l s='Ajouter une règle concernant'}</label>
			<div class="col-lg-4">
				<select class="form-control" id="product_rule_type_{$product_rule_group_id|intval}">
					<option value="">{l s='-- Choisir --'}</option>
					<option value="products">{l s='Types de chambres'}</option>
					{*<option value="attributes">{l s='Attributs'}</option>
					<option value="categories">{l s='Catégories'}</option>
					<option value="manufacturers">{l s='Fabricants'}</option>
					<option value="suppliers">{l s='Fournisseurs'}</option>*}
				</select>
			</div>
			<div class="col-lg-4">
				<a class="btn btn-default" href="javascript:addProductRule({$product_rule_group_id|intval});">
					<i class="icon-plus-sign"></i>
					{l s="Add"}
				</a>
			</div>

		</div>

		{l s='Le(s) type(s) de chambre correspondent à l&#039;un de ces éléments :'}
		<table id="product_rule_table_{$product_rule_group_id|intval}" class="table table-bordered">
			{if isset($product_rules) && $product_rules|@count}
				{foreach from=$product_rules item='product_rule'}
					{$product_rule}
				{/foreach}
			{/if}
		</table>

	</td>
</tr>
