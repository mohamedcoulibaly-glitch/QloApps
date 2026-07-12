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
<div id="container-customer">
	<div class="row">
		{*left*}
		<div class="col-lg-6">
			<div class="panel clearfix">
				<div class="panel-heading">
					<i class="icon-user"></i>
					{$customer->firstname}
					{$customer->lastname}
					[{$customer->id|string_format:"%06d"}]
					-
					<a href="mailto:{$customer->email}"><i class="icon-envelope"></i>
						{$customer->email}
					</a>
					<div class="panel-heading-action">
						<a class="btn btn-default" href="{$current|escape:'html':'UTF-8'}&amp;updatecustomer&amp;id_customer={$customer->id|intval}&amp;token={$token|escape:'html':'UTF-8'}&amp;back={$smarty.server.REQUEST_URI|urlencode}">
							<i class="icon-edit"></i>
							{l s='Modifier'}
						</a>
					</div>
				</div>
				<div class="form-horizontal">
					<div class="row">
						<label class="control-label col-lg-3">{l s='Civilité'}</label>
						<div class="col-lg-9">
							<p class="form-control-static">{if $gender->name}{$gender->name}{else}{l s='Inconnu'}{/if}</p>
						</div>
					</div>
					<div class="row">
						<label class="control-label col-lg-3">{l s='Téléphone'}</label>
						<div class="col-lg-9">
							<p class="form-control-static">{$customer->phone}</p>
						</div>
					</div>
					<div class="row">
						<label class="control-label col-lg-3">{l s='Âge'}</label>
						<div class="col-lg-9">
							<p class="form-control-static">
								{if isset($customer->birthday) && $customer->birthday != '0000-00-00'}
									{l s='%1$d ans (date de naissance : %2$s)' sprintf=[$customer_stats['age'], $customer_birthday]}
								{else}
									{l s='Inconnu'}
								{/if}
							</p>
						</div>
					</div>
					<div class="row">
						<label class="control-label col-lg-3">{l s='Date d&#039;inscription'}</label>
						<div class="col-lg-9">
							<p class="form-control-static">{$registration_date}</p>
						</div>
					</div>
					<div class="row">
						<label class="control-label col-lg-3">{l s='Dernière visite'}</label>
						<div class="col-lg-9">
							<p class="form-control-static">{if $customer_stats['last_visit']}{$last_visit}{else}{l s='Jamais'}{/if}</p>
						</div>
					</div>
					{if $count_better_customers != '-'}
						<div class="row">
							<label class="control-label col-lg-3">{l s='Classement meilleur client'}</label>
							<div class="col-lg-9">
								<p class="form-control-static">{$count_better_customers}</p>
							</div>
						</div>
					{/if}
					{if $shop_is_feature_active}
						<div class="row">
							<label class="control-label col-lg-3">{l s='Boutique'}</label>
							<div class="col-lg-9">
								<p class="form-control-static">{$name_shop}</p>
							</div>
						</div>
					{/if}
					<div class="row">
						<label class="control-label col-lg-3">{l s='Langue'}</label>
						<div class="col-lg-9">
							<p class="form-control-static">
								{if isset($customerLanguage)}
									{$customerLanguage->name}
								{else}
									{l s='Inconnu'}
								{/if}
							</p>
						</div>
					</div>
					<div class="row">
						<label class="control-label col-lg-3">{l s='Inscriptions'}</label>
						<div class="col-lg-9">
							<p class="form-control-static">
								{if $customer->newsletter}
									<span class="label label-success">
										<i class="icon-check"></i>
										{l s='Newsletter'}
									</span>
								{else}
									<span class="label label-danger">
										<i class="icon-remove"></i>
										{l s='Newsletter'}
									</span>
								{/if}
								&nbsp;
								{if $customer->optin}
									<span class="label label-success">
										<i class="icon-check"></i>
										{l s='Opt-in'}
									</span>
									{else}
									<span class="label label-danger">
										<i class="icon-remove"></i>
										{l s='Opt-in'}
									</span>
								{/if}
							</p>
						</div>
					</div>
					<div class="row">
						<label class="control-label col-lg-3">{l s='Dernière mise à jour'}</label>
						<div class="col-lg-9">
							<p class="form-control-static">{$last_update}</p>
						</div>
					</div>
					<div class="row">
						<label class="control-label col-lg-3">{l s='Statut'}</label>
						<div class="col-lg-9">
							<p class="form-control-static">
								{if !$customer->deleted}
									{if $customer->active}
										<span class="label label-success">
											<i class="icon-check"></i>
											{l s='Actif'}
										</span>
									{else}
										<span class="label label-danger">
											<i class="icon-remove"></i>
											{l s='Inactif'}
										</span>
									{/if}
								{elseif $customer->deleted == Customer::STATUS_BANNED}
									<span class="label label-warning">
										<i class="icon-remove"></i>
										{l s='Banni'}
									</span>
								{elseif $customer->deleted == Customer::STATUS_DELETED}
									<span class="label label-danger">
										<i class="icon-remove"></i>
										{l s='Supprimé'}
									</span>
								{/if}
							</p>
						</div>
					</div>
				</div>
				{if $customer->isGuest()}
					{l s='Ce client est enregistré en tant qu&#039;invité.'}
					{if !$customer_exists}
					<form method="post" action="index.php?tab=AdminCustomers&amp;id_customer={$customer->id|intval}&amp;token={getAdminToken tab='AdminCustomers'}">
						<input type="hidden" name="id_lang" value="{$id_lang}" />
						<p class="text-center">
							<input class="button" type="submit" name="submitGuestToCustomer" value="{l s='Transformer en compte client'}" />
						</p>
						{l s='Cette fonctionnalité génère un mot de passe aléatoire avant d&#039;envoyer un e-mail à votre client.'}
					</form>
					{else}
					<p class="text-muted text-center">
						{l s='Un compte client enregistré utilisant l&#039;adresse e-mail définie existe déjà. '}
					</p>
					{/if}
				{/if}
			</div>
			<div class="panel">
				<div class="panel-heading">
					<i class="icon-file"></i> {l s='Commandes'} <span class="badge">{count($orders)}</span>
				</div>
				{if $orders AND count($orders)}
					{assign var=count_ok value=count($orders_ok)}
					{assign var=count_ko value=count($orders_ko)}
					{if $count_ok || $count_ko}
						<div class="nav nav-tabs">
							<ul class="nav nav-tabs">
								<li {if $count_ok}class="active"{/if}>
									<a data-toggle="tab" href="#valid_orders">
										<i class="icon-ok-circle icon-big"></i>
										{l s='Commandes valides :'}
										<span class="label label-success">{$count_ok}</span>
									</a>
								</li>
								<li {if !$count_ok && $count_ko}class="active"{/if}>
									<a data-toggle="tab" href="#invalid_orders">
										<i class="icon-exclamation-sign icon-big"></i>
										{l s='Commandes invalides :'}
										<span class="label label-danger">{$count_ko}</span>
									</a>
								</li>
							</ul>
							<div class="tab-content panel">
								<div class="tab-pane {if $count_ok}active{/if}" id="valid_orders">
									<div class="row">
										<div class="col-lg-5">
											{l s='Montant total reçu : %s' sprintf=$total_ok}
										</div>
									</div>
									<hr>
									{if $count_ok}
										<table class="table">
											<thead>
												<tr>
													<th class="center"><span class="title_box ">{l s='ID'}</span></th>
													<th><span class="title_box">{l s='Date'}</span></th>
													<th><span class="title_box">{l s='Paiement'}</span></th>
													<th><span class="title_box">{l s='Statut'}</span></th>
													<th><span class="title_box">{l s='Produits'}</span></th>
													<th><span class="title_box ">{l s='Total dépensé'}</span></th>
													<th></th>
												</tr>
											</thead>
											<tbody>
											{foreach $orders_ok AS $key => $order}
												<tr onclick="document.location = '?tab=AdminOrders&amp;id_order={$order['id_order']|intval}&amp;vieworder&amp;token={getAdminToken tab='AdminOrders'}'">
													<td>{$order['id_order']}</td>
													<td>{dateFormat date=$order['date_add'] full=0}</td>
													<td>{$order['payment']}</td>
													<td>{$order['order_state']}</td>
													<td>{$order['nb_products']}</td>
													<td>{$order['total_paid_real']}</td>
													<td>
														<a class="btn btn-default" href="?tab=AdminOrders&amp;id_order={$order['id_order']|intval}&amp;vieworder&amp;token={getAdminToken tab='AdminOrders'}">
															<i class='icon-search'></i> {l s='Voir'}
														</a>
													</td>
												</tr>
											{/foreach}
											</tbody>
										</table>
									{else}
										<p class="text-muted text-center">
											{l s='Aucune commande valide trouvée !!'}
										</p>
									{/if}
								</div>

								<div class="tab-pane {if !$count_ok && $count_ko}active{/if}" id="invalid_orders">
									<div class="row">
										<div class="col-lg-5">
											{l s='Total de la commande : %s' sprintf=$total_ko}
										</div>
									</div>
									<hr>
									{if $count_ko}
										<table class="table">
											<thead>
												<tr>
													<th><span class="title_box ">{l s='ID'}</span></th>
													<th><span class="title_box ">{l s='Date'}</span></th>
													<th><span class="title_box ">{l s='Paiement'}</span></th>
													<th><span class="title_box ">{l s='Statut'}</span></th>
													<th><span class="title_box ">{l s='Produits'}</span></th>
													<th><span class="title_box ">{l s='Total dépensé'}</span></th>
													<th></th>
												</tr>
											</thead>
											<tbody>
												{foreach $orders_ko AS $key => $order}
												<tr onclick="document.location = '?tab=AdminOrders&amp;id_order={$order['id_order']|intval}&amp;vieworder&amp;token={getAdminToken tab='AdminOrders'}'">
													<td>{$order['id_order']}</td>
													<td>{dateFormat date=$order['date_add'] full=0}</a></td>
													<td>{$order['payment']}</td>
													<td>{$order['order_state']}</td>
													<td>{$order['nb_products']}</td>
													<td>{$order['total_paid_real']}</td>
													<td>
														<a class="btn btn-default" href="?tab=AdminOrders&amp;id_order={$order['id_order']|intval}&amp;vieworder&amp;token={getAdminToken tab='AdminOrders'}">
															<i class='icon-search'></i> {l s='Voir'}
														</a>
													</td>
												</tr>
												{/foreach}
											</tbody>
										</table>
									{else}
										<p class="text-muted text-center">
											{l s='Aucune commande invalide trouvée !!'}
										</p>
									{/if}
								</div>
							</div>
						</div>
					{/if}

				{else}
					<p class="text-muted text-center">
						{l s='%1$s %2$s n&#039;a pas encore passé de commande' sprintf=[$customer->firstname, $customer->lastname]}
					</p>
				{/if}
			</div>

			<div class="panel">
				<div class="panel-heading">
					<i class="icon-shopping-cart"></i> {l s='Paniers'} <span class="badge">{count($carts)}</span>
				</div>
				{if $carts AND count($carts)}
					<table class="table">
						<thead>
							<tr>
								<th><span class="title_box ">{l s='ID'}</span></th>
								<th><span class="title_box ">{l s='Date'}</span></th>
								<th><span class="title_box ">{l s='Total'}</span></th>
							</tr>
						</thead>
						<tbody>
						{foreach $carts AS $key => $cart}
							<tr onclick="document.location = '?tab=AdminCarts&amp;id_cart={$cart['id_cart']|intval}&amp;viewcart&amp;token={getAdminToken tab='AdminCarts'}'">
								<td>{$cart['id_cart']}</td>
								<td>
									<a href="index.php?tab=AdminCarts&amp;id_cart={$cart['id_cart']}&amp;viewcart&amp;token={getAdminToken tab='AdminCarts'}">
										{dateFormat date=$cart['date_upd'] full=0}
									</a>
								</td>
								<td>{$cart['total_price']}</td>
							</tr>
						{/foreach}
						</tbody>
					</table>
				{else}
				<p class="text-muted text-center">
					{l s='Aucun panier disponible'}
				</p>
				{/if}
			</div>
			{if $products AND count($products)}
				<div class="panel">
					<div class="panel-heading">
						<i class="icon-archive"></i> {l s='Types de chambres et services'} <span class="badge">{count($products)}</span>
					</div>
					<div class="nav nav-tabs">
						<ul class="nav nav-tabs">
							{assign var=count_room_types value=count($purchasedRoomTypes)}
							{assign var=count_services value=count($purchasedServices)}
							{if $count_room_types}
								<li class="active">
									<a data-toggle="tab" href="#purchased_room_types">
										{l s='Types de chambres'}
										<span class="label label-success">{$count_room_types}</span>
									</a>
								</li>
							{/if}
							{if $count_services}
								<li {if !$count_room_types} class="active" {/if}>
									<a data-toggle="tab" href="#purchased_services">
										{l s='Services :'}
										<span class="label label-success">{$count_services}</span>
									</a>
								</li>
							{/if}
						</ul>
						<div class="tab-content panel">
							{if $count_room_types}
								<div class="tab-pane active" id="purchased_room_types">
									<table class="table">
										<thead>
											<tr>
												<th><span class="title_box">{l s='ID Commande'}</span></th>
												<th><span class="title_box">{l s='Nom'}</span></th>
												<th><span class="title_box">{l s='Nuits réservées'}</span></th>
												<th><span class="title_box">{l s='Date de réservation'}</span></th>
											</tr>
										</thead>
										<tbody>
											{foreach $purchasedRoomTypes AS $key => $product}
											<tr onclick="document.location = '?tab=AdminOrders&amp;id_order={$product['id_order']|intval}&amp;vieworder&amp;token={getAdminToken tab='AdminOrders'}'">
												<td>
													<a href="?tab=AdminOrders&amp;id_order={$product['id_order']}&amp;vieworder&amp;token={getAdminToken tab='AdminOrders'}">
														#{$product['id_order']}
													</a>
												</td>
												<td>
													{$product['product_name']}
												</td>
												<td>{$product['product_quantity']}</td>
												<td>{dateFormat date=$product['date_add'] full=0}</td>
											</tr>
											{/foreach}
										</tbody>
									</table>
								</div>
							{/if}
							{if $count_services}
								<div class="tab-pane {if !$count_room_types}active{/if}" id="purchased_services">
									<table class="table">
										<thead>
											<tr>
												<th><span class="title_box">{l s='ID Commande'}</span></th>
												<th><span class="title_box">{l s='Nom'}</span></th>
												<th><span class="title_box">{l s='Quantité'}</span></th>
												<th><span class="title_box">{l s='Date de réservation'}</span></th>
											</tr>
										</thead>
										<tbody>
											{foreach $purchasedServices AS $key => $product}
											<tr onclick="document.location = '?tab=AdminOrders&amp;id_order={$product['id_order']|intval}&amp;vieworder&amp;token={getAdminToken tab='AdminOrders'}'">
												<td>
													<a href="?tab=AdminOrders&amp;id_order={$product['id_order']}&amp;vieworder&amp;token={getAdminToken tab='AdminOrders'}">
														#{$product['id_order']}
													</a>
												</td>
												<td>
													{$product['product_name']}
												</td>
												<td>{$product['product_quantity']}</td>
												<td>{dateFormat date=$product['date_add'] full=0}</td>
											</tr>
											{/foreach}
										</tbody>
									</table>
								</div>
							{/if}
						</div>
					</div>
				</div>
			{/if}
			{if count($interested)}
			<div class="panel">
				<div class="panel-heading">
					<i class="icon-eye"></i> {l s='Types de chambres consultés'} <span class="badge">{count($interested)}</span>
				</div>
				<table class="table">
					<thead>
						<tr>
							<th><span class="title_box ">{l s='ID'}</span></th>
							<th><span class="title_box ">{l s='Nom'}</span></th>
						</tr>
					</thead>
					<tbody>
					{foreach $interested as $key => $p}
						<tr onclick="document.location = '{$p['url']|escape:'html':'UTF-8'}'">
							<td>{$p['id']}</td>
							<td><a href="{$p['url']|escape:'html':'UTF-8'}">{$p['name']}</a></td>
						</tr>
					{/foreach}
					</tbody>
				</table>
			</div>
			{/if}
		</div>
		{*right*}
		<div class="col-lg-6">
			<div class="panel">
				<div class="panel-heading">
					<i class="icon-eye-close"></i> {l s='Ajouter une note privée'}
				</div>
				<div class="alert alert-info">{l s='Cette note sera affichée à tous les employés mais pas aux clients.'}</div>
				<form id="customer_note" class="form-horizontal" action="ajax.php" method="post" onsubmit="saveCustomerNote({$customer->id|intval});return false;" >
					<div class="form-group">
						<div class="col-lg-12">
							<textarea name="note" id="noteContent" onkeyup="$('#submitCustomerNote').removeAttr('disabled');">{$customer_note}</textarea>
						</div>
					</div>
					<div class="row">
						<div class="col-lg-12">
							<button type="submit" id="submitCustomerNote" class="btn btn-default pull-right" disabled="disabled">
								<i class="icon-save"></i>
								{l s='Enregistrer'}
							</button>
						</div>
					</div>
					<span id="note_feedback"></span>
				</form>
			</div>
			<div class="panel">
				<div class="panel-heading">
					<i class="icon-envelope"></i> {l s='Messages'} <span class="badge">{count($messages)}</span>
				</div>
				{if count($messages)}
					<table class="table">
						<thead>
							<th class="fixed-width-sm"><span class="title_box">{l s='Statut'}</span></th>
							<th><span class="title_box">{l s='Message'}</span></th>
							<th class="fixed-width-lg"><span class="title_box">{l s='Envoyé le'}</span></th>
						</thead>
						{foreach $messages AS $message}
							<tr>
								<td>{if $message['status'] == CustomerThread::QLO_CUSTOMER_THREAD_STATUS_OPEN}
										{l s='Ouvert'}
									{elseif $message['status'] == CustomerThread::QLO_CUSTOMER_THREAD_STATUS_CLOSED}
										{l s='Fermé'}
									{elseif $message['status'] == CustomerThread::QLO_CUSTOMER_THREAD_STATUS_PENDING1}
										{l s='En attente 1'}
									{elseif $message['status'] == CustomerThread::QLO_CUSTOMER_THREAD_STATUS_PENDING2}
										{l s='En attente 2'}
									{/if}
								</td>
								<td>
									<a href="index.php?tab=AdminCustomerThreads&amp;id_customer_thread={$message.id_customer_thread}&amp;viewcustomer_thread&amp;token={getAdminToken tab='AdminCustomerThreads'}">
										{$message['message']}...
									</a>
								</td>
								<td>{$message['date_add']}</td>
							</tr>
						{/foreach}
					</table>
				{else}
				<p class="text-muted text-center">
					{l s='%1$s %2$s ne vous a jamais contacté' sprintf=[$customer->firstname, $customer->lastname]}
				</p>
				{/if}
			</div>
			<div class="panel">
				<div class="panel-heading">
					<i class="icon-ticket"></i> {l s='Bons de réduction'} <span class="badge">{count($discounts)}</span>
				</div>
				{if count($discounts)}
					<table class="table">
						<thead>
							<tr>
								<th><span class="title_box">{l s='ID'}</span></th>
								<th><span class="title_box">{l s='Code'}</span></th>
								<th><span class="title_box">{l s='Nom'}</span></th>
								<th><span class="title_box">{l s='Statut'}</span></th>
								<th><span class="title_box">{l s='Quantité disponible'}</span></th>
								<th><span class="title_box">{l s='Actions'}</span></th>
							<tr/>
						</thead>
						<tbody>
					{foreach $discounts AS $key => $discount}
							<tr>
								<td>{$discount['id_cart_rule']}</td>
								<td>{$discount['code']}</td>
								<td>{$discount['name']}</td>
								<td>
									{if $discount['active']}
										<i class="icon-check"></i>
									{else}
										<i class="icon-remove"></i>
									{/if}
								</td>
								<td>{if $discount['quantity'] > 0}{$discount['quantity_for_user']|intval}{else}0{/if}</td>
								<td>
									<a href="?tab=AdminCartRules&amp;id_cart_rule={$discount['id_cart_rule']|intval}&amp;addcart_rule&amp;token={getAdminToken tab='AdminCartRules'}&amp;back={$smarty.server.REQUEST_URI|urlencode}">
										<i class="icon-pencil"></i>
									</a>
									<a onclick="return confirm('{l s='Êtes-vous sûr ?'}')" href="?tab=AdminCartRules&amp;id_cart_rule={$discount['id_cart_rule']|intval}&amp;deletecart_rule&amp;token={getAdminToken tab='AdminCartRules'}&amp;back={$smarty.server.REQUEST_URI|urlencode}">
										<i class="icon-remove"></i>
									</a>
								</td>
							</tr>
						</tbody>
					{/foreach}
					</table>
				{else}
				<p class="text-muted text-center">
					{l s='%1$s %2$s n&#039;a pas de bons de réduction' sprintf=[$customer->firstname, $customer->lastname]}
				</p>
				{/if}
			</div>

			{if count($emails)}
			<div class="panel">
				<div class="panel-heading">
					<i class="icon-envelope"></i> {l s='Derniers e-mails'}
				</div>
				<table class="table">
					<thead>
					<tr>
						<th><span class="title_box">{l s='Date'}</span></th>
						<th><span class="title_box">{l s='Langue'}</span></th>
						<th><span class="title_box">{l s='Objet'}</span></th>
						<th><span class="title_box">{l s='Modèle'}</span></th>
					</tr>
					</thead>
					<tbody>
					{foreach $emails as $email}
						<tr>
							<td>{dateFormat date=$email['date_add'] full=1}</td>
							<td>{$email['language']}</td>
							<td>{$email['subject']}</td>
							<td>{$email['template']}</td>
						</tr>
					{/foreach}
					</tbody>
				</table>
			</div>
			{/if}

			{if count($connections)}
			<div class="panel">
				<div class="panel-heading">
					<i class="icon-time"></i> {l s='Dernières connexions'}
				</div>
				<table class="table">
					<thead>
					<tr>
						<th><span class="title_box">{l s='ID'}</span></th>
						<th><span class="title_box">{l s='Date'}</span></th>
						<th><span class="title_box">{l s='Pages vues'}</span></th>
						<th><span class="title_box">{l s='Durée totale'}</span></th>
						<th><span class="title_box">{l s='Origine'}</span></th>
						<th><span class="title_box">{l s='Adresse IP'}</span></th>
					</tr>
					</thead>
					<tbody>
					{foreach $connections as $connection}
						<tr>
							<td>{$connection['id_connections']}</td>
							<td>{dateFormat date=$connection['date_add'] full=0}</td>
							<td>{$connection['pages']}</td>
							<td>{$connection['time']}</td>
							<td>{$connection['http_referer']}</td>
							<td>{$connection['ipaddress']}</td>
						</tr>
					{/foreach}
					</tbody>
				</table>
			</div>
			{/if}

			<div class="panel">
				<div class="panel-heading">
					<i class="icon-group"></i>
					{l s='Groupes'}
					<span class="badge">{count($groups)}</span>
					<a class="btn btn-default pull-right" href="{$current|escape:'html':'UTF-8'}&amp;updatecustomer&amp;id_customer={$customer->id|intval}&amp;token={$token|escape:'html':'UTF-8'}">
						<i class="icon-edit"></i> {l s='Modifier'}
					</a>
				</div>
				{if $groups AND count($groups)}
				<table class="table">
					<thead>
						<tr>
							<th><span class="title_box ">{l s='ID'}</span></th>
							<th><span class="title_box ">{l s='Nom'}</span></th>
						</tr>
					</thead>
					<tbody>
						{foreach $groups AS $key => $group}
						<tr onclick="document.location = '?tab=AdminGroups&amp;id_group={$group['id_group']|intval}&amp;viewgroup&amp;token={getAdminToken tab='AdminGroups'}'">
							<td>{$group['id_group']}</td>
							<td>
								<a href="?tab=AdminGroups&amp;id_group={$group['id_group']}&amp;viewgroup&amp;token={getAdminToken tab='AdminGroups'}">
									{$group['name']}
								</a>
							</td>
						</tr>
						{/foreach}
					</tbody>
				</table>
				{/if}
			</div>
			{if $customer_guests && count($customer_guests)}
				<div class="panel">
					<div class="panel-heading">
						<i class="icon-user"></i>
						{l s='Clients invités'}
						<span class="badge customer-guests-count">{count($customer_guests)}</span>
					</div>
					<table class="table customer-guests">
						<thead>
							<tr>
								<th><span class="title_box ">{l s='E-mail'}</span></th>
								<th><span class="title_box ">{l s='Prénom'}</span></th>
								<th><span class="title_box ">{l s='Nom de famille'}</span></th>
								<th><span class="title_box ">{l s='téléphone'}</span></th>
								<th colspan="2"><span class="title_box ">{l s='Actions'}</span></th>
							</tr>
						</thead>
						<tbody>
							{foreach $customer_guests AS $key => $customer_guest}
								<tr class="customer_guest_detail_{$customer_guest['id_customer_guest_detail']} customer_guest_details">
									<td>{$customer_guest['email']}</td>
									<td>{$customer_guest['firstname']}</td>
									<td>{$customer_guest['lastname']}</td>
									<td>{$customer_guest['phone']}</td>
									<td><a href="#" class="edit-customer-guest-detail" data-id_customer_guest_detail="{$customer_guest['id_customer_guest_detail']}"><i class="icon-pencil"></i></a></td>
									<td><a href="#" class="delete-customer-guest-detail" data-id_customer_guest_detail="{$customer_guest['id_customer_guest_detail']}"><i class="icon-trash"></i></a></td>
								</tr>
							{/foreach}
						</tbody>
					</table>
				</div>
			{/if}
		</div>
	</div>

	<div class="row">
		<div class="col-lg-6">

		</div>
		<div class="col-lg-6">
			{if count($referrers)}
			<div class="panel">
				<div class="panel-heading">
					<i class="icon-share-alt"></i> {l s='Référents'}
				</div>
				<table class="table">
					<thead>
						<tr>
							<th><span class="title_box ">{l s='Date'}</span></th>
							<th><span class="title_box ">{l s='Nom'}</span></th>
							{if $shop_is_feature_active}<th>{l s='Boutique'}</th>{/if}
						</tr>
					</thead>
					<tbody>
						{foreach $referrers as $referrer}
						<tr>
							<td>{dateFormat date=$order['date_add'] full=0}</td>
							<td>{$referrer['name']}</td>
							{if $shop_is_feature_active}<td>{$referrer['shop_name']}</td>{/if}
						</tr>
						{/foreach}
					</tbody>
				</table>
			</div>
			{/if}
		</div>
	</div>

	<div class="row">
		{* display hook specified to this page : AdminCustomers *}
		{hook h="displayAdminCustomers" id_customer=$customer->id|intval}
		<div class="col-lg-12">
			<div class="panel">
				<div class="panel-heading">
					<i class="icon-map-marker"></i> {l s='Adresses'} <span class="badge">{count($addresses)}</span>
				</div>
				{if count($addresses)}
					<table class="table">
						<thead>
							<tr>
								<th><span class="title_box ">{l s='Entreprise'}</span></th>
								<th><span class="title_box ">{l s='Nom'}</span></th>
								<th><span class="title_box ">{l s='Adresse'}</span></th>
								<th><span class="title_box ">{l s='Pays'}</span></th>
								<th><span class="title_box ">{l s='Numéro(s) de téléphone'}</span></th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							{foreach $addresses AS $key => $address}
							<tr>
								<td>{if $address['company']}{$address['company']}{else}--{/if}</td>
								<td>{$address['firstname']} {$address['lastname']}</td>
								<td>{$address['address1']} {if $address['address2']}{$address['address2']}{/if} {$address['postcode']} {$address['city']}</td>
								<td>{$address['country']}</td>
								<td>
									{if $address['phone']}
										{$address['phone']}
										{if $address['phone_mobile']}<br />{$address['phone_mobile']}{/if}
									{else}
										{if $address['phone_mobile']}<br />{$address['phone_mobile']}{else}--{/if}
									{/if}
								</td>
								<td class="text-right">
									<div class="btn-group">
										<a class="btn btn-default" href="?tab=AdminAddresses&amp;id_address={$address['id_address']}&amp;addaddress=1&amp;token={getAdminToken tab='AdminAddresses'}&amp;back={$smarty.server.REQUEST_URI|urlencode}">
											<i class="icon-edit"></i> {l s='Modifier'}
										</a>
										<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
											<span class="caret"></span>
										</button>
										<ul class="dropdown-menu">
											<li>
												<a href="?tab=AdminAddresses&amp;id_address={$address['id_address']}&amp;deleteaddress&amp;token={getAdminToken tab='AdminAddresses'}&amp;back={$smarty.server.REQUEST_URI|urlencode}">
													<i class="icon-trash"></i>
													{l s='Supprimer'}
												</a>
											</li>
										</ul>
									</div>
								</td>
							</tr>
							{/foreach}
						</tbody>
					</table>
				{else}
					<p class="text-muted text-center">
						{l s='%1$s %2$s n&#039;a pas encore enregistré d&#039;adresses' sprintf=[$customer->firstname, $customer->lastname]}
					</p>
				{/if}
			</div>
		</div>
	</div>
</div>
{/block}
