<div class="htl_room_data_cont">
    <div class="status-info-tooltip" title="{l s='En raison de la nature dynamique de la disponibilité des chambres, une seule chambre peut entrer dans plusieurs catégories dans le panneau de statistiques. Par exemple, si une chambre est réservée du 1er au 3 puis marquée comme indisponible pour maintenance du 4 au 5, elle sera comptée dans les catégories « Chambres réservées » et « Chambres indisponibles » pour ces dates respectives si la recherche est effectuée du 1er au 6. Cela permet à l\'administrateur de comprendre le statut de la chambre sur différentes périodes avec précision.' mod='hotelreservationsystem'}">
        <i class="icon-info-circle"></i>
    </div>
    <div class="row">
        <div class="col-sm-6">
            <div class="row">
                <div class="col-sm-12 htl_room_cat_data">
                    <p class="room_cat_header">{l s='Total des chambres' mod='hotelreservationsystem'}</p>
                    <p class="room_cat_data">{if isset($booking_data) && $booking_data}{$booking_data['stats']['total_rooms']|escape:'htmlall':'UTF-8'}{else}00{/if}</p>
                </div>
            </div>
            <hr class="hr_style" />
        </div>
        <div class="col-sm-6">
            <div class="row">
                <div class="col-sm-12 htl_room_cat_data">
                    <p class="room_cat_header">{l s='Chambres disponibles' mod='hotelreservationsystem'}</p>
                    <p class="room_cat_data" id="num_avail">{if isset($booking_data) && $booking_data}{$booking_data['stats']['num_avail']|escape:'htmlall':'UTF-8'}{else}00{/if}</p>
                </div>
            </div>
            <hr class="hr_style" />
        </div>
    </div>
    <div class="row">
        <div class="col-sm-6">
            <div class="row">
                <div class="col-sm-12 htl_room_cat_data">
                    <p class="room_cat_header">{l s='Partiellement disponibles' mod='hotelreservationsystem'}</p>
                    <p class="room_cat_data" id="num_part">{if isset($booking_data) && $booking_data}{$booking_data['stats']['num_part_avai']|escape:'htmlall':'UTF-8'}{else}00{/if}</p>
                </div>
            </div>
            <hr class="hr_style" />
        </div>
        <div class="col-sm-6">
            <div class="row">
                <div class="col-sm-12 htl_room_cat_data">
                    <p class="room_cat_header">{l s='Chambres réservées' mod='hotelreservationsystem'}</p>
                    <p class="room_cat_data">{if isset($booking_data) && $booking_data}{$booking_data['stats']['num_booked']|escape:'htmlall':'UTF-8'}{else}00{/if}</p>
                </div>
            </div>
            <hr class="hr_style" />
        </div>
    </div>

    <div class="row">
        <div class="col-sm-6">
            <div class="row">
                <div class="col-sm-12 htl_room_cat_data">
                    <p class="room_cat_header">{l s='Chambres indisponibles' mod='hotelreservationsystem'}</p>
                    <p class="room_cat_data">{if isset($booking_data) && $booking_data}{$booking_data['stats']['num_unavail']|escape:'htmlall':'UTF-8'}{else}00{/if}</p>
                </div>
            </div>
            <hr class="hr_style" />
        </div>
        <div class="col-sm-6">
            <div class="row">
                <div class="col-sm-12 htl_room_cat_data">
                    <p class="room_cat_header">{l s='Chambres dans le panier' mod='hotelreservationsystem'}</p>
                    <p class="room_cat_data" id="cart_stats">{if isset($booking_data) && $booking_data}{$booking_data['stats']['num_cart']|escape:'htmlall':'UTF-8'}{else}00{/if}</p>
                </div>
            </div>
            <hr class="hr_style" />
        </div>
    </div>

    <div class="row">
        <div class="col-sm-6 indi_cont clearfix">
            <span class="color_indicate bg-green"></span>
            <span class="indi_label">{l s='Chambres disponibles' mod='hotelreservationsystem'}</span>
        </div>
        <div class="col-sm-6 indi_cont clearfix">
            <span class="color_indicate bg-yellow"></span>
            <span class="indi_label">{l s='Partiellement disponibles' mod='hotelreservationsystem'}</span>
        </div>
        <div class="col-sm-6 indi_cont clearfix">
            <span class="color_indicate bg-red"></span>
            <span class="indi_label">{l s='Chambres indisponibles' mod='hotelreservationsystem'}</span>
        </div>
        <div class="col-sm-6 indi_cont clearfix">
            <span class="color_indicate bg-blue"></span>
            <span class="indi_label">{l s='Chambres réservées' mod='hotelreservationsystem'}</span>
        </div>
    </div>
</div>