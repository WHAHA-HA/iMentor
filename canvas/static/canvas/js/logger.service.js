(function () {
    'use strict';

    angular.module('common').factory('logger', logger);

    logger.$inject = ['$log'];

    function logger($log) {
        var service = {
            getLogFn: getLogFn,
            log: log,
            logError: logError,
            logDebug: logDebug,
            logWarn: logWarn,
            logInfo: logInfo,
            enabled: false
        };

        return service;

        function getLogFn(moduleId, fnName) {
            fnName = fnName || 'log';
            switch (fnName.toLowerCase()) { // convert aliases
                case 'debug':
                    fnName = 'logDebug';
                    break;
                case 'error':
                    fnName = 'logError';
                    break;
                case 'warn':
                    fnName = 'logWarn';
                    break;
                case 'warning':
                    fnName = 'logWarn';
                    break;
                case 'info':
                    fnName = 'logInfo';
                    break;
            }

            var logFn = service[fnName] || service.log;
            return function (msg, data, showToast) {
                logFn(msg, data, moduleId, (showToast === undefined) ? true : showToast);
            };
        }

        function log(message, data, source, showToast) {
            logIt(message, data, source, showToast, '');
        }

        function logWarn(message, data, source, showToast) {
            logIt(message, data, source, showToast, 'warn');
        }

        function logDebug(message, data, source, showToast) {
            logIt(message, data, source, showToast, 'debug');
        }

        function logError(message, data, source, showToast) {
            logIt(message, data, source, showToast, 'error');
        }

        function logInfo(message, data, source, showToast) {
            logIt(message, data, source, showToast, 'info');
        }

        function logIt(message, data, source, showToast, toastType) {
            var write;// = (toastType === 'error') ? $log.error : $log.log;
            source = source ? '[' + source + '] ' : '';
            
            if (service.enabled) {
                if (toastType === 'error') {
                    write = $log.error;
                } else if (toastType === 'warn') {
                    write = $log.warn;
                } else if (toastType === 'debug') {
                    write = $log.debug;
                } else if (toastType === 'info') {
                    write = $log.info;
                } else {
                    write = $log.log;
                }

                if(angular.isDefined(data)){
                    write(getTime() + " - " + source, message, JSON.stringify(data));
                } else {
                    write(getTime() + " - " + source, message);
                }
            }
        }

        function getTime() {
            var myTime = new Date();
            var hh = myTime.getHours();
            var mm = myTime.getMinutes();
            var ss = myTime.getSeconds();
            var ms = myTime.getMilliseconds();
            return hh + ":" + mm + ":" + ss + ":" + ms;
        }
    }
})();