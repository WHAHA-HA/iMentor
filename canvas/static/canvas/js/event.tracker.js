(function() {

    'use strict';

    angular.module('eventTracker', [])

    .provider('eventTracker', function() {

        var eventHandlersNames = ['Console'];
        this.setEventHandlers = function(handlers) {
            if (angular.isString(handlers)) {
                handlers = [handlers];
            }
            eventHandlersNames = [];
            angular.forEach(handlers, function(handler) {
                eventHandlersNames.push(capitalizeHandler(handler));
            });
        };

        var capitalizeHandler = function(handler) {
            return handler.charAt(0).toUpperCase() + handler.substring(1);
        };

        var pageChangeEvent = '$locationChangeSuccess';

        this.setPageChangeEvent = function(newPageChangeEvent) {
            pageChangeEvent = newPageChangeEvent;
        };


        this.$get = ['$injector', '$rootScope', '$location', '$window', '$document', function($injector, $rootScope, $location, $window, $document) {

            // Helper methods
            var eventHandlers = [];
            var window = angular.element($window);
            var document = angular.element($document[0]);
            var vendorPrefix;

            angular.forEach(eventHandlersNames, function(handler) {
                eventHandlers.push($injector.get('eventTracker' + handler + 'Handler'));
            });

            var forEachHandlerDo = function(action) {
                angular.forEach(eventHandlers, function(handler) {
                    action(handler);
                });
            };

            var service = {};
            // Just dummy function so that it's instantiated on app creation
            service.init = function() {

            };

            service.trackEvent = function(eventName, trackingData) {
                forEachHandlerDo(function(handler) {
                    if (eventName && trackingData) {
                        handler.trackEvent(eventName, trackingData);
                    }
                });
            };

            service.trackPageView = function(url) {
                forEachHandlerDo(function(handler) {
                    if (url) {
                        handler.trackPageView(url);
                    }
                });
            };

            service.trackWindow = function(eventName) {
                forEachHandlerDo(function(handler) {
                    if (eventName) {
                        handler.trackWindow(eventName);
                    }
                });
            };

            //Page change listening
            $rootScope.$on(pageChangeEvent, function() {
                service.trackPageView($location.url());
            });


            //Window change listening
            window.on('blur', function(event) {
                service.trackWindow('windowBlur');
            });

            window.on('focus', function(event) {
                service.trackWindow('windowFocus');
            });

            window.on('pageshow', function(event) {
                service.trackWindow('pageshow'); // raised when the page first shows
            });

            window.on('beforeunload', function(event) {
                service.trackWindow('beforeunload');
            });


            //Window hidden or visible event tracking using new  Page Visibility API
            var visibilityChangeHandler = function visibilityChangeHandler(event) {
                if (this[vendorPrefix ? vendorPrefix + 'Hidden' : 'hidden']){
                    service.trackWindow('windowHidden');
                } else {
                    service.trackWindow('windowVisible');
                }
            };

            // Determine if a vendor prefix is required
            if ('hidden' in $document) {
                vendorPrefix = '';
            } else {
                angular.forEach(['moz', 'webkit', 'ms'], function(prefix) {
                    if ((prefix + 'Hidden') in $document[0]) {
                        vendorPrefix = prefix;
                      }
                });
            }

            if (angular.isDefined(vendorPrefix)) {
                document.on(vendorPrefix + 'visibilitychange', visibilityChangeHandler);
            }

            return service;

        }];

    })

    .factory('eventTrackerLogHandler', ['common', function(common) {
        var service = {};

        var getLogFn = common.logger.getLogFn;
        var log = getLogFn('eventTrackerLogHandler');

        service.trackPageView = function(url) {
            //log("URL visited", url);
        };

        service.trackWindow = function(eventName) {
            //log("Windows", eventName);
        };

        service.trackEvent = function(eventName, trackingData) {
            //log("Event tracked", eventName);
            //log(trackingData);
        };

        return service;
    }])

    .directive('trackOn', ['eventTracker', function(eventTracker) {

        function isTrackProperty(name) {
            return  name.substr(0, 5) === 'track' && 
                    ['On', 'Event', 'If', 'Properties', 'EventType']
                    .indexOf(name.substr(5)) === -1;
        }

        function getPropertyName(name) {
            var s = name.slice(5); // slice off the 'track' prefix
            if (typeof s !== 'undefined' && s !== null && s.length > 0) {
                return s.substring(0, 1).toLowerCase() + s.substring(1);
            } else {
                return s;
            }
        }

        function ignoreRepeat(eventType) {
            return ['mouseover', 'mouseout'].indexOf(eventType) > -1;
        }

        return {
            restrict: 'A',
            link: function($scope, $element, $attrs) {

                var eventTypes = $attrs.trackOn.split('|');
                var trackingData = {};

                var lastEvent = '';

                angular.forEach($attrs.$attr, function(attr, name) {
                    if (isTrackProperty(name)) {
                        trackingData[getPropertyName(name)] = $attrs[name];
                        $attrs.$observe(name, function(value) {
                            trackingData[getPropertyName(name)] = value;
                        });
                    }
                });

                angular.forEach(eventTypes, function(eventType) {
                    angular.element($element[0]).bind(eventType, function($event) {
                        if (lastEvent !== $event.type || (lastEvent === $event.type && !ignoreRepeat($event.type))) {
                            var eventName = $attrs.trackEvent;
                            trackingData.eventType = $event.type;

                            if ($attrs.trackIf) {
                                if (!$scope.$eval($attrs.trackIf)) {
                                    return; // Cancel this event if it does't pass the if condition
                                }
                            }
                            // Allow elements to add  properties
                            if ($attrs.trackProperties) {
                                angular.extend(trackingData, $scope.$eval($attrs.trackProperties));
                            }

                            if ($attrs.trackCallback) {
                                $scope.$eval($attrs.trackCallback);
                            }

                            eventTracker.trackEvent(eventName, trackingData);

                            lastEvent = eventType;
                        }
                    });
                });

            }
        };
    }]);

})();


