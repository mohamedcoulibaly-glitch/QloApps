{*
* Reception-focused back-office dashboard.
* This page reorganizes existing booking information and keeps status changes in the existing order screen.
*}

<style>
    .reception-dashboard {
        --reception-ink: #1f2933;
        --reception-muted: #667085;
        --reception-line: #d9e2ec;
        --reception-soft: #f5f7fa;
        --reception-panel: #ffffff;
        --reception-primary: #0b5cab;
        --reception-primary-dark: #084a8b;
        --reception-success: #16735f;
        --reception-warning: #9a6700;
        --reception-finished: #47636f;
        color: var(--reception-ink);
        font-size: 14px;
    }

    .reception-dashboard * { box-sizing: border-box; }
    .reception-dashboard .panel { box-shadow: none; }

    .reception-hero {
        display: grid;
        grid-template-columns: minmax(0, 1fr) auto;
        gap: 18px;
        align-items: end;
        margin-bottom: 16px;
        padding: 18px;
        border: 1px solid var(--reception-line);
        border-radius: 8px;
        background: linear-gradient(180deg, #ffffff 0%, #f7fafc 100%);
    }

    .reception-title {
        margin: 0 0 4px;
        color: var(--reception-ink);
        font-size: 26px;
        font-weight: 700;
        letter-spacing: 0;
    }

    .reception-subtitle {
        margin: 0;
        color: var(--reception-muted);
        font-size: 14px;
    }

    .reception-availability-link {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        min-height: 44px;
        padding: 10px 14px;
        border: 1px solid #b8c7d5;
        border-radius: 8px;
        background: #fff;
        color: var(--reception-ink);
        font-weight: 700;
        text-decoration: none;
        white-space: nowrap;
    }

    .reception-availability-link:hover,
    .reception-availability-link:focus {
        border-color: var(--reception-primary);
        color: var(--reception-primary);
        text-decoration: none;
    }

    .reception-command {
        margin-bottom: 16px;
        padding: 14px;
        border: 1px solid var(--reception-line);
        border-radius: 8px;
        background: var(--reception-panel);
    }

    .reception-search {
        display: grid;
        grid-template-columns: minmax(0, 1fr) auto;
        gap: 10px;
        align-items: center;
    }

    .reception-search input {
        min-height: 48px;
        border-color: #b8c7d5;
        border-radius: 8px;
        font-size: 16px;
    }

    .reception-search button {
        min-height: 48px;
        padding: 11px 18px;
        border-radius: 8px;
        border-color: var(--reception-primary);
        background: var(--reception-primary);
        font-weight: 700;
    }

    .reception-search button:hover,
    .reception-search button:focus {
        border-color: var(--reception-primary-dark);
        background: var(--reception-primary-dark);
    }

    .reception-search-feedback {
        display: none;
        margin-top: 10px;
        color: var(--reception-muted);
        font-size: 13px;
    }

    .reception-summary-grid {
        display: grid;
        grid-template-columns: repeat(3, minmax(0, 1fr));
        gap: 12px;
        margin-bottom: 16px;
    }

    .reception-summary-card {
        display: grid;
        grid-template-columns: auto minmax(0, 1fr);
        gap: 12px;
        align-items: center;
        min-height: 92px;
        padding: 14px;
        border: 1px solid var(--reception-line);
        border-radius: 8px;
        background: var(--reception-panel);
    }

    .reception-summary-icon {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 42px;
        height: 42px;
        border-radius: 8px;
        background: #e8f2ff;
        color: var(--reception-primary);
        font-size: 18px;
    }

    .summary-departures .reception-summary-icon { background: #fff4df; color: var(--reception-warning); }
    .summary-in-house .reception-summary-icon { background: #e6f5f0; color: var(--reception-success); }

    .reception-summary-label {
        color: var(--reception-muted);
        font-size: 12px;
        font-weight: 700;
        letter-spacing: .04em;
        text-transform: uppercase;
    }

    .reception-summary-number {
        margin-top: 2px;
        color: var(--reception-ink);
        font-size: 28px;
        font-weight: 700;
        line-height: 1;
    }

    .reception-status-legend {
        display: flex;
        gap: 8px;
        flex-wrap: wrap;
        margin: 0 0 16px;
    }

    .reception-status {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        max-width: 100%;
        min-height: 28px;
        border-radius: 8px;
        padding: 4px 10px;
        font-size: 12px;
        font-weight: 700;
        line-height: 1.2;
        white-space: normal;
    }

    .reception-status:before {
        content: "";
        flex: 0 0 auto;
        width: 8px;
        height: 8px;
        border-radius: 50%;
        background: currentColor;
    }

    .status-assigned { background: #fff4df; color: #8a5a00; }
    .status-in-house { background: #e6f5f0; color: #16735f; }
    .status-checked-out { background: #eef2f6; color: var(--reception-finished); }
    .status-unknown { background: #f2f4f7; color: #667085; }

    .reception-search-results {
        display: none;
        margin-bottom: 16px;
    }

    .reception-search-results.is-visible {
        display: block;
    }

    .reception-section {
        border: 1px solid var(--reception-line);
        border-radius: 8px;
        background: var(--reception-panel);
        overflow: hidden;
    }

    .reception-section-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 12px;
        min-height: 56px;
        padding: 12px 14px;
        border-bottom: 1px solid #e6edf2;
        background: #f8fafc;
    }

    .reception-section-title {
        display: flex;
        align-items: center;
        gap: 8px;
        min-width: 0;
        font-size: 15px;
        font-weight: 700;
    }

    .reception-section-title i {
        color: var(--reception-primary);
        font-size: 16px;
    }

    .reception-count {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        min-width: 30px;
        height: 30px;
        border-radius: 8px;
        background: #e8f2ff;
        color: var(--reception-primary);
        font-weight: 700;
    }

    .reception-work-grid {
        display: grid;
        grid-template-columns: repeat(3, minmax(0, 1fr));
        gap: 14px;
    }

    .reception-list {
        display: flex;
        flex-direction: column;
    }

    .reception-booking-card {
        padding: 14px;
        border-bottom: 1px solid #edf2f7;
        background: #fff;
        transition: background-color .16s ease, box-shadow .16s ease;
    }

    .reception-booking-card:last-child {
        border-bottom: 0;
    }

    .reception-booking-card:hover {
        background: #fbfdff;
        box-shadow: inset 3px 0 0 var(--reception-primary);
    }

    .reception-booking-main {
        display: grid;
        grid-template-columns: minmax(0, 1fr) auto;
        gap: 12px;
        align-items: start;
    }

    .reception-booking-copy {
        min-width: 0;
    }

    .reception-guest {
        color: var(--reception-ink);
        font-size: 15px;
        font-weight: 700;
        line-height: 1.25;
    }

    .reception-meta {
        display: flex;
        flex-wrap: wrap;
        gap: 6px;
        align-items: center;
        margin-top: 7px;
        color: var(--reception-muted);
        font-size: 12px;
        line-height: 1.4;
    }

    .reception-order,
    .reception-room-pill {
        display: inline-flex;
        align-items: center;
        min-height: 24px;
        border-radius: 8px;
        padding: 2px 8px;
        background: #f2f6fa;
        color: #344054;
        font-weight: 700;
    }

    .reception-room-pill {
        background: #e8f2ff;
        color: var(--reception-primary);
    }

    .reception-stay-line {
        margin-top: 7px;
        color: var(--reception-muted);
        font-size: 12px;
        line-height: 1.45;
    }

    .reception-actions {
        display: flex;
        flex-wrap: wrap;
        gap: 8px;
        margin-top: 12px;
    }

    .reception-actions .btn {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 6px;
        min-height: 40px;
        border-radius: 8px;
        padding: 8px 12px;
        font-weight: 700;
    }

    .reception-empty {
        padding: 30px 16px;
        color: var(--reception-muted);
        text-align: center;
    }

    .reception-loading {
        opacity: .65;
        pointer-events: none;
    }

    @media (max-width: 1199px) {
        .reception-work-grid { grid-template-columns: 1fr 1fr; }
        .reception-work-grid .reception-section:last-child { grid-column: 1 / -1; }
    }

    @media (max-width: 767px) {
        .reception-hero,
        .reception-search,
        .reception-summary-grid,
        .reception-work-grid {
            grid-template-columns: 1fr;
        }

        .reception-hero { align-items: stretch; }
        .reception-availability-link,
        .reception-search button { width: 100%; }
        .reception-title { font-size: 22px; }
        .reception-booking-main { grid-template-columns: 1fr; }
        .reception-actions .btn { flex: 1 1 140px; min-height: 44px; }
    }
</style>

<div class="reception-dashboard{if $search_query} is-searching{/if}">
    <div class="reception-hero">
        <div>
            <h2 class="reception-title">{l s='Tableau de bord réception'}</h2>
            <p class="reception-subtitle">{l s='Journée du'} {dateFormat date=$today full=0} - {l s='arrivées, départs et clients présents.'}</p>
        </div>
        <a class="reception-availability-link" href="{$rooms_link|escape:'html':'UTF-8'}">
            <i class="icon-calendar"></i> {l s='Disponibilité des chambres'}
        </a>
    </div>

    <div class="reception-command">
        <form class="reception-search" method="get" action="{$dashboard_link|escape:'html':'UTF-8'}" data-search-url="{$reception_search_ajax_url|escape:'html':'UTF-8'}">
            <input type="hidden" name="controller" value="AdminDashboard">
            <input type="text" name="reception_search" class="form-control" value="{$search_query|escape:'html':'UTF-8'}" autocomplete="off" placeholder="{l s='Nom, réservation, chambre, hôtel ou e-mail'}" aria-label="{l s='Recherche rapide de réservation'}">
            <button type="submit" class="btn btn-primary">
                <i class="icon-search"></i> {l s='Rechercher'}
            </button>
        </form>
        <div class="reception-search-feedback" aria-live="polite" data-loading-label="{l s='Recherche en cours...'}" data-error-label="{l s='La recherche a échoué. Veuillez réessayer ou ouvrir les commandes.'}"></div>
    </div>

    <div class="reception-summary-grid" aria-label="{l s='Résumé de la journée'}">
        <div class="reception-summary-card summary-arrivals">
            <span class="reception-summary-icon"><i class="icon-sign-in"></i></span>
            <div>
                <div class="reception-summary-label">{l s='Arrivées'}</div>
                <div class="reception-summary-number">{$arrivals|count}</div>
            </div>
        </div>
        <div class="reception-summary-card summary-departures">
            <span class="reception-summary-icon"><i class="icon-sign-out"></i></span>
            <div>
                <div class="reception-summary-label">{l s='Départs'}</div>
                <div class="reception-summary-number">{$departures|count}</div>
            </div>
        </div>
        <div class="reception-summary-card summary-in-house">
            <span class="reception-summary-icon"><i class="icon-home"></i></span>
            <div>
                <div class="reception-summary-label">{l s='En séjour'}</div>
                <div class="reception-summary-number">{$in_house|count}</div>
            </div>
        </div>
    </div>

    <div class="reception-status-legend">
        {foreach from=$status_map item=status}
            <span class="reception-status {$status.class|escape:'html':'UTF-8'}" title="{$status.hint|escape:'html':'UTF-8'}">{$status.label|escape:'html':'UTF-8'}</span>
        {/foreach}
    </div>

    <div class="reception-search-results reception-section{if $search_query} is-visible{/if}" id="reception-search-results">
        <div class="reception-section-header">
            <div class="reception-section-title"><i class="icon-search"></i> {l s='Résultats de recherche'}</div>
            <span class="reception-count" data-search-count>{$search_results|count}</span>
        </div>
        <div data-search-list>
            {if $search_query}
                {include file='./_reception_booking_list.tpl' bookings=$search_results status_map=$status_map empty_label={l s='Aucune réservation trouvée pour cette recherche.'}}
            {/if}
        </div>
    </div>

    <div class="reception-work-grid">
        <section class="reception-section">
            <div class="reception-section-header">
                <div class="reception-section-title"><i class="icon-sign-in"></i> {l s='Arrivées du jour'}</div>
                <span class="reception-count">{$arrivals|count}</span>
            </div>
            {include file='./_reception_booking_list.tpl' bookings=$arrivals status_map=$status_map empty_label={l s='Aucune arrivée prévue pour aujourd&#039;hui.'} action_hint='checkin'}
        </section>

        <section class="reception-section">
            <div class="reception-section-header">
                <div class="reception-section-title"><i class="icon-sign-out"></i> {l s='Départs du jour'}</div>
                <span class="reception-count">{$departures|count}</span>
            </div>
            {include file='./_reception_booking_list.tpl' bookings=$departures status_map=$status_map empty_label={l s='Aucun départ prévu pour aujourd&#039;hui.'} action_hint='checkout'}
        </section>

        <section class="reception-section">
            <div class="reception-section-header">
                <div class="reception-section-title"><i class="icon-home"></i> {l s='Clients en séjour'}</div>
                <span class="reception-count">{$in_house|count}</span>
            </div>
            {include file='./_reception_booking_list.tpl' bookings=$in_house status_map=$status_map empty_label={l s='Aucun client actuellement enregistré.'} action_hint='checkout'}
        </section>
    </div>
</div>

<script>
(function () {
    var root = document.querySelector('.reception-dashboard');
    if (!root) {
        return;
    }

    var form = root.querySelector('.reception-search');
    var input = form ? form.querySelector('input[name="reception_search"]') : null;
    var feedback = root.querySelector('.reception-search-feedback');
    var resultsSection = root.querySelector('#reception-search-results');
    var resultsList = resultsSection ? resultsSection.querySelector('[data-search-list]') : null;
    var resultsCount = resultsSection ? resultsSection.querySelector('[data-search-count]') : null;
    var statusAlloted = {$status_alloted|intval};
    var statusCheckedIn = {$status_checked_in|intval};
    var emptyLabel = '{l s='Aucune réservation trouvée pour cette recherche.' js=1}';
    var openLabel = '{l s='Voir' js=1}';
    var checkInLabel = '{l s='Enregistrer' js=1}';
    var checkOutLabel = '{l s='Départ' js=1}';
    var roomLabel = '{l s='Chambre' js=1}';
    var guestMissingLabel = '{l s='Client non lié' js=1}';
    var checkInConfirm = '{l s='Ouvrir cette réservation pour confirmer l&#039;enregistrement ?' js=1}';
    var checkOutConfirm = '{l s='Ouvrir cette réservation pour confirmer le départ ?' js=1}';

    function escapeHtml(value) {
        return String(value || '').replace(/[&<>"']/g, function (character) {
            return {
                '&': '&amp;',
                '<': '&lt;',
                '>': '&gt;',
                '"': '&quot;',
                "'": '&#039;'
            }[character];
        });
    }

    function formatDate(value) {
        if (!value) {
            return '';
        }

        var date = new Date(String(value).replace(' ', 'T'));
        if (isNaN(date.getTime())) {
            return escapeHtml(value);
        }

        return date.toLocaleDateString(undefined, { day: '2-digit', month: '2-digit', year: 'numeric' });
    }

    function showFeedback(message) {
        if (!feedback) {
            return;
        }

        feedback.textContent = message || '';
        feedback.style.display = message ? 'block' : 'none';
    }

    function renderEmpty() {
        return '<div class="reception-empty">' + escapeHtml(emptyLabel) + '</div>';
    }

    function renderCard(booking, statusMap) {
        var status = statusMap && statusMap[booking.id_status] ? statusMap[booking.id_status] : {
            label: 'Statut inconnu',
            hint: '',
            'class': 'status-unknown'
        };
        var guest = (booking.firstname || booking.lastname)
            ? (escapeHtml(booking.firstname) + ' ' + escapeHtml(booking.lastname)).trim()
            : escapeHtml(guestMissingLabel);
        var actions = '<a class="btn btn-default btn-sm" href="' + escapeHtml(booking.order_url) + '"><i class="icon-eye-open"></i> ' + escapeHtml(openLabel) + '</a>';

        if (parseInt(booking.id_status, 10) === statusAlloted) {
            actions += '<a class="btn btn-success btn-sm" href="' + escapeHtml(booking.order_url) + '" data-confirm="' + escapeHtml(checkInConfirm) + '"><i class="icon-sign-in"></i> ' + escapeHtml(checkInLabel) + '</a>';
        }

        if (parseInt(booking.id_status, 10) === statusCheckedIn) {
            actions += '<a class="btn btn-warning btn-sm" href="' + escapeHtml(booking.order_url) + '" data-confirm="' + escapeHtml(checkOutConfirm) + '"><i class="icon-sign-out"></i> ' + escapeHtml(checkOutLabel) + '</a>';
        }

        return [
            '<article class="reception-booking-card">',
                '<div class="reception-booking-main">',
                    '<div class="reception-booking-copy">',
                        '<div class="reception-guest">' + guest + '</div>',
                        '<div class="reception-meta">',
                            '<span class="reception-order">#' + escapeHtml(booking.id_order) + '</span>',
                            '<span class="reception-room-pill">' + escapeHtml(roomLabel) + ' ' + escapeHtml(booking.room_num) + '</span>',
                            '<span>' + escapeHtml(booking.room_type_name) + '</span>',
                        '</div>',
                        '<div class="reception-stay-line">' + escapeHtml(booking.hotel_name) + ' - ' + formatDate(booking.date_from) + ' -> ' + formatDate(booking.date_to) + '</div>',
                    '</div>',
                    '<span class="reception-status ' + escapeHtml(status['class']) + '" title="' + escapeHtml(status.hint) + '">' + escapeHtml(status.label) + '</span>',
                '</div>',
                '<div class="reception-actions">' + actions + '</div>',
            '</article>'
        ].join('');
    }

    function renderResults(results, statusMap) {
        if (!resultsList || !resultsSection || !resultsCount) {
            return;
        }

        resultsCount.textContent = results.length;
        resultsSection.className = resultsSection.className.replace(/\s?is-visible/g, '') + ' is-visible';
        root.className = root.className.replace(/\s?is-searching/g, '') + ' is-searching';
        resultsList.innerHTML = results.length
            ? '<div class="reception-list">' + results.map(function (booking) { return renderCard(booking, statusMap); }).join('') + '</div>'
            : renderEmpty();
    }

    if (form && input && window.XMLHttpRequest) {
        form.addEventListener('submit', function (event) {
            var query = input.value.replace(/^\s+|\s+$/g, '');
            if (!query) {
                return;
            }

            event.preventDefault();
            showFeedback(feedback ? feedback.getAttribute('data-loading-label') : '');
            root.className += ' reception-loading';

            var xhr = new XMLHttpRequest();
            xhr.open('GET', form.getAttribute('data-search-url') + '&reception_search=' + encodeURIComponent(query), true);
            xhr.onreadystatechange = function () {
                if (xhr.readyState !== 4) {
                    return;
                }

                root.className = root.className.replace(/\s?reception-loading/g, '');
                if (xhr.status < 200 || xhr.status >= 300) {
                    showFeedback(feedback ? feedback.getAttribute('data-error-label') : '');
                    return;
                }

                try {
                    var payload = JSON.parse(xhr.responseText);
                    if (!payload.success) {
                        showFeedback(payload.message || (feedback ? feedback.getAttribute('data-error-label') : ''));
                        return;
                    }

                    renderResults(payload.results || [], payload.status_map || {});
                    showFeedback('');
                } catch (error) {
                    showFeedback(feedback ? feedback.getAttribute('data-error-label') : '');
                }
            };
            xhr.send();
        });
    }

    root.addEventListener('click', function (event) {
        var target = event.target;
        while (target && target !== root && !target.getAttribute('data-confirm')) {
            target = target.parentNode;
        }

        if (target && target.getAttribute && target.getAttribute('data-confirm')) {
            if (!window.confirm(target.getAttribute('data-confirm'))) {
                event.preventDefault();
            }
        }
    });
}());
</script>
