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

	</div>
</div>
{if $display_footer}
<div id="footer" class="bootstrap hide">

	<div class="col-sm-2 hidden-xs"><span class="footer-brand">Hotel Prime</span><span id="footer-load-time"><i class="icon-time" title="{l s='Temps de chargement : '}"></i> {number_format(microtime(true) - $timer_start, 3, '.', '')}s</span></div>

	<div class="col-sm-2 hidden-xs"><div class="social-networks hotel-footer-mark"><i class="icon-building"></i></div></div>
	<div class="col-sm-5"><div class="footer-contact hotel-footer-contact"><span><i class="icon-envelope"></i> hotelprime@htl.com</span> / <span><i class="icon-phone"></i> 0987654321</span></div></div>

	<div class="col-sm-3">
		{hook h="displayBackOfficeFooter"}
	</div>

	<button type="button" id="go-top" class="hide" aria-label="{l s='Retour en haut'}"><i class="icon-arrow-up" aria-hidden="true"></i></button>
</div>
{/if}
{if isset($php_errors)}
	{include file="error.tpl"}
{/if}

{if isset($modals)}
<div class="bootstrap">
	{$modals}
</div>
{/if}

</body>
</html>
