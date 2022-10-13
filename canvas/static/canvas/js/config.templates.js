(function () {
    'use strict';

    var app = angular.module('canvas');

  	app.run(['eventTracker','staticUri','$templateCache','$http','$rootScope','$window', function(eventTracker,staticUri,$templateCache, $http, $rootScope, $window) {
        eventTracker.init();

        //$http.get(staticUri.templateUrl.widgetContainer).then(function(result){   $templateCache.put(staticUri.templateUrl.widgetContainer, result.data);});
        //$http.get(staticUri.templateUrl.widget).then(function(result){   $templateCache.put(staticUri.templateUrl.widget, result.data);});
        //$http.get(staticUri.templateUrl.mentioTextAngular).then(function(result){   $templateCache.put(staticUri.mentioTextAngular, result.data);});

        $http.get(staticUri.templateUrl.contentTypeUnknown).then(function(result){   $templateCache.put(staticUri.templateUrl.contentTypeUnknown, result.data);});
        $http.get(staticUri.templateUrl.contentTypeVideoFile).then(function(result){   $templateCache.put(staticUri.templateUrl.contentTypeVideoFile, result.data);});
        $http.get(staticUri.templateUrl.contentTypeAudioFile).then(function(result){   $templateCache.put(staticUri.templateUrl.contentTypeAudioFile, result.data);});
        $http.get(staticUri.templateUrl.contentTypeImageFile).then(function(result){   $templateCache.put(staticUri.templateUrl.contentTypeImageFile, result.data);});
        $http.get(staticUri.templateUrl.contentTypeIframe).then(function(result){   $templateCache.put(staticUri.templateUrl.contentTypeIframe, result.data);});
        $http.get(staticUri.templateUrl.contentTypePdfFile).then(function(result){   $templateCache.put(staticUri.templateUrl.contentTypePdfFile, result.data);});
        $http.get(staticUri.templateUrl.contentTypeGoogleDocs).then(function(result){   $templateCache.put(staticUri.templateUrl.contentTypeGoogleDocs, result.data);});
        $http.get(staticUri.templateUrl.contentTypeDocumentFile).then(function(result){   $templateCache.put(staticUri.templateUrl.contentTypeDocumentFile, result.data);});
        $http.get(staticUri.templateUrl.contentTypeWorksheetFile).then(function(result){   $templateCache.put(staticUri.templateUrl.contentTypeWorksheetFile, result.data);});
        $http.get(staticUri.templateUrl.contentTypePresentationFile).then(function(result){   $templateCache.put(staticUri.templateUrl.contentTypePresentationFile, result.data);});
        $http.get(staticUri.templateUrl.contentTypeSoundcloud).then(function(result){   $templateCache.put(staticUri.templateUrl.contentTypeSoundcloud, result.data);});
        $http.get(staticUri.templateUrl.contentTypeText).then(function(result){   $templateCache.put(staticUri.templateUrl.contentTypeText, result.data);});
        $http.get(staticUri.templateUrl.contentTypeHtml).then(function(result){   $templateCache.put(staticUri.templateUrl.contentTypeHtml, result.data);});
        $http.get(staticUri.templateUrl.contentTypeSite).then(function(result){   $templateCache.put(staticUri.templateUrl.contentTypeSite, result.data);});
        $http.get(staticUri.templateUrl.contentTypeLink).then(function(result){   $templateCache.put(staticUri.templateUrl.contentTypeLink, result.data);});
    
   
        $http.get(staticUri.templateUrl.responseMarkerHtml).then(function(result){   $templateCache.put(staticUri.templateUrl.responseMarkerHtml, result.data);});
        $http.get(staticUri.templateUrl.responseHtml).then(function(result){   $templateCache.put(staticUri.templateUrl.responseHtml, result.data);});

        //$http.get(staticUri.templateUrl.reconnectingContent).then(function(result){   $templateCache.put(staticUri.templateUrl.reconnectingContent, result.data);});
        $http.get(staticUri.templateUrl.reconnectingWriter).then(function(result){   $templateCache.put(staticUri.templateUrl.reconnectingWriter, result.data);});

        $http.get(staticUri.templateUrl.appTypePresentation).then(function(result){   $templateCache.put(staticUri.templateUrl.appTypePresentation, result.data);});
        $http.get(staticUri.templateUrl.appTypeReconnecting).then(function(result){   $templateCache.put(staticUri.templateUrl.appTypeReconnecting, result.data);});
        $http.get(staticUri.templateUrl.appTypeLog).then(function(result){   $templateCache.put(staticUri.templateUrl.appTypeLog, result.data);});
        $http.get(staticUri.templateUrl.appTypeUpload).then(function(result){   $templateCache.put(staticUri.templateUrl.appTypeUpload, result.data);});
       
        $http.get(staticUri.templateUrl.viewerWidget).then(function(result){   $templateCache.put(staticUri.templateUrl.viewerWidget, result.data);});
        $http.get(staticUri.templateUrl.writerWidget).then(function(result){   $templateCache.put(staticUri.templateUrl.writerWidget, result.data);});
        $http.get(staticUri.templateUrl.uploadWidget).then(function(result){   $templateCache.put(staticUri.templateUrl.uploadWidget, result.data);});
        $http.get(staticUri.templateUrl.logWidget).then(function(result){   $templateCache.put(staticUri.templateUrl.logWidget, result.data);});
        
    }]);

})();