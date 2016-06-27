/**
 * Copyright © 2016 Magento. All rights reserved.
 * See COPYING.txt for license details.
 */
define([
    'jquery',
    'Magento_Catalog/js/catalog-add-to-cart',
    'jquery/ui'
], function($) {
    "use strict";

    $.widget('inviqa.catalogAddToCart', $.mage.catalogAddToCart, {
        enableAddToCartButton: function(form) {
            this._super();
            console.log('Voila1');
        }
    });

    return $.inviqa.catalogAddToCart;
});