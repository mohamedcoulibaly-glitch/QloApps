<div class="bootstrap">
	<a class="sr-only" href="#content">{l s='Aller au contenu'}</a>
	<nav id="{if $employee->bo_menu}nav-sidebar{else}nav-topbar{/if}" role="navigation" aria-label="{l s='Navigation principale'}">
		{if !$tab}
			<div class="mainsubtablist" hidden></div>
		{/if}
		<ul class="menu" role="menubar">
			<li class="searchtab">
				{include file="search_form.tpl" id="header_search" show_clear_btn=1}
			</li>
			{foreach $tabs as $t}
				{if $t.active}
				<li class="maintab {if $t.current}active{/if} {if $t.sub_tabs|@count}has_submenu{/if}" id="maintab-{$t.class_name}" data-submenu="{$t.id_tab}" role="none">
					<a href="{if $t.sub_tabs|@count && isset($t.sub_tabs[0].href)}{$t.sub_tabs[0].href|escape:'html':'UTF-8'}{else}{$t.href|escape:'html':'UTF-8'}{/if}" class="title"{if $t.current} aria-current="page"{/if}>
						<i class="icon-{$t.class_name}" aria-hidden="true"></i>
						<span>{if $t.name eq ''}{$t.class_name|escape:'html':'UTF-8'}{else}{$t.name|escape:'html':'UTF-8'}{/if}</span>
					</a>
					{if $t.sub_tabs|@count}
						<ul class="submenu" role="menu">
						{foreach from=$t.sub_tabs item=t2}
							{if $t2.active}
							<li id="subtab-{$t2.class_name|escape:'html':'UTF-8'}" {if $t2.current} class="active"{/if} role="none">
								<a href="{$t2.href|escape:'html':'UTF-8'}" role="menuitem"{if $t2.current} aria-current="page"{/if}>
									{if $t2.name eq ''}{$t2.class_name|escape:'html':'UTF-8'}{else}{$t2.name|escape:'html':'UTF-8'}{/if}
								</a>
							</li>
							{/if}
						{/foreach}
						</ul>
					{/if}
				</li>
				{/if}
			{/foreach}
		</ul>
		<button type="button" class="menu-collapse" aria-label="{l s='Basculer la barre latérale'}" aria-expanded="true">
			<i class="icon-align-justify icon-rotate-90" aria-hidden="true"></i>
		</button>
		{hook h='displayAdminNavBarBeforeEnd'}
	</nav>
</div>
