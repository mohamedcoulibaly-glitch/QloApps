<div class="form-group">
	<label class="control-label col-lg-3 required">
		<span class="label-tooltip" data-toggle="tooltip"
		title="{l s='Ceci sera affiché dans le récapitulatif du panier, ainsi que sur la facture.'}">
			{l s='Nom'}
		</span>
	</label>
	<div class="col-lg-8">
		{foreach from=$languages item=language}
		{if $languages|count > 1}
		<div class="row">
			<div class="translatable-field lang-{$language.id_lang}" {if $language.id_lang != $id_lang_default}style="display:none"{/if}>
				<div class="col-lg-9">
		{/if}
					<input id="name_{$language.id_lang|intval}" type="text"  name="name_{$language.id_lang|intval}" value="{$currentTab->getFieldValue($currentObject, 'name', $language.id_lang|intval)|escape:'html':'UTF-8'}">
		{if $languages|count > 1}
				</div>
				<div class="col-lg-2">
					<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
						{$language.iso_code}
						<span class="caret"></span>
					</button>
					<ul class="dropdown-menu">
						{foreach from=$languages item=language}
						<li><a href="javascript:hideOtherLanguage({$language.id_lang});" tabindex="-1">{$language.name}</a></li>
						{/foreach}
					</ul>
				</div>
			</div>
		</div>
		{/if}
		{/foreach}
	</div>
</div>

<div class="form-group">
	<label class="control-label col-lg-3">
		<span class="label-tooltip" data-toggle="tooltip"
		title="{l s='Réservé à vos yeux. Cela ne sera jamais affiché au client.'}">
			{l s='Description'}
		</span>
	</label>
	<div class="col-lg-8">
		<textarea name="description" rows="2" class="textarea-autosize">{$currentTab->getFieldValue($currentObject, 'description')|escape}</textarea>
	</div>
</div>

<div class="form-group">
	<label class="control-label col-lg-3">
		<span class="label-tooltip" data-toggle="tooltip"
		title="{l s='C&#039;est le code que les utilisateurs doivent saisir pour appliquer le bon de réduction au panier.'}">
			{l s='Code'}
		</span>
	</label>
	<div class="col-lg-9">
		<div class="input-group col-lg-4">
			<input type="text" id="code" name="code" value="{$currentTab->getFieldValue($currentObject, 'code')|escape}" />
			<span class="input-group-btn">
				<a href="javascript:gencode(8);" class="btn btn-default"><i class="icon-random"></i> {l s='Générer'}</a>
			</span>
		</div>
	<span class="help-block">{l s='Attention ! Si vous laissez ce champ vide, la règle sera automatiquement appliquée aux clients bénéficiaires.'}</span>
	</div>
</div>

<div class="form-group">
	<label class="control-label col-lg-3">
		<span class="label-tooltip" data-toggle="tooltip"
		title="{l s='Si le bon de réduction n&#039;est pas encore dans le panier, il sera affiché dans le récapitulatif du panier.'}">
			{l s='Mettre en avant'}
		</span>
	</label>
	<div class="col-lg-9">
		<span class="switch prestashop-switch fixed-width-lg">
			<input type="radio" name="highlight" id="highlight_on" value="1" {if $currentTab->getFieldValue($currentObject, 'highlight')|intval}checked="checked"{/if}/>
			<label for="highlight_on">{l s='Oui'}</label>
			<input type="radio" name="highlight" id="highlight_off" value="0"  {if !$currentTab->getFieldValue($currentObject, 'highlight')|intval}checked="checked"{/if} />
			<label for="highlight_off">{l s='Non'}</label>
			<a class="slide-button btn"></a>
		</span>
	</div>
</div>

<div class="form-group">
	<label class="control-label col-lg-3">
		<span class="label-tooltip" data-toggle="tooltip"
		title="{l s='Applicable uniquement si la valeur du bon de réduction est supérieure au total du panier.'}
		{l s='Si vous n&#039;autorisez pas l&#039;utilisation partielle, la valeur du bon de réduction sera réduite au montant total de la commande. Si vous autorisez l&#039;utilisation partielle, un nouveau bon de réduction sera créé avec le reste.'}">
			{l s='Utilisation partielle'}
		</span>
	</label>
	<div class="col-lg-9">
		<span class="switch prestashop-switch fixed-width-lg">
			<input type="radio" name="partial_use" id="partial_use_on" value="1" {if $currentTab->getFieldValue($currentObject, 'partial_use')|intval}checked="checked"{/if} />
			<label class="t" for="partial_use_on">{l s='Oui'}</label>
			<input type="radio" name="partial_use" id="partial_use_off" value="0"  {if !$currentTab->getFieldValue($currentObject, 'partial_use')|intval}checked="checked"{/if} />
			<label class="t" for="partial_use_off">{l s='Non'}</label>
			<a class="slide-button btn"></a>
		</span>
	</div>
</div>

<div class="form-group">
	<label class="control-label col-lg-3">
		<span class="label-tooltip" data-toggle="tooltip"
		title="{l s='Les règles de panier sont appliquées par priorité. Une règle de panier avec une priorité de "1" sera traitée avant une règle de panier avec une priorité de "2".'}">
			{l s='Priorité'}
		</span>
	</label>
	<div class="col-lg-1">
		<input type="text" class="input-mini" name="priority" value="{$currentTab->getFieldValue($currentObject, 'priority')|intval}" />
	</div>
</div>

<div class="form-group">
	<label class="control-label col-lg-3">{l s='Statut'}</label>
	<div class="col-lg-9">
		<span class="switch prestashop-switch fixed-width-lg">
			<input type="radio" name="active" id="active_on" value="1" {if $currentTab->getFieldValue($currentObject, 'active')|intval}checked="checked"{/if} />
			<label class="t" for="active_on">{l s='Oui'}</label>
			<input type="radio" name="active" id="active_off" value="0"  {if !$currentTab->getFieldValue($currentObject, 'active')|intval}checked="checked"{/if} />
			<label class="t" for="active_off">{l s='Non'}</label>
			<a class="slide-button btn"></a>
		</span>
	</div>
</div>
<script type="text/javascript">
	$(".textarea-autosize").autosize();
</script>
