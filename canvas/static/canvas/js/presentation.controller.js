(function () {
    'use strict';
    var controllerId = 'PresentationController';

    angular.module('canvas').controller(controllerId, PresentationController);

    PresentationController.$inject = ['common', 'datacontext','toastr', 'gridsterBuilder', '$scope', '$interval','authentication', '$rootScope', 'ngDialog','$location'];

    function PresentationController(common, datacontext,toastr, gridsterBuilder, $scope, $interval, authentication,$rootScope, ngDialog,$location) {
        var getLogFn = common.logger.getLogFn;
        var log = getLogFn(controllerId);

        var vm = this;
        vm.info = {
            title: 'Welcome To Your Canvas',
            description: 'Fill it with your imagination.'
        };
        function lsCheck(){
            var test = 'test';
            try {
                localStorage.setItem(test, test);
                localStorage.removeItem(test);
                return true;
            } catch(e) {
                return false;
            }
        }

        if(lsCheck() === true){
            $rootScope.storageAvailable = true;
            console.log("avail");
        }else{
            $rootScope.storageAvailable = false;
            console.log("not avail");
            var result2 = document.getElementsByClassName("container");
            var wrappedResult2 = angular.element(result2);
            wrappedResult2.css("display", "none");
        }
        vm.canvas = {
            config: {draggable:false},
            widgets: []
        };
        console.log( 'user_id2 - ' + $scope.user_id2);
        $rootScope.lessonNum = $scope.lesson_id;
        $rootScope.user_id2 = $scope.user_id2;
        vm.canvasName = '';
        vm.canvasDateStart = '';
        vm.canvasDateEnd = '';
        vm.canvasDateStartDisplay = '';
        vm.canvasDateEndDisplay = '';
        vm.canvasFirstFinishDisplay = '';
        vm.canvasFinishDisplay = '';
        $rootScope.menteeAbsent = '';
        vm.title = 'Home';
        vm.removeWidgetId = null;
        vm.addWidget = addWidget;
        vm.getState = getState;
        vm.removeWidget = removeWidget;
        vm.blockui=false;
        //$rootScope.showSurvey = false;

        // hack for ben, will be deleted soon!
        var currDomain = $location.host();
        var ch = currDomain.split(".")[0];
        $rootScope.subdomain = ch;
        // -----------------------------------
        activate();

        /*
        $interval( function(){ 
            //console.log('Checking canvas state.');
            //getState(); 
        }, 30000);
        */
        
        function activate() {
            sessionStorage.setItem("browser_session_id", (new Date()).getTime());
            var promises = [getPresentation()];
            common.activateController(promises, controllerId)
                .then(function () { 
                    //log('Activated Home View'); 
                });

            //authentication.login('imentor','2qa3ws4ed5rf6tg7yh');
        }

        function getCanvas() {
            return datacontext.getCanvas().then(function (data) {
                vm.canvasName = data.description;
                console.log(data.start_datetime);
                vm.canvasDateStart = data.start_datetime;
                vm.canvasDateEnd = data.end_datetime;
                vm.canvasDateStartDisplay = data.start_datetime_display;
                vm.canvasDateEndDisplay = data.end_datetime_display;
                vm.canvasFirstFinishDisplay = data.first_finish_display;
                vm.canvasFinishDisplay = data.finish_display;
                $rootScope.menteeAbsent = data.mentee_absent;
                vm.canvas.widgets =  data.apps;
                vm.canvas.canvas_set = data;
                if(data.config) {vm.canvas.config = data.config;}
                return vm.canvas.apps;
            });
        }

        function getPresentation(){
            $rootScope.loadingCanvas = true;
            $rootScope.notSavedNotification = false;
            /*return datacontext.getPresentation().then(function (data) {
                return data;
            });*/ 
            //getCanvasNew
            if ($rootScope.cscopy_id){
                
                return datacontext.getPresentationLessonCopy($rootScope.cscopy_id, $scope.user_id2).then(function (data) {
                    $rootScope.loadingCanvas = false;
                    if(typeof data.canvas_set !== "undefined") {
                        var canvasInfo = {};
                        $rootScope.unauthorizedUser = false;
                        $rootScope.inaccessibleLesson = false;

                        $rootScope.canvas = {description:  data.canvas_set.description, id:data.canvas_set.id , canvasType:data.canvas_set.canvas_type };
                        data.canvas_set.apps = setCanvasOrder(data.canvas_set.apps);
                        /* Delete after testing 
                        data.canvas_set.apps =  data.canvas_set.apps.sort(function(a,b) { return a.ordinal - b.ordinal;} );
                        for (var i = 0; i < data.canvas_set.apps.length; i++) {
                            data.canvas_set.apps[i].ordinal = i + 1;

                            data.canvas_set.apps[i].widgets =  data.canvas_set.apps[i].widgets.sort(function(a,b) { return a.ordinal - b.ordinal;} );
                            for (var j = 0; j < data.canvas_set.apps[i].widgets.length; j++) {
                                data.canvas_set.apps[i].widgets[j].ordinal = i + 1;

                                data.canvas_set.apps[i].widgets[j].content =  data.canvas_set.apps[i].widgets[j].content.sort(function(a,b) { return a.ordinal - b.ordinal;} );
                                for (var k = 0; k < data.canvas_set.apps[i].widgets[j].content.length; k++) {
                                    data.canvas_set.apps[i].widgets[j].content[k].ordinal = i + 1;
                                }
                            }
                        }
                        */
                    } else if (typeof data.canvas_set === "undefined" && angular.isDefined(data.status) && data.status != 200 ){ 
                        $rootScope.inaccessibleLesson = true;
                    } else { 
                        $rootScope.unauthorizedUser = true;
                    }
                    if(angular.isDefined(data.canvas_set)) {
                        vm.canvasName = data.canvas_set.description;
                        console.log(data.canvas_set.start_datetime);
                        vm.canvasDateStart = data.canvas_set.start_datetime;
                        vm.canvasDateEnd = data.canvas_set.end_datetime;
                        vm.canvasDateStartDisplay = data.canvas_set.start_datetime_display;
                        vm.canvasDateEndDisplay = data.canvas_set.end_datetime_display;
                        vm.canvasFirstFinishDisplay = data.canvas_set.first_finish_display;
                        vm.canvasFinishDisplay = data.canvas_set.finish_display;
                        $rootScope.menteeAbsent = data.canvas_set.mentee_absent;
                        vm.canvas.widgets =  data.canvas_set.apps;
                        vm.canvas.canvas_set = data.canvas_set;
                        vm.canvasType = data.canvas_set.canvas_type;
                        if(data.config) {vm.canvas_set.config = data.config;}
                    }
                    return vm.canvas.widgets;
                });
            }else if ($scope.lesson_id){
                return datacontext.getPresentationLesson($rootScope.lessonNum, $scope.user_id2).then(function (data) {
                    $rootScope.loadingCanvas = false;
                    if(typeof data.canvas_set !== "undefined") {
                        var canvasInfo = {};
                        $rootScope.unauthorizedUser = false;
                        $rootScope.inaccessibleLesson = false;

                        $rootScope.canvas = {description:  data.canvas_set.description, id:data.canvas_set.id , canvasType:data.canvas_set.canvas_type };
                        data.canvas_set.apps = setCanvasOrder(data.canvas_set.apps);
                        /* Delete after testing 
                        data.canvas_set.apps =  data.canvas_set.apps.sort(function(a,b) { return a.ordinal - b.ordinal;} );
                        for (var i = 0; i < data.canvas_set.apps.length; i++) {
                            data.canvas_set.apps[i].ordinal = i + 1;

                            data.canvas_set.apps[i].widgets =  data.canvas_set.apps[i].widgets.sort(function(a,b) { return a.ordinal - b.ordinal;} );
                            for (var j = 0; j < data.canvas_set.apps[i].widgets.length; j++) {
                                data.canvas_set.apps[i].widgets[j].ordinal = i + 1;

                                data.canvas_set.apps[i].widgets[j].content =  data.canvas_set.apps[i].widgets[j].content.sort(function(a,b) { return a.ordinal - b.ordinal;} );
                                for (var k = 0; k < data.canvas_set.apps[i].widgets[j].content.length; k++) {
                                    data.canvas_set.apps[i].widgets[j].content[k].ordinal = i + 1;
                                }
                            }
                        }
                        */
                    } else if (typeof data.canvas_set === "undefined" && angular.isDefined(data.status) && data.status != 200 ){ 
                        $rootScope.inaccessibleLesson = true;
                    } else { 
                        $rootScope.unauthorizedUser = true;
                    }
                    if(angular.isDefined(data.canvas_set)) {
                        vm.canvasName = data.canvas_set.description;
                        console.log(data.canvas_set.start_datetime);
		                vm.canvasDateStart = data.canvas_set.start_datetime;
                        vm.canvasDateEnd = data.canvas_set.end_datetime;
		                vm.canvasDateStartDisplay = data.canvas_set.start_datetime_display;
                        vm.canvasDateEndDisplay = data.canvas_set.end_datetime_display;
                        vm.canvasFirstFinishDisplay = data.canvas_set.first_finish_display;
                        vm.canvasFinishDisplay = data.canvas_set.finish_display;
                        $rootScope.menteeAbsent = data.canvas_set.mentee_absent;
                        vm.canvas.widgets =  data.canvas_set.apps;
                        vm.canvas.canvas_set = data.canvas_set;
                        vm.canvasType = data.canvas_set.canvas_type;
                        if(data.config) {vm.canvas_set.config = data.config;}
                    }
                    return vm.canvas.widgets;
                });
            }else{
                return datacontext.getPresentation($scope.user_id2).then(function (data) {
                    $rootScope.loadingCanvas = false;
                    if(typeof data.canvas_set !== "undefined") {
                        var canvasInfo = {};
                        $rootScope.unauthorizedUser = false;
                        $rootScope.inaccessibleLesson = false;

                        $rootScope.canvas = {description:  data.canvas_set.description, id:data.canvas_set.id ,canvasType:data.canvas_set.canvas_type  };
                        console.log($rootScope.canvas.canvasType);
                        data.canvas_set.apps = setCanvasOrder(data.canvas_set.apps);
                        /* Delete after testing 
                        data.canvas_set.apps =  data.canvas_set.apps.sort(function(a,b) { return a.ordinal - b.ordinal;} );
                        for (var i = 0; i < data.canvas_set.apps.length; i++) {
                            data.canvas_set.apps[i].ordinal = i + 1;

                            data.canvas_set.apps[i].widgets =  data.canvas_set.apps[i].widgets.sort(function(a,b) { return a.ordinal - b.ordinal;} );
                            for (var j = 0; j < data.canvas_set.apps[i].widgets.length; j++) {
                                data.canvas_set.apps[i].widgets[j].ordinal = i + 1;

                                data.canvas_set.apps[i].widgets[j].content =  data.canvas_set.apps[i].widgets[j].content.sort(function(a,b) { return a.ordinal - b.ordinal;} );
                                for (var k = 0; k < data.canvas_set.apps[i].widgets[j].content.length; k++) {
                                    data.canvas_set.apps[i].widgets[j].content[k].ordinal = i + 1;
                                }
                            }
                        }*/
                    } else if (typeof data.canvas_set === "undefined" && angular.isDefined(data.status) && data.status != 200 ){ 
                        $rootScope.inaccessibleLesson = true;
                    } else { 
                        $rootScope.unauthorizedUser = true;
                    }
                    if(angular.isDefined(data.canvas_set)) {
                        vm.canvasName = data.canvas_set.description;
                        console.log(data.start_datetime);
		                vm.canvasDateStart = data.canvas_set.start_datetime;
                        vm.canvasDateEnd = data.canvas_set.end_datetime;
		                vm.canvasDateStartDisplay = data.canvas_set.start_datetime_display;
                        vm.canvasDateEndDisplay = data.canvas_set.end_datetime_display;
                        vm.canvasFirstFinishDisplay = data.canvas_set.first_finish_display;
                        vm.canvasFinishDisplay = data.canvas_set.finish_display;
                        $rootScope.menteeAbsent = data.canvas_set.mentee_absent;
                        vm.canvas.widgets =  data.canvas_set.apps;
                        vm.canvas.canvas_set = data.canvas_set;
                        if(data.config) {vm.canvas_set.config = data.config;}
                    }
                    return vm.canvas.widgets;
                });
            }

            
        }

        function getState() {
            return datacontext.getState().then(function (data) {
                vm.canvasName = data.name;
                console.log(data.start_datetime);
                vm.canvasDateStart = data.canvas_set.start_datetime;
                vm.canvasDateEnd = data.canvas_set.end_datetime;
                vm.canvasDateStartDisplay = data.canvas_set.start_datetime_display;
                vm.canvasDateEndDisplay = data.canvas_set.end_datetime_display;
                vm.canvasFirstFinishDisplay = data.canvas_set.first_finish_display;
                vm.canvasFinishDisplay = data.canvas_set.finish_display;
                $rootScope.menteeAbsent = data.canvas_set.mentee_absent;
                vm.canvas.config = data.config;
                vm.canvas.widgets =  data.widgets;

                return vm.canvas.widgets;
            });
        }

        function addWidget() {
            vm.canvas.widgets.push({
                title: 'New Widget',
                sizeX: 1,
                sizeY: 1,
                width: 1,
                height: 1,
                sendMask: 0,
                recvMask: 0,
                type: 1,
                widgetId: _.now(),
                order: vm.canvas.widgets.length
            });
        }

        function removeWidget() {
            for (var i = 0; i < vm.canvas.widgets.length; i++) {               
                if(vm.removeWidgetId === vm.canvas.widgets[i].widgetId) {
                    vm.canvas.widgets.splice(i, 1);
                    return;
                }
            }
        }

        function blockUI(){
            vm.blockui=true;
        }
        /*
        var imentor_cdn_prefix = typeof getCdnUrlPrefix == 'function' ? getCdnUrlPrefix() : '';
        $scope.openSurvey = function () {
            ngDialog.open({
                template: imentor_cdn_prefix + '/new_platform/static/canvas/nghtml/surveypopup.html',
                controller: ['$scope', function ($scope) {
                    $scope.closeSurvey = function(){
                        $rootScope.showSurvey = false;
                        console.log("$rootScope.showRating" + $rootScope.showRating);
                        if($rootScope.showRating == false || !$rootScope.showRating) {
                            ngDialog.close();
                        }
                    }
                }],
                className: 'ngdialog-theme-plain',
                showClose: true
            });
        };*/

        function setCanvasOrder(canvasData){
            //just reordering based on ordinal, without changing ordinal value
            if(canvasData !== undefined) {
                var apps = canvasData;
                apps =  apps.sort(function(a,b) { return a.ordinal - b.ordinal;} );
                for (var i = 0; i < apps.length; i++) {
                    var app = apps[i];
                    if(app.widgets !== undefined) {
                        app.widgets =  app.widgets.sort(function(a,b) { return a.ordinal - b.ordinal;} );
                        for (var j = 0; j <  app.widgets.length; j++) {
                            var widget = app.widgets[j];
                            if(widget.content !== undefined) {
                                widget.content =  widget.content.sort(function(a,b) { return a.ordinal - b.ordinal;} );
                                for (var k = 0; k <  widget.content.length; k++) {
                                    var content = widget.content[k];
                                    
                                    if(content.response_marker_refs !== undefined) {
                                        content.response_marker_refs =  content.response_marker_refs.sort(function(a,b) { return a.ordinal - b.ordinal;} );
                                    }

                                    if(content.response_markers !== undefined) {
                                        content.response_markers =  content.response_markers.sort(function(a,b) { return a.ordinal - b.ordinal;} );
                                    }
                                }
                            } 
                        }
                    } 
                }
            }

            return canvasData;
        }
    }
})();
