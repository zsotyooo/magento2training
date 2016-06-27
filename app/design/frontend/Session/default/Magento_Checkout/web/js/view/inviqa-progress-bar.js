/**
 * Copyright © 2016 Magento. All rights reserved.
 * See COPYING.txt for license details.
 */
/*jshint browser:true jquery:true*/
/*global alert*/
define(
    [
        'jquery',
        "underscore",
        'ko',
        'uiComponent',
        'Magento_Checkout/js/view/progress-bar'
    ],
    function ($, _, ko, Component, ProgressBar) {
        return ProgressBar.extend({
            defaults: {
                template: 'Magento_Checkout/new-progress-bar'
            },

            initialize: function() {
                this._super();
                this.myTextVar = "hi";
                this.displayWarningMessage = ko.observable(false);

                this.displayWarningMessage.subscribe(function(){
                    console.log('clicked');
                });

                this.displayWarningMessagesArray = ko.observableArray(['1','2','3']);

                console.log('Ahoy1');
            },

            aNewFunction: function() {
                console.log('Ahoy2');
            },

            toggleWarnigMessage: function() {
                this.displayWarningMessage(!this.displayWarningMessage());
                this.displayWarningMessagesArray.push('X');
            }
        });
    }
);
