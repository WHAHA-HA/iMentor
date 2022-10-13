(function () {
    'use strict';

    // Define the common module
    // Contains services:
    //  - common
    //  - logger
    var commonModule = angular.module('common', []);

    // Must configure the common service and set its
    // events via the commonConfigProvider
    commonModule.provider('commonConfig', function () {
        this.config = {
            // These are the properties we need to set
            //controllerActivateSuccessEvent: '',
            //spinnerToggleEvent: ''
        };

        this.$get = function () {
            return {
                config: this.config
            };
        };
    });

    commonModule.factory('common', common);
    
    common.$inject = ['$q', '$rootScope', '$timeout', '$location', 'commonConfig', 'logger'];

    function common($q, $rootScope, $timeout,  $location, commonConfig, logger) {
        var throttles = {};

        var service = {
            // common angular dependencies
            $broadcast: $broadcast,
            $q: $q,
            $timeout: $timeout,
            // generic
            activateController: activateController,
            logger: logger, // for accessibility
            getDateTime: getDateTime,
            getExtensionFromUrl: getExtensionFromUrl,
            getFileNameFromUrl: getFileNameFromUrl,
            getUrl: getUrl

        };

        return service;

        function activateController(promises, controllerId) {
            return $q.all(promises).then(function (eventArgs) {
                var data = { controllerId: controllerId };
                $broadcast(commonConfig.config.controllerActivateSuccessEvent, data);
            });
        }

        function $broadcast() {
            return $rootScope.$broadcast.apply($rootScope, arguments);
        }

        function getDateTime(timestamp){
            var date = new Date(timestamp);
            return(date.toString()); 
        }

        function getExtensionFromUrl(urlLink){
            var url = urlLink.replace(/#[^#]*$/, "").replace(/\?[^\?]*$/, "");
            var urlPath = url.substring(url.lastIndexOf('/')+1);
            var regex = /(?:\.([^.]+))?$/;
            var ext = regex.exec(urlPath)[1];
            return ext;
        }

        
        function getFileNameFromUrl(urlLink) {
            //this gets the full url
            var url = urlLink;
            //this removes the anchor at the end, if there is one
            url = url.substring(0, (url.indexOf("#") == -1) ? url.length : url.indexOf("#"));
            //this removes the query after the file name, if there is one
            url = url.substring(0, (url.indexOf("?") == -1) ? url.length : url.indexOf("?"));
            //this removes everything before the last slash in the path
            url = url.substring(url.lastIndexOf("/") + 1, url.length);
            //return
            return url;
        }

        function getUrl(relativeUrl){
            relativeUrl = relativeUrl.trim();
            var isAbsoluteUrl = new RegExp('^(?:[a-z]+:)?//', 'i');
            if(isAbsoluteUrl.test(relativeUrl) === false  ) {
                if($location.absUrl().indexOf(':' + $location.port())!==-1){ 
                    return $location.protocol() + '://'+ $location.host() +':'+  $location.port()  +'' + relativeUrl;
                }
                return $location.protocol() + '://'+ $location.host() +'' + relativeUrl;
            } else if(relativeUrl.indexOf('//') === 0) {
                return $location.protocol() + relativeUrl;
            }
            return relativeUrl;
        }

    }
})();