(function() {

        'use strict';

        var serviceId = 'eventTrackerCanvasHandler';

        angular.module('canvas', [])

        .factory(serviceId, ['$http', 'config', 'common', canvasHandler]);

        function canvasHandler($http, config, common) {
            var $q = common.$q;

            var service = {
                trackPageView: trackPageView,
                trackWindow: trackWindow,
                trackEvent: trackEvent
            };

            function trackPageView(url) {
                //$log.log('URL visited', url);
            }

            function trackWindow(eventName) {
                //$log.log('Windows', eventName);
            }

            function trackEvent(eventName, trackingData) {
                //$log.log('Event tracked', eventName);
                //$log.log(trackingData);
            }

            return service;
        }

})();
