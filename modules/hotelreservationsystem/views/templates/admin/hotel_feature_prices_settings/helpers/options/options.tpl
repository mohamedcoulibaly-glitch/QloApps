<div class="panel">
	<h3>{l s='Gestion des priorités' mod='hotelreservationsystem'}</h3>
	<div class="alert alert-info">
		{l s='Parfois, un client peut correspondre à plusieurs règles de prix avancées. Dans ce cas, les priorités vous permettent de définir quelle règle s\'applique au type de chambre.' mod='hotelreservationsystem'}
	</div>
	<form id="{$table|escape:'htmlall':'UTF-8'}_form" class="defaultForm form-horizontal" action="{$current|escape:'htmlall':'UTF-8'}&{if !empty($submit_action)}{$submit_action|escape:'htmlall':'UTF-8'}{/if}&token={$token|escape:'htmlall':'UTF-8'}" method="post" enctype="multipart/form-data" {if isset($style)}style="{$style|escape:'htmlall':'UTF-8'}"{/if}>
		<div class="form-group">
			<label class="control-label col-lg-3" for="featurePricePriority">{l s='Priorités de calcul du prix avancé' mod='hotelreservationsystem'} :: </label>
			<div class="input-group col-lg-9">
				<select name="featurePricePriority[]" class="featurePricePriority">
					<option class="specific_date" value="specific_date" {if isset($featurePricePriority) && $featurePricePriority[0]=='specific_date'}selected="selected"{/if}>{l s="Date spécifique" mod='hotelreservationsystem'}</option>
					<option class="special_day" value="special_day" {if isset($featurePricePriority) && $featurePricePriority[0]=='special_day'}selected="selected"{/if}>{l s="Jours spéciaux" mod='hotelreservationsystem'}</option>
					<option class="date_range" value="date_range" {if isset($featurePricePriority) && $featurePricePriority[0]=='date_range'}selected="selected"{/if}>{l s="Plages de dates" mod='hotelreservationsystem'}</option>
				</select>
				<span class="input-group-addon"><i class="icon-chevron-right"></i></span>
				<select name="featurePricePriority[]" class="featurePricePriority">
					<option class="specific_date" value="specific_date" {if isset($featurePricePriority) && $featurePricePriority[1]=='specific_date'}selected="selected"{/if}>{l s="Date spécifique" mod='hotelreservationsystem'}</option>
					<option class="special_day" value="special_day" {if isset($featurePricePriority) && $featurePricePriority[1]=='special_day'}selected="selected"{/if}>{l s="Jours spéciaux" mod='hotelreservationsystem'}</option>
					<option class="date_range" value="date_range" {if isset($featurePricePriority) && $featurePricePriority[1]=='date_range'}selected="selected"{/if}>{l s="Plages de dates" mod='hotelreservationsystem'}</option>
				</select>
				<span class="input-group-addon"><i class="icon-chevron-right"></i></span>
				<select name="featurePricePriority[]" class="featurePricePriority">
					<option class="specific_date" value="specific_date" {if isset($featurePricePriority) && $featurePricePriority[2]=='specific_date'}selected="selected"{/if}>{l s="Date spécifique" mod='hotelreservationsystem'}</option>
					<option class="special_day" value="special_day" {if isset($featurePricePriority) && $featurePricePriority[2]=='special_day'}selected="selected"{/if}>{l s="Jours spéciaux" mod='hotelreservationsystem'}</option>
					<option class="date_range" value="date_range" {if isset($featurePricePriority) && $featurePricePriority[2]=='date_range'}selected="selected"{/if}>{l s="Plages de dates" mod='hotelreservationsystem'}</option>
				</select>
			</div>
		</div>
		<div class="panel-footer">
			<button type="submit" name="submitAddFeaturePricePriority" class="btn btn-default pull-right">
				<i class="process-icon-save"></i> {l s='Enregistrer' mod='hotelreservationsystem'}
			</button>
		</div>
	</form>
</div>
