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

<div class="modal-body">
    <div class="row">
        <div class="col-lg-12">
            <div class="text-left errors-wrap"></div>
            <div class="documents-list form-group">
                <table class="table">
                    <thead>
                        <tr>
                            <th class="text-center">{l s='Aperçu'}</th>
                            <th class="text-left">{l s='Titre'}</th>
                            <th class="text-center">{l s='Date de téléchargement'}</th>
                            <th class="text-center">{l s='Actions'}</th>
                        </tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </div>
            {if $can_edit}
                <hr>
                <div class="well add-new-document-form" style="margin-top: 10px;">
                    <form class="form-horizontal" id="form-add-new-document" method="post" action="#">
                        <input type="hidden" name="id_htl_booking" value="0">
                        <div class="form-group">
                            <div class="col-sm-12">
                                <label class="control-label">
                                    <span class="label-tooltip" data-toggle="tooltip" title="" data-original-title="{l s='Écrivez le titre du document. Caractères invalides <>;=#{}'}">
                                        {l s='Titre'}
                                    </span>
                                </label>
                                <input class="form-control" type="text" name="title" value="" placeholder="{l s='ex. passeport, permis de conduire'}" />
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-12">
                                <label class="control-label required">
                                    <span class="label-tooltip" data-toggle="tooltip" title="" data-original-title="{l s='Choisissez le fichier document à télécharger.'}">
                                        {l s='Fichier'}
                                    </span>
                                </label>
                                <div class="input-file-wrap"></div>
                                <div class="input-group">
                                    <input class="form-control file-name" type="text" readonly="">
                                    <span class="input-group-btn">
                                        <button type="button" class="btn btn-primary btn-add-file">
                                            <i class="icon-folder-open"></i>
                                            {l s='Ajouter un fichier'}
                                        </button>
                                    </span>
                                </div>
                                <p class="text-left" style="margin-top: 4px; font-style: italic;">
                                    {l s='Téléchargez un fichier PDF ou image. Formats d&#039;image autorisés : .gif, .jpg, .jpeg et .png'}
                                </p>
                            </div>
                        </div>
                        <button class="btn btn-primary pull-right upload" type="submit" name="uploadDocument" id="uploadDocument" style="display:none;">
                            {l s='Télécharger'}
                        </button>
                    </form>
                </div>
            {/if}
        </div>
    </div>

    {if isset($loaderImg) && $loaderImg}
        <div class="loading_overlay">
            <img src='{$loaderImg}' class="loading-img"/>
        </div>
    {/if}
</div>
