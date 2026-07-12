<div id="row">
	<div class="col-lg-12">
		<div class="panel">
			<div class="panel-heading">
				<i class="icon-info-circle"></i> &nbsp;{l s='Informations sur la demande d\'annulation de commande' mod='hotelreservationsystem'}
			</div>
			<br>
			<form id="{$table|escape:'htmlall':'UTF-8'}_form" class="defaultForm {$name_controller|escape:'htmlall':'UTF-8'} form-horizontal" action="{$link->getAdminLink('AdminOrderRefundRequests')|escape:'html':'UTF-8'}&amp;vieworder_return&amp;id_order_return={$orderReturnInfo['id']|escape:'html':'UTF-8'|intval}" method="post" enctype="multipart/form-data" {if isset($style)}style="{$style|escape:'htmlall':'UTF-8'}"{/if}>
				<div class="panel">
					{if isset($customer_name)}
						<div class="row">
							<div class="col-sm-12">
								<h3><i class="icon-info-circle"></i> &nbsp;{l s="Détails du client" mod='hotelreservationsystem'}</h3>
							</div>
							<div class="form-group">
								<div class="col-sm-3">
									<strong>{l s='Nom du client' mod='hotelreservationsystem'} :</strong>
								</div>
								<div class="col-sm-9">
									{$customer_name|escape:'html':'UTF-8'}
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-3">
									<strong>{l s='E-mail du client' mod='hotelreservationsystem'} :</strong>
								</div>
								<div class="col-sm-9">
									<a target="_blank" href="{$link->getAdminLink('AdminCustomers')|escape:'htmlall':'UTF-8'}&amp;id_customer={$orderReturnInfo['id_customer']|escape:'html':'UTF-8'}&amp;viewcustomer">{$customer_email|escape:'html':'UTF-8'}</a>
								</div>
							</div>
						</div>
					{else}
						<p><strong>{l s='Client' mod='hotelreservationsystem'} :  </strong>{l s='En tant qu\'invité' mod='hotelreservationsystem'}</p>
					{/if}

					<div class="row">
						<div class="form-group">
							<div class="col-sm-3">
								<strong>{l s='Raison de l\'annulation' mod='hotelreservationsystem'} :</strong>
							</div>
							<div class="col-sm-9">
								{if $orderReturnInfo['question']}
									{$orderReturnInfo['question']|escape:'html':'UTF-8'}
								{else}
									--
								{/if}
							</div>
						</div>
					</div>
				</div>

				<div class="panel">
					<div class="col-sm-12">
						<h3><i class="icon-info-circle"></i> &nbsp;{l s="Détails de la réservation" mod='hotelreservationsystem'}</h3>
					</div>

					<input type="hidden" name="id_order_return" value="{$orderReturnInfo['id']|escape:'html':'UTF-8'}">

					<div class="form-wrapper">
                        <div class="form-group row">
							<div class="col-sm-3">
								<strong>{l s='Numéro de commande' mod='hotelreservationsystem'} :</strong>
							</div>
							<div class="col-sm-9">
                                <a href="{$link->getAdminLink('AdminOrders')|escape:'html':'UTF-8'}&amp;vieworder&amp;id_order={$orderInfo['id']|escape:'html':'UTF-8'}">#{$orderInfo['id']|escape:'html':'UTF-8'}</a>
							</div>
						</div>
						<div class="form-group row">
							<div class="col-sm-3">
								<strong>{l s='Montant total de la commande' mod='hotelreservationsystem'} :</strong>
							</div>
							<div class="col-sm-9">
								{displayPrice price=$orderInfo['total_paid_tax_incl'] currency=$orderInfo['id_currency']}
							</div>
						</div>
						<div class="form-group row">
							<div class="col-sm-3">
								<strong>{l s='Montant total payé' mod='hotelreservationsystem'} :</strong>
							</div>
							<div class="col-sm-9">
								{displayPrice price=$orderTotalPaid currency=$orderInfo['id_currency']}
							</div>
						</div>
                        {if isset($refundReqBookings) && $refundReqBookings}
                            <div class="form-group row">
                                <div class="col-sm-3">
                                    <strong>{l s='Total des chambres' mod='hotelreservationsystem'} :</strong>
                                </div>
                                <div class="col-sm-9">
                                    {$refundReqBookings|count}
                                </div>
                            </div>
                        {/if}
                        {if isset($refundReqProducts) && $refundReqProducts}
                            <div class="form-group row">
                                <div class="col-sm-3">
                                    <strong>{l s='Total des produits' mod='hotelreservationsystem'} :</strong>
                                </div>
                                <div class="col-sm-9">
                                    {$refundReqProducts|count}
                                </div>
                            </div>
                        {/if}
						<div class="form-group row">
							<div class="col-sm-3">
								<strong>{l s='Mode de paiement' mod='hotelreservationsystem'} :</strong>
							</div>
							<div class="col-sm-9">
								{if $orderInfo['is_advance_payment']}{l s='Paiement d\'avance' mod='hotelreservationsystem'}{else}{l s='Paiement complet' mod='hotelreservationsystem'}{/if}
							</div>
						</div>
						<div class="form-group row">
							<div class="col-sm-3">
								<strong>{l s='État actuel de la commande' mod='hotelreservationsystem'} :</strong>
							</div>
							<div class="col-sm-9">
								<span class="badge" style="background-color:{$currentOrderStateInfo['color']|escape:'html':'UTF-8'}">{$currentOrderStateInfo['name']|escape:'html':'UTF-8'}</span>
							</div>
						</div>
						<div class="form-group row">
							<div class="col-sm-3">
								<strong>{l s='État actuel du remboursement' mod='hotelreservationsystem'} :</strong>
							</div>
							<div class="col-sm-9">
								<span class="badge" style="background-color:{$currentStateInfo['color']|escape:'html':'UTF-8'}">{$currentStateInfo['name']|escape:'html':'UTF-8'}</span>
							</div>
						</div>

						{* list of booking requested for refund by the customer *}
						{if isset($refundReqBookings) && $refundReqBookings}
							<br>
							<div class="form-group">
								<div class="col-sm-12">
									<label for="id_refund_state" class="control-label">
										<p><span title="" data-toggle="tooltip" class="label-tooltip" data-original-title='{l s="Liste des réservations demandées pour remboursement par le client." mod='hotelreservationsystem'}'><strong>{l s="Réservations demandées pour remboursement" mod='hotelreservationsystem'}</strong></span> :
										</p>
									</label>
								</div>
								<div class="col-sm-12">
									<table class="table" id="rooms_refund_info">
										<tr>
											{if !$isRefundCompleted}
												<th></th>
											{/if}
											<th>{l s='N° chambre' mod='hotelreservationsystem'}</th>
											<th>{l s='Type de chambre' mod='hotelreservationsystem'}</th>
											<th>{l s='Hôtel' mod='hotelreservationsystem'}</th>
											<th>{l s='Durée' mod='hotelreservationsystem'}</th>
											<th>{l s='Coût total (t.t.c.)' mod='hotelreservationsystem'}</th>
											<th>{l s='Montant total payé (t.t.c.)' mod='hotelreservationsystem'}</th>
											{if !$isRefundCompleted}
												<th>{l s='Frais d\'annulation des chambres' mod='hotelreservationsystem'}</th>
											{/if}
											{if $hasOrderDiscountOrPayment || $isRefundCompleted}
												<th>{l s='Montant du remboursement' mod='hotelreservationsystem'}</th>

                                                {if $isRefundCompleted}
                                                    <th>{l s='État du remboursement' mod='hotelreservationsystem'}</th>
                                                {/if}
											{/if}
										</tr>
										{foreach $refundReqBookings as $booking}
											<tr>
												{if !$isRefundCompleted}
													<td><input type="checkbox" name="id_order_return_detail[]" value="{$booking['id_order_return_detail']|escape:'html':'UTF-8'}" checked/></td>
												{/if}
												<td>{$booking['room_num']|escape:'htmlall':'UTF-8'}</td>
												<td>{$booking['room_type_name']|escape:'htmlall':'UTF-8'}</td>
												<td>{$booking['hotel_name']|escape:'htmlall':'UTF-8'}</td>
												{assign var="is_full_date" value=($show_full_date && ($booking['date_from']|date_format:'%D' == $booking['date_to']|date_format:'%D'))}
												<td>{dateFormat date=$booking['date_from'] full=$is_full_date} {l s='À' mod='hotelreservationsystem'} {dateFormat date=$booking['date_to'] full=$is_full_date}</td>
												<td>
													{displayPrice price=($booking['total_price_tax_incl'] + $booking['extra_service_total_price_tax_incl']) currency=$orderCurrency['id']}
													<span class="price_info">
														&nbsp;<img src="{$info_icon_path|escape:'htmlall':'UTF-8'}" />
													</span>
													<div class="price_info_container" style="display: none;">
														<div>
															<label>{l s='Coût de la chambre :' mod='hotelreservationsystem'}</label>
															<span class="pull-right">{displayPrice price=$booking['total_price_tax_incl'] currency=$orderCurrency['id']}</span>
														</div>
														<div>
															<label>{l s='Coût des services :' mod='hotelreservationsystem'}</label>
															<span class="pull-right">{displayPrice price=$booking['extra_service_total_price_tax_incl'] currency=$orderCurrency['id']}</span>
														</div>
													</div>
												</td>
												<td>
													{displayPrice price=($booking['room_paid_amount'] + $booking['extra_service_total_paid_amount']) currency=$orderCurrency['id']}
													<span class="price_info">
														&nbsp;<img src="{$info_icon_path|escape:'htmlall':'UTF-8'}" />
													</span>
													<div class="price_info_container" style="display: none;">
														<div>
															<label>{l s='Montant payé pour la chambre :' mod='hotelreservationsystem'}</label>
															<span class="pull-right">{displayPrice price=$booking['room_paid_amount'] currency=$orderCurrency['id']}</span>
														</div>
														<div>
															<label>{l s='Montant payé pour les services :' mod='hotelreservationsystem'}</label>
															<span class="pull-right">{displayPrice price=$booking['extra_service_total_paid_amount'] currency=$orderCurrency['id']}</span>
														</div>
													</div>
												</td>
												{if !$isRefundCompleted}
													<td>
														{displayPrice price=$booking['cancelation_charge'] currency=$orderCurrency['id']}
														{if $booking['reduction_type'] == HotelOrderRefundRules::WK_REFUND_RULE_PAYMENT_TYPE_PERCENTAGE}
															<p class="help-block">{Tools::ps_round($booking['reduction_value'], 2)}{l s='% du' mod='hotelreservationsystem'} {displayPrice price=($booking['total_price_tax_incl'] + $booking['extra_service_total_price_tax_incl']) currency=$orderCurrency['id']}</p>
														{/if}
													</td>
												{/if}
												{if $hasOrderDiscountOrPayment || $isRefundCompleted}
													<td>
														<div class="input-group">
															{if $isRefundCompleted}
                                                                {displayPrice price=$booking['refunded_amount'] currency=$orderCurrency['id']}
															{else}
																<span class="input-group-addon">{$orderCurrency['sign']|escape:'html':'UTF-8'}</span>
																<input placeholder="" type="text" name="refund_amounts[{$booking['id_order_return_detail']|escape:'html':'UTF-8'}]" value="{if ($booking['room_paid_amount'] + $booking['extra_service_total_paid_amount'] - $booking['cancelation_charge']) > 0}{Tools::ps_round(($booking['room_paid_amount'] + $booking['extra_service_total_paid_amount'] - $booking['cancelation_charge']), 2)}{else}0{/if}">
																<span class="input-group-addon">{l s='t.t.c.' mod='hotelreservationsystem'}</span>
															{/if}
														</div>
													</td>
                                                    {if $isRefundCompleted}
                                                        <td>
                                                            {if $booking['is_cancelled']}
                                                                <span class="badge badge-danger">{l s='Annulé' mod='hotelreservationsystem'}</span>
                                                            {* used id_customization to check if in this request which bookings are refunded or not*}
                                                            {else if $booking['id_customization']}
                                                                <span class="badge badge-success">{l s='Remboursé' mod='hotelreservationsystem'}</span>
                                                            {else}
                                                                <span class="badge badge-danger">{l s='Refusé' mod='hotelreservationsystem'}</span>
                                                            {/if}
                                                        </td>
                                                    {/if}
												{/if}
											</tr>
										{/foreach}
									</table>
								</div>
							</div>
						{/if}

						{if isset($refundReqProducts) && $refundReqProducts}
							<br>
							<div class="form-group">
								<div class="col-sm-12">
									<label for="id_refund_state" class="control-label">
										<p><span title="" data-toggle="tooltip" class="label-tooltip" data-original-title='{l s="Liste des produits demandés pour remboursement par le client." mod='hotelreservationsystem'}'><strong>{l s="Produits demandés pour remboursement" mod='hotelreservationsystem'}</strong></span> :
										</p>
									</label>
								</div>
								<div class="col-sm-12">
									<table class="table" id="rooms_refund_info">
										<tr>
											{if !$isRefundCompleted}
												<th></th>
											{/if}
											<th>{l s='Nom' mod='hotelreservationsystem'}</th>
											<th>{l s='Quantité' mod='hotelreservationsystem'}</th>
											<th>{l s='Coût total (t.t.c.)' mod='hotelreservationsystem'}</th>
											<th>{l s='Montant total payé (t.t.c.)' mod='hotelreservationsystem'}</th>

											{if $hasOrderDiscountOrPayment || $isRefundCompleted}
												<th>{l s='Montant du remboursement' mod='hotelreservationsystem'}</th>

												{if $isRefundCompleted}
													<th>{l s='État du remboursement' mod='hotelreservationsystem'}</th>
												{/if}
											{/if}
										</tr>
										{foreach $refundReqProducts as $product}
											<tr>
												{if !$isRefundCompleted}
													<td><input type="checkbox" name="id_order_return_detail[]" value="{$product['id_order_return_detail']|escape:'html':'UTF-8'}" checked/></td>
												{/if}
												<td>{$product['name']|escape:'htmlall':'UTF-8'}{if isset($product['option_name']) && $product['option_name']} : {$product['option_name']|escape:'htmlall':'UTF-8'}{/if}</td>
												<td>{if $product['allow_multiple_quantity']}{$product['quantity']|escape:'htmlall':'UTF-8'}{else}--{/if}</td>
												<td>{displayPrice price=$product['total_price_tax_incl'] currency=$orderCurrency['id']}</td>
												<td>{displayPrice price=$product['paid_amount'] currency=$orderCurrency['id']}</td>
												{if $hasOrderDiscountOrPayment || $isRefundCompleted}
													<td>
														<div class="input-group">
															{if $isRefundCompleted}
																{displayPrice price=$product['refunded_amount'] currency=$orderCurrency['id']}
															{else}
																<span class="input-group-addon">{$orderCurrency['sign']|escape:'html':'UTF-8'}</span>
																<input placeholder="" type="text" name="refund_amounts[{$product['id_order_return_detail']|escape:'html':'UTF-8'}]" value="0">
																<span class="input-group-addon">{l s='t.t.c.' mod='hotelreservationsystem'}</span>
															{/if}
														</div>
													</td>
													{if $isRefundCompleted}
														<td>
															{if $product['is_cancelled']}
																<span class="badge badge-danger">{l s='Annulé' mod='hotelreservationsystem'}</span>
															{* used id_customization to check if in this request which bookings are refunded or not*}
															{else if $product['id_customization']}
																<span class="badge badge-success">{l s='Remboursé' mod='hotelreservationsystem'}</span>
															{else}
																<span class="badge badge-danger">{l s='Refusé' mod='hotelreservationsystem'}</span>
															{/if}
														</td>
													{/if}
												{/if}
											</tr>
										{/foreach}
									</table>
								</div>
							</div>
						{/if}

						<br>

						{if $isRefundCompleted}
							{if $currentStateInfo['refunded']}
								<div class="form-group row">
									<div class="col-sm-3">
										<strong>{l s='Montant remboursé :' mod='hotelreservationsystem'}</strong>
									</div>
									<div class="col-sm-9">
										{displayPrice price=$orderReturnInfo['refunded_amount'] currency=$orderInfo['id_currency']}
									</div>
								</div>

								{if $orderReturnInfo['payment_mode'] != '' && $orderReturnInfo['id_transaction'] != ''}
									<div class="form-group row">
										<div class="col-sm-3">
											<strong>{l s='Mode de paiement :' mod='hotelreservationsystem'}</strong>
										</div>
										<div class="col-sm-9">
											{$orderReturnInfo['payment_mode']|escape:'html':'UTF-8'}
										</div>
									</div>
									<div class="form-group row">
										<div class="col-sm-3">
											<strong>{l s='ID de la transaction :' mod='hotelreservationsystem'}</strong>
										</div>
										<div class="col-sm-9">
											{$orderReturnInfo['id_transaction']|escape:'html':'UTF-8'}
										</div>
									</div>
								{/if}

								{if isset($orderReturnInfo['return_type'])}
									{if $orderReturnInfo['return_type'] == OrderReturn::RETURN_TYPE_CART_RULE}
										<div class="form-group row">
											<div class="col-sm-3">
												<strong>{l s='ID du bon de réduction :' mod='hotelreservationsystem'}</strong>
											</div>
											<div class="col-sm-9">
												<a href="{$link->getAdminLink('AdminCartRules')}&updatecart_rule&id_cart_rule={$orderReturnInfo['id_return_type']}" target="_blank">#{$orderReturnInfo['id_return_type']}</a>
											</div>
										</div>
									{elseif $orderReturnInfo['return_type'] == OrderReturn::RETURN_TYPE_ORDER_SLIP}
										<div class="form-group row">
											<div class="col-sm-3">
												<strong>{l s='ID du bordereau de crédit :' mod='hotelreservationsystem'}</strong>
											</div>
											<div class="col-sm-9">
												#{$orderReturnInfo['id_return_type']}
												<a class="btn btn-default" href="{$link->getAdminLink('AdminPdf')}&submitAction=generateOrderSlipPDF&id_order_slip={$orderReturnInfo['id_return_type']}" title="#{Configuration::get('PS_CREDIT_SLIP_PREFIX', $current_id_lang)}{$orderReturnInfo['id_return_type']|string_format:'%06d'}">
													<i class="icon-file-text"></i>
													{l s='Télécharger' mod='hotelreservationsystem'}
												</a>
											</div>
										</div>
									{/if}
								{/if}
							{/if}
						{else}
							<div class="form-group">
								<div class="col-sm-3">
									<label for="id_refund_state" class="control-label">
										<span title="" data-toggle="tooltip" class="label-tooltip" data-original-title="{l s='Sélectionnez le nouvel état pour la demande de remboursement.' mod='hotelreservationsystem'}"> {l s='État du remboursement de la chambre' mod='hotelreservationsystem'}</span> :
									</label>
								</div>
								<div class="col-sm-3">
									<select id="id_refund_state" name="id_refund_state">
										{foreach from=$refundStatuses item=state}
											<option refunded="{$state['refunded']|escape:'html':'UTF-8'}" denied="{$state['denied']|escape:'html':'UTF-8'}" value="{$state['id_order_return_state']|intval}"{if isset($currentStateInfo) && $state['id_order_return_state'] == $currentStateInfo['id']} selected="selected"{/if}>{$state['name']|escape:'html':'UTF-8'}</option>
										{/foreach}
									</select>
								</div>
							</div>

							{* Fields to submit refund information *}
							{if $hasOrderDiscountOrPayment}
								<div class="refunded_state_fields" style="display:none;">
									<div class="form-group">
										<div class="col-sm-3">
										</div>
										<div class="col-sm-3">
											<div class="checkbox">
												<label>
													<input value="1" type="checkbox" name="generateCreditSlip" id="generateCreditSlip"/> &nbsp;{l s='Créer un bordereau de crédit' mod='hotelreservationsystem'}
												</label>
											</div>
										</div>
									</div>
									<div class="form-group">
										<div class="col-sm-3">
										</div>
										<div class="col-sm-3">
											<div class="checkbox">
												<label>
													<input value="1" type="checkbox" name="refundTransactionAmount" id="refundTransactionAmount"/> &nbsp;{l s='Rembourser le montant de la transaction' mod='hotelreservationsystem'}
												</label>
											</div>
										</div>
									</div>
									<div class="refund_transaction_fields" style="display:none;">
										{if isset($paymentMethods) && $paymentMethods|count}
											<div class="form-group">
												<div class="col-sm-3">
													<label for="payment_method" class="control-label">
														<span title="" data-toggle="tooltip" class="label-tooltip" data-original-title="{l s='Sélectionnez le mode de paiement par lequel vous avez remboursé le client.' mod='hotelreservationsystem'}">{l s='Mode de paiement' mod='hotelreservationsystem'}</span> :
													</label>
												</div>
												<div class="col-sm-3">
													<select name="payment_method" id="payment_methods">
														{foreach $paymentMethods as $paymentMod}
															<option value="{$paymentMod|escape:'html':'UTF-8'}">{$paymentMod|escape:'html':'UTF-8'}</option>
														{/foreach}
														<option value="0">{l s='Autres' mod='hotelreservationsystem'}</option>
													<select>
												</div>
											</div>
										{/if}
										<div class="form-group other_payment_mode" {if isset($paymentMethods) && $paymentMethods|count}style="display:none;"{/if}>
											<div class="col-sm-3">
												<label for="other_payment_mode" class="control-label required">
													<span title="" data-toggle="tooltip" class="label-tooltip" data-original-title="{l s='Saisissez le mode de paiement par lequel vous avez remboursé le client.' mod='hotelreservationsystem'}">{l s='Nom du mode de paiement' mod='hotelreservationsystem'}</span> :
												</label>
											</div>
											<div class="col-sm-3">
												<input type="text" name="other_payment_mode">
											</div>
										</div>
										<div class="form-group">
											<div class="col-sm-3">
												<label for="id_transaction" class="control-label required">
													<span title="" data-toggle="tooltip" class="label-tooltip" data-original-title="{l s='Saisissez l\'ID de la transaction du paiement par lequel vous avez remboursé le client.' mod='hotelreservationsystem'}">{l s='ID de la transaction' mod='hotelreservationsystem'}</span> :
												</label>
											</div>
											<div class="col-sm-3">
												<input type="text" name="id_transaction">
											</div>
										</div>
									</div>
									<div class="form-group">
										<div class="col-sm-3">
										</div>
										<div class="col-sm-3">
											<div class="checkbox">
												<label>
													<input value="1" type="checkbox" name="generateDiscount" id="generateDiscount"/> &nbsp;{l s='Créer un bon de réduction' mod='hotelreservationsystem'}
												</label>
											</div>
										</div>
									</div>
									<div class="generate_discount_fields" style="display:none;">
										<div class="form-group">
											<div class="col-sm-3">
												<label for="voucher_expiry" class="control-label required">
													<span title="" data-toggle="tooltip" class="label-tooltip" data-original-title="{l s='Veuillez sélectionner la date jusqu\'à laquelle le bon de réduction peut être utilisé.' mod='hotelreservationsystem'}">{l s='Date d\'expiration du bon de réduction' mod='hotelreservationsystem'}</span> :
												</label>
											</div>
											<div class="col-sm-3">
												<div class="input-group">
													<input type="text" id="voucher_expiry" value="{$expiry_date|date_format:"%d-%m-%Y"}">
													<div class="input-group-addon"><i class="icon-calendar"></i></div>
													<input type="hidden" name="voucher_expiry_date" id="voucher_expiry_date" value="{$expiry_date|date_format:"%Y-%m-%d"}">
												</div>
											</div>
										</div>
									</div>
								</div>
							{/if}
						{/if}
					</div>
				</div>

				{* footer panel only if refund is not at its final state *}
				{if !$isRefundCompleted}
					<div class="panel-footer">
						<a href="{$link->getAdminLink('AdminAddHotel')|escape:'html':'UTF-8'}" class="btn btn-default">
							<i class="process-icon-cancel"></i>{l s='Annuler' mod='hotelreservationsystem'}
						</a>
						<button type="submit" name="submitRefundReqBookings" class="btn btn-default pull-right">
							<i class="process-icon-save"></i> {l s='Enregistrer' mod='hotelreservationsystem'}
						</button>
						<button type="submit" name="submitRefundReqBookingsAndStay" class="btn btn-default pull-right">
							<i class="process-icon-save"></i> {l s='Enregistrer et rester' mod='hotelreservationsystem'}
						</button>
					</div>
				{/if}
			</form>
		</div>
	</div>
</div>
