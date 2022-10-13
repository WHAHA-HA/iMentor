/* jshint loopfunc:true */
/*jshint sub:true*/

(function() {

    'use strict';

    angular.module('canvas')

    .filter('reverse', function () {
        return function(items) {
            return items.slice().reverse();
        };
    })
    
    .controller('WidgetSettingsController', ['$scope', '$timeout', '$rootScope', '$modalInstance', 'widget', 'widgetService',
        function($scope, $timeout, $rootScope, $modalInstance, widget, widgetService) {

            $scope.widget = widget;

            $scope.widgetHeights = widgetService.getWidgetHeights();

            $scope.selectedWidgetHeight = $scope.widgetHeights[widget.height - 1];

            $scope.form = {
                title: widget.title,
                height: widget.height,
                width: widget.width,
                send_mask: widget.send_mask,
                recv_mask: widget.recv_mask,
                id: widget.id,
                type: widget.type
            };

            $scope.dismiss = function() {
                $modalInstance.dismiss();
            };

            $scope.submit = function() {
                angular.extend(widget, $scope.form);
                $modalInstance.close(widget);
                $scope.$emit('widget-setting-changed', widget);
                var message =   widgetService.createMessage(
                                {'flow':messageConstant.flow.WIDGET_BACKEND,
                                'type':messageConstant.type.MESSAGE,
                                //'status':messageConstant.status.ACK,
                                'timestamp_ms':widgetService.getTimestamp(),
                                'send_mask':$scope.widget.send_mask, 
                                'recv_mask':0},{'message':$scope.richtextContent});

                console.log(message);
                $scope.$emit('widget-acivity', message);
                $scope.$emit('widget-acivity', widgetService.createActivityMessage($scope.widget, 'SEND', 5, $scope.form));
            };

        }
    ])


    .directive('mentioTextAngular', ['$sce','imEmbedService','widgetService','messageConstant','taApplyCustomRenderers', 'staticUri', function($sce,imEmbedService,widgetService,messageConstant,taApplyCustomRenderers,staticUri) {
        controller.$inject = ['$scope', '$element', '$attrs', '$transclude', '$q'];
        return {
            restrict: 'AE', // only activate on element attribute
            require: '?ngModel', // get a hold of NgModelController
            templateUrl: function (argument) {
                return staticUri.templateUrl.mentioTextAngular;
            },
            controller: controller,
            link: link
        };
        
        function controller($scope, $element, $attrs, $transclude, $q  ) {

  
            function initRichtextContent() {
             
                
                $scope.$watch('ngModel', function() {
                     //$scope.previewData.html =  imEmbedService.process($scope.ngModel);
                }, true);
                
            }
            $scope.emojis =[];
            $scope.emojisFiltered = [];

            $scope.macros = [];
            $scope.macrosFiltered = [];
            $scope.textAngularName = 'textAngular' + (new Date()).getTime();
            $scope.blankImage = staticUri.resourceUri.emojiPath + 'blank.gif';

            $scope.searchEmoji = function(term) {
                var emojiList = [];
                for (var i = 0; i < $scope.emojis.length; i++) {
                    var item = $scope.emojis[i];
                    if (item.short_name.toUpperCase().indexOf(term.toUpperCase()) >= 0) {
                        item.imageUrl = staticUri.resourceUri.emojiImage + item.image;
                        item.emojiClass = "emoji emoji-" + item.unified.toLowerCase();
                        emojiList.push(item);
                        if(emojiList.length===10){
                            break;
                        }
                    }   
                }
                $scope.emojisFiltered = emojiList;
                return $q.when(emojiList);
            };

            $scope.getEmojiText = function(item) {
              return '<img src="' + item.imageUrl + '" height="20" width="20" >';
              //return '<img src="' +  staticUri.resourceUri.emojiPath + 'blank.gif" class="emoji emoji-' + item.unified.toLowerCase() + '" />';
            };


            $scope.searchMacro = function(term) {
                var macroList = [];
                angular.forEach($scope.macros, function(item) {
                  if (item.key.toUpperCase().indexOf(term.toUpperCase()) >= 0) {
                    macroList.push(item);
                  }
                });
                $scope.macrosFiltered = macroList;
                return $q.when(macroList);
            };

            $scope.getMacroText = function(item) {
              return item.value;
            };
            
            $scope.setup = function(element){
                /*element.attr('mentio','mentio');
                element.attr('mentio-typed-term', 'typedTerm');
                element.attr('mentio-require-leading-space', 'true');
                element.attr('mentio-id', $scope.textAngularName);*/
                //element.attr('placeholder', "Write here.");
            }; 

           
            function activate() { 
                imEmbedService.getEmojis().then(function (data) {
                    $scope.emojis = data;
                });

                imEmbedService.getMacros().then(function (data) {
                    $scope.macros = data;
                });

                initRichtextContent();
            }

            activate();
        }

        function link(scope, element, attrs, ngModel) {
            function read() {
                var html = element.html();
                // When we clear the content editable the browser leaves a <br> behind
                // If strip-br attribute is provided then we strip this out
                if (attrs.stripBr && html === '<br>') {
                    html = '';
                }
                ngModel.$setViewValue(html);
            }

            if(!ngModel) return; // do nothing if no ng-model

            // Specify how UI should be updated
            ngModel.$render = function() {
                if (ngModel.$viewValue !== element.html()) {
                    element.html($sce.getTrustedHtml(ngModel.$viewValue || ''));
                }
            };

            // Listen for change events to enable binding
            element.on('blur keyup change', function() {
                scope.$apply(read);
            });
            read(); // initialize
        }
    }])
    /**
     * The widget container directive.
     *
     * @param {Object} $compile
     */
    .directive('canvas', ['$compile','$timeout','staticUri','widgetService', 'common', 'datacontext', 'toastr', 'gridsterBuilder', '$interval', 'messageConstant','$document','$rootScope','$location', '$window', 
        function($compile,$timeout, staticUri, widgetService, common, datacontext, toastr, gridsterBuilder, $interval, messageConstant,$document,$rootScope,$location, $window) {
            controller.$inject = ['$scope', '$element', '$attrs', '$transclude'];
            return {
                link: link,
                controller: controller,
                templateUrl: function (argument) {
                    return staticUri.templateUrl.widgetContainer;
                },
                scope: {
                    config: '=',
                    widgets: '=',
                    blockui: '=',
                    canvasSet: '='
                },
                transclude: true
            };

            function controller($scope, $element, $attrs, $transclude ) {

                $scope.config = {};
                $scope.widgets = [];
                $scope.canvasSet = {};
                $scope.name = '';
                $scope.gridsterOptions = {};
                $scope.containerWidgets = [];
                $scope.blockUI = blockUI;
                $scope.blockui = false;
                $scope.blockuiUser = false;
                $scope.messages  = [];
                $scope.isCanvasPolling = false;
                $scope.pollingMessagesCount = 0;
                $scope.url = "";
                $scope.othertUser = {};
                $scope.user = {};

                $scope.getMessages = getMessages;
                $scope.activate = activate;
                $scope.finishActivity =finishActivity;
                $scope.finishButtonDefaultText = "Finish";
                $scope.finishButtonText = $scope.finishButtonDefaultText;
                $scope.stopRetrySave = stopRetrySave;
                $scope.retrySave = retrySave; 
                $scope.isSavePending = isSavePending;

                $scope.$watch('name', function(config) {
                    
                }, true);

                $scope.$watch('config', function(config) {
                    $scope.gridsterOptions = gridsterBuilder.getGridsterOptions($scope.config);
                    $scope.gridsterOptions.draggable.stop = widgetDragStop;
                }, true);

                $scope.$watch('blockui', function() {
                    /*if ($scope.blockui === true) {
                        common.$timeout(function() {
                            $scope.blockui = false;
                        }, 5000);
                    }*/
                }, true);

                $scope.$watch('user', function(config) {
                    updateFinishButtonText();
                }, true);

                $scope.$watch('canvasSet', function(config) {
                    updateFinishButtonText();
                }, true);



                $scope.$watchCollection('widgets', function(items) {
                    if($scope.widgets) {
                    
                    if($scope.widgets.length !== 0) {$scope.showFinish = true;}

                    if ($scope.widgets.length !== 0 & $scope.containerWidgets.length === 0) {

                        createCanvas();
                    } else if ($scope.widgets.length !== 0 & $scope.containerWidgets.length !== 0) {
                        var i = $scope.containerWidgets.length;
                        while (i--) {
                            var stateHasWidget;
                            stateHasWidget = _.find($scope.widgets, function(widget) {
                                return widget.id === $scope.containerWidgets[i].id;
                            });

                            if (stateHasWidget === undefined) {

                                var message =   widgetService.createMessage(
                                                {'flow':messageConstant.flow.WIDGET_BACKEND,
                                                'type':messageConstant.type.STATUS,
                                                'status':messageConstant.status.GOODBYE,
                                                'timestamp_ms':widgetService.getTimestamp(),
                                                'send_mask':$scope.widget.send_mask, 
                                                'recv_mask':0});

                                $scope.$emit('widget-acivity', message);

                                $scope.containerWidgets.splice(i, 1);
                            }
                        }

                        for (var j = 0; j < $scope.widgets.length; j++) {
                            var containerHasWidget;
                            containerHasWidget = _.find($scope.containerWidgets, function(widget) {
                                return widget.id === $scope.widgets[j].id;
                            });
                            
                            if (containerHasWidget === undefined) {
                                $scope.containerWidgets.push(angular.copy($scope.widgets[j]));
                            }
                        }

                        $scope.containerWidgets = gridsterBuilder.getWidgetPosition($scope.containerWidgets);

                        $scope.$broadcast('widget-check-state', {
                            'id': widgetService.getTimestamp(),
                            'state': 'CHECK'
                        });
                    }
                }
                }, true);

                $scope.$watch('containerWidgets', function(items) {
                    //console.log('watch widgets');
                }, true);


                $interval( function(){ 
                    getMessages();
                }, 20000);

                $scope.$on('$viewContentLoaded', function(event) {
                  $timeout(function() {
                    activate();
                  },0);
                });

                $scope.$on('widget-setting-changed', function(event, data) {
                    $scope.containerWidgets = gridsterBuilder.getWidgetPosition($scope.containerWidgets);
                });

                $scope.$on('widget-acivity', function(event, message) {
                    $scope.$broadcast('widget-message', message);
                    $scope.messages.push(message);
                });

                var retrySaveInterval;
                var retrySaveTimeout = 2500;
                $scope.$on('net-status-changed', function(event, message) {
                    // Don't start a new if we are already fighting
                    $scope.stopRetrySave();
                    if(message.status === false) {
                        $scope.finishButtonText = 'No Internet.';
                            
                        if (!$rootScope.finishingActivity) {
                            $scope.retrySave();
                        }
                    } else {
                        if($scope.finishButtonText === 'No Internet.'){
                            $scope.finishButtonText = $scope.finishButtonDefaultText;
                            $scope.stopRetrySave();
                            retrySaveTimeout = 2500;
                        }
                    } 
                });

                /*
                window.onLineHandler = function(){
                    $scope.$broadcast('save-work');
                    $scope.finishButtonText = "Finish";
                };
                window.offLineHandler = function(){
                    $scope.finishButtonText = "No Internet.";
                };
                */
                $scope.saveCountDownInterval = undefined;
                function startSaveCountDown(time) {
                    stopSaveCountDown();
                    var i = time / 1000;
                    $rootScope.retrySavedNotification = true;
                    $rootScope.notSavedNotification = false;
                    $("#retrySavedNotification").html("Not yet saved. Check your Internet connection. Retrying in "  + i + " seconds…");
                    $scope.saveCountDownInterval = $interval(function() {
                        $rootScope.retrySavedNotification = true;
                        $rootScope.notSavedNotification = false;
                        $("#retrySavedNotification").html("Not yet saved. Check your Internet connection. Retrying in "  + i + " seconds…");
                        i--;
                        if(i==-1) {
                            stopSaveCountDown();
                        }
                    }, 1000);
                }


                function stopSaveCountDown() {
                    if (angular.isDefined($scope.saveCountDownInterval)) {
                        $interval.cancel($scope.saveCountDownInterval);
                        $scope.saveCountDownInterval = undefined;
                    }
                    $rootScope.retrySavedNotification = false;
                }

                function updateFinishButtonText(){
                    if($scope.canvasSet.canvas_type === 3){
                        if($scope.user.role === 'Mentor'){

                            $scope.finishButtonText = "Open Conversations";
                            $scope.finishButtonDefaultText = "Open Conversations";
                            $scope.blueButton = true;
                        }
                    } else {
                        $scope.finishButtonDefaultText = "Finish";
                        $scope.finishButtonText = "Finish";
                        $scope.blueButton = false;
                    }
                }

                function retrySave() {
                    $scope.stopRetrySave();
                    var savePending = isSavePending(false);
                    if(savePending.isPending === false) {
                            $scope.stopRetrySave();
                    } else {

                        //if(retrySaveTimeout < 80000) {
                                retrySaveTimeout = randomIntFromInterval(2,15) * 1000; //retrySaveTimeout * 2;
                        //}  

                        startSaveCountDown(retrySaveTimeout);
                        retrySaveInterval = $interval(function() {
                            isSavePending(true); //retrySave();
                        }, retrySaveTimeout + 1000);
                    }
                }

                function stopRetrySave() {
                    if (angular.isDefined(retrySaveInterval)) {
                        $interval.cancel(retrySaveInterval);
                        retrySaveInterval = undefined;
                    }
                    if(!$rootScope.finishingActivity) {
                        stopSaveCountDown();
                    }
                }

                function createCanvas() {
                    $scope.containerWidgets = angular.copy($scope.widgets);
                    $scope.gridsterOptions = gridsterBuilder.getGridsterOptions($scope.config);
                    $scope.containerWidgets = gridsterBuilder.getWidgetPosition($scope.widgets);
                    $scope.gridsterOptions.draggable.stop = widgetDragStop;
                }

                function widgetDragStop(event, $element, widget) {
                    getWidgetOrder();
                }

                function getWidgetOrder() {
                    $scope.containerWidgets = gridsterBuilder.getWidgetOrder($scope.containerWidgets);
                }

                function getMessages (argument) {
                    if(!$scope.isCanvasPolling) {
                        if($scope.messages.length===0){
                            var message =   widgetService.createMessage(
                                        {'flow':messageConstant.flow.ROOT_BACKEND ,
                                        'type':messageConstant.type.STATUS,
                                        'status':messageConstant.status.POLL,
                                        'timestamp_ms':widgetService.getTimestamp(),
                                        'send_mask':0, 
                                        'recv_mask':0});
                            $scope.messages.push(message);
                        }
                        $scope.isCanvasPolling = true;
                        var msgs = angular.copy($scope.messages);
                        $scope.pollingMessagesCount = msgs.length;
                        /*
                        return datacontext.postMessages(msgs).then(function (data) {
                            console.log(data);
                            for (var i = 0; i < data.length; i++) {
                                $scope.$broadcast('widget-message', data[i]);
                                if(data[i].type === messageConstant.type.MESSAGE && data[i].send_mask === messageConstant.sendMask.MM_WRITER_3_SENDMASK){
                                    if(angular.isDefined(data[i].data.message.blouckUi)){
                                        $scope.blockui = data[i].data.message.blouckUi;
                                    }
                                }
                            };

                            $scope.messages.splice(0, $scope.pollingMessagesCount);
                            $scope.isCanvasPolling = false;
                            return data;
                        });
                        */ 
                    }
                }

                function activate (argument) {
                    ////getMessages();
                    getUserInfo($rootScope.user_id2);
                }

                function blockUI(){
                    $scope.blockuiUser = !$scope.blockuiUser;
                    var message =   widgetService.createMessage(
                                    {'flow':messageConstant.flow.WIDGET_BACKEND,
                                    'type':messageConstant.type.MESSAGE,
                                    //'status':messageConstant.status.GOODBYE,
                                    'timestamp_ms':widgetService.getTimestamp(),
                                    'send_mask':messageConstant.sendMask.MM_WRITER_3_SENDMASK, 
                                    'recv_mask':0},{'blouckUi': $scope.blockuiUser});

                    console.log(message);
                    $scope.$emit('widget-acivity', message);
                }

                function getUserInfo (user_id) {
                    return datacontext.getUserInfo(user_id).then(function (data) {
                        $scope.otherUser= data.mentee || data.mentor;
                        $rootScope.otherUser= data.mentee || data.mentor;
                        if(data.mentor) {
                            $scope.otherUser.role = "Mentor";
                        }
                        
                        $scope.user= data.self;
                        $rootScope.user = $scope.user;
                    });
                }

                var finishActivityInterval;
                var finishActivityTimeout;

                function finishActivity(){
                    $rootScope.finishingActivity = true;
                    finishActivityInterval = undefined;
                    finishActivityTimeout = 2500;
                    finishActivityTry();
                }

                function finishActivityTry() {
                    
                    if($scope.finishButtonText != 'No Internet.'){
                        $scope.finishButtonText = "Saving...";
                    }

                    if (angular.isDefined(finishActivityInterval)) {
                        $interval.cancel(finishActivityInterval);
                        finishActivityInterval = undefined;
                    }

                    var savePending = isSavePending(true);
                    if(savePending.isPending === true || savePending.isSaving === true) {
                        
                        //if(finishActivityTimeout < 80000) {
                            finishActivityTimeout = randomIntFromInterval(2,15) * 1000;  //finishActivityTimeout * 2 ;
                        //}

                        startSaveCountDown(finishActivityTimeout);
                        finishActivityInterval = $interval(function() {
                            finishActivityTry();
                        }, finishActivityTimeout + 1000);
                        
                        
                        //setTimeout(finishActivity, 2000) //wait 2 seconds before retrying
                    } else {
                        //$scope.$broadcast('save-work'); 
                        if($rootScope.canvas && $rootScope.canvas.id) {
                            var message = {canvas_set_id : $rootScope.canvas.id};
                            $rootScope.savedNotification = true;
                            $rootScope.notSavedNotification = false;
                            datacontext.postFinished(message, $rootScope.user_id2).then(function (data) {
                                if(data) {
                                    if (angular.isDefined(finishActivityInterval)) {
                                        $interval.cancel(finishActivityInterval);
                                        finishActivityInterval = undefined;
                                    }

                                    var msgDuration = 1000;
                                    $scope.msgTimer = $timeout(function () {
                                      $rootScope.savedNotification = false;
                                    },msgDuration);

                                    if($scope.canvasSet.canvas_type === 3 && $scope.user.role === 'Mentor') {
                                        //$window.location.href = "/portfolio/#/grade/" + $scope.canvasSet.grade_id + "/unit/" + $scope.canvasSet.unit_id;
                                        $rootScope.openChat();
                                        $rootScope.unseenPolling();
                                        updateFinishButtonText();
                                    } else {
                                        $location.path( "/finish" );
                                        //updateFinishButtonText();
                                    }
                                        
                                } else {
                                    $rootScope.savedNotification = false;
                                    $rootScope.notSavedNotification = false;
                            
                                    $scope.finishButtonText = 'No Internet.';
                                    if (angular.isDefined(finishActivityInterval)) {
                                        $interval.cancel(finishActivityInterval);
                                        finishActivityInterval = undefined;
                                    }
                                    
                                    //if(finishActivityTimeout < 80000) {
                                        finishActivityTimeout = randomIntFromInterval(2,15) * 1000;  //finishActivityTimeout * 2 ;
                                    //}

                                    startSaveCountDown(finishActivityTimeout);
                                    finishActivityInterval = $interval(function() {
                                        finishActivityTry();
                                    }, finishActivityTimeout + 1000);
                                }
                            });
                        }

                        

                        /*
                        common.$timeout(function() {    
                            //window.location.href  = common.getUrl(staticUri.routeUri.canvasFinish);
                        }, 300);
                        */
                    }
                }



                function isSavePending(callSave) {
                    /*code for checking if any pending save exists*/
                    var logger = common.logger.getLogFn('saveWork');
                    logger('Retying save ...');
                                    
                    var isPending = false;
                    var isSaving = false;
                    if($scope.widgets) {
                        for (var i=0; i<$scope.widgets.length; i++ ) {
                            if($scope.widgets[i].widgets) {
                                for (var j = 0; j < $scope.widgets[i].widgets.length; j++) {
                                    if($scope.widgets[i].widgets[j].content) {
                                        for (var k = 0; k < $scope.widgets[i].widgets[j].content.length; k++) {
                                            if($scope.widgets[i].widgets[j].content[k].response_markers) {
                                                for (var l = 0; l < $scope.widgets[i].widgets[j].content[k].response_markers.length; l++) {

                                                    var ele;
                                                    var responseEle;
                                                    var responseScope;
                                                    var newTransactionId;
                                                    var log;
                                                    if($scope.widgets[i].widgets[j].content[k].response_markers[l].responses.length ===0){
                                                        //No response section
                                                        ele = angular.element(document.querySelector('#response_marker_'+ $scope.widgets[i].widgets[j].content[k].response_markers[l].id + ''));
                                                        if (ele || ele.length >= 0) {
                                                            responseEle = ele.find('.response-type-widget');
                                                            for (var m = 0; m < responseEle.length; m++) {
                                                                responseScope = angular.element(responseEle[m]).scope();

                                                                /*Save any unsaved edits*/ 
                                                                if(angular.isObject(responseScope)){
                                                                    if(responseScope.isSavingWork){
                                                                        logger('Retrying Save: Save already in progress...');
                                                                        isSaving = true;
                                                                    } else if(responseScope.isSaveWorkRequestPending) {
                                                                        
                                                                        if(callSave === true) {
                                                                            $rootScope.savedNotification = true;
                                                                        
                                                                            //Loggin  Disabled
                                                                            newTransactionId = (new Date()).getTime();
                                                                            
                                                                            try {
                                                                                log = getlog();
                                                                                log.action = 'Call Save: Retrying Save';
                                                                                log.transactionId  = newTransactionId;
                                                                                logger(log.action, log);
                                                                                //datacontext.logJson(log);
                                                                            } catch(err) {
                                                                                //ignore error just logging code.
                                                                            }
                                                                            responseScope.saveWork(newTransactionId); 
                                                                        }
                                                                        isPending = true;
                                                                    } 
                                                                }
                                                            }
                                                        }

                                                    } else {
                                                        for (var n = 0; n < $scope.widgets[i].widgets[j].content[k].response_markers[l].responses.length; n++) {
                                                            ele = angular.element(document.querySelector('#response_'+ $scope.widgets[i].widgets[j].content[k].response_markers[l].responses[n].id + ''));
                                                            if (ele || ele.length >= 0) {
                                                                responseEle = ele.find('.response-type-widget');
                                                                for (var o = 0; o < responseEle.length; o++) {
                                                                    responseScope = angular.element(responseEle[o]).scope();

                                                                    /*Save any unsaved edits*/ 
                                                                    if(angular.isObject(responseScope)){
                                                                        if(responseScope.isSavingWork){
                                                                            logger('Retrying Save: Save already in progress...');
                                                                            isSaving = true;
                                                                        } else if(responseScope.isSaveWorkRequestPending) {
                                                                            
                                                                            
                                                                            if(callSave === true) {
                                                                                $rootScope.savedNotification = true;
                                                                                //Loggin  Disabled
                                                                                newTransactionId = (new Date()).getTime();
                                                                                
                                                                                try {
                                                                                    log = getlog();
                                                                                    log.action = 'Call Save: Retrying Save';
                                                                                    log.transactionId  = newTransactionId;
                                                                                    logger(log.action, log);
                                                                                    //datacontext.logJson(log);
                                                                                } catch(err) {
                                                                                    //ignore error just logging code.
                                                                                }
                                                                                responseScope.saveWork(newTransactionId); 
                                                                            }
                                                                            isPending = true;
                                                                        }  
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    return {isPending : isPending , isSaving : isSaving};
                }

                function validation() {
                    /*code for handling widget level functon before finish like validation etc*/
                    /*
                    var offset = 30;
                    var duration = 2000;
                    if($scope.widgets) {
                        for (var i=0; i<$scope.widgets.length; i++ ) {
                            if($scope.widgets[i].widgets) {
                                for (var j = 0; j < $scope.widgets[i].widgets.length; j++) {
                                    if($scope.widgets[i].widgets[j].content) {
                                        for (var k = 0; k < $scope.widgets[i].widgets[j].content.length; k++) {
                                            if($scope.widgets[i].widgets[j].content[k].response_markers) {
                                                for (var l = 0; l < $scope.widgets[i].widgets[j].content[k].response_markers.length; l++) {
                                                    var ele = angular.element(document.querySelector('#response_marker_'+ $scope.widgets[i].widgets[j].content[k].response_markers[l].id + ''));
                                                    if (ele || ele.length >= 0) {
                                                        var responseEle = ele.find('.response-type-widget');
                                                        for (var m = 0; m < responseEle.length; m++) {
                                                            var responseScope = angular.element(responseEle[m]).scope();
                                                            
                                                            /*Save any unsaved edits  - Not used, using eventing instead.*/ 
                                                            /*
                                                            if(responseScope && responseScope.isSaveWorkRequestPending){
                                                                $rootScope.savedNotification = true;
                                                                var newTransactionId = (new Date()).getTime();
                                                                responseScope.saveWork(newTransactionId);
                                                            }*/
                                                            
                                                            /*Validation - Not used as no validation required as of now*/
                                            
                                                            /*
                                                            if(responseScope && !responseScope.validateInput()){
                                                                $document.scrollToElement(angular.element(responseEle[m]),offset,duration);
                                                                return false;
                                                            }*/
                                                            /*
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    */
                }

                common.$timeout(function() {
                        getMessages();
                }, 5000);

                activate();

            }

            function link(scope, $el, attrs, controllers) {
                //$timeout(scope.$eval( $scope.activate()), 0);
               
            }
        }
    ])


    /**
     * The presentation app directive.
     *
     * @param {Object} $compile
     */
    .directive('presentationApp', ['$templateCache','staticUri',
        function($templateCache, staticUri) {
            controller.$inject = ['$scope', '$element', '$attrs', '$transclude'];
            return {
                restrict: 'ACE',
                link: link,
                controller: controller,
                scope: true,
                transclude: true,
                replace: false,
                template: function (argument) {
                    return $templateCache.get(staticUri.templateUrl.appTypePresentation);
                }
            };

            function controller($scope, $element, $attrs, $transclude ) {
                
            }

            function link(scope, $el, attrs, controllers) {
            }
        }
    ])

    /**
     * The writer app directive.
     *
     * @param {Object} $compile
     */
    .directive('reconnectingApp', ['$templateCache', 'staticUri',
        function($templateCache, staticUri) {
            controller.$inject = ['$scope', '$element', '$attrs', '$transclude'];
            return {
                restrict: 'ACE',
                link: link,
                controller: controller,
                scope: true,
                transclude: true,
                replace: false,
                template: function (argument) {
                    return $templateCache.get(staticUri.templateUrl.appTypeReconnecting);
                }
            };

            function controller($scope, $element, $attrs, $transclude ) {
                
            }

            function link(scope, $el, attrs, controllers) {
                console.log(scope);
            }
        }
    ])

    /** The upload app directive.
     *
     * @param {Object} $compile
     */
    .directive('uploadApp', ['$templateCache', 'staticUri',
        function($templateCache, staticUri) {
            controller.$inject = ['$scope', '$element', '$attrs', '$transclude'];
            return {
                restrict: 'ACE',
                link: link,
                controller: controller,
                scope: true,
                transclude: true,
                replace: false,
                template: function (argument) {
                    return $templateCache.get(staticUri.templateUrl.appTypeUpload);
                }
            };

            function controller($scope, $element, $attrs, $transclude ) {
                
            }

            function link(scope, $el, attrs, controllers) {
            }
        }
    ])

     /** The upload app directive.
     *
     * @param {Object} $compile
     */
    .directive('logApp', ['$templateCache', 'staticUri',
        function($templateCache,  staticUri) {
            controller.$inject = ['$scope', '$element', '$attrs', '$transclude'];
            return {
                restrict: 'ACE',
                link: link,
                controller: controller,
                scope: true,
                transclude: true,
                replace: false,
                template: function (argument) {
                    return $templateCache.get(staticUri.templateUrl.appTypeLog);
                }
            };

            function controller($scope, $element, $attrs, $transclude ) {
                
            }

            function link(scope, $el, attrs, controllers) {
            }
        }
    ])

    


    /**
     * The widget directive.
     *
     * @param {Object} $compile
     */
    .directive('widget', ['staticUri', '$modal', 'widgetService','messageConstant',
        function(staticUri, $modal, widgetService,messageConstant) {
            controller.$inject = ['$scope', '$element', '$attrs', '$transclude'];
            return {
                link: link,
                controller:  controller,
                templateUrl: function (argument) {
                    return staticUri.templateUrl.widget;
                },
                scope: true,
                transclude: true,
                require: '^canvas'
            };

            function controller($scope, $element, $attrs, $transclude ) {
                $scope.remove = function() {
                    //console.log($scope.containerWidgets.indexOf($scope.widget));

                    $scope.containerWidgets.splice($scope.containerWidgets.indexOf($scope.widget), 1);


                    var message =   widgetService.createMessage(
                                    {'flow':messageConstant.flow.WIDGET_BACKEND,
                                    'type':messageConstant.type.STATUS,
                                    'status':messageConstant.status.GOODBYE,
                                    'timestamp_ms':widgetService.getTimestamp(),
                                    'send_mask':$scope.widget.send_mask, 
                                    'recv_mask':0});

                    //console.log(message);
                    $scope.$emit('widget-acivity', message);
                };

                $scope.openSettings = function() {
                    $modal.open({
                        scope: $scope,
                        templateUrl: function (argument) {
                            return staticUri.templateUrl.widgetSettings;
                        },
                        controller: 'WidgetSettingsController',

                        resolve: {
                            widget: function() {
                                return $scope.widget;
                            }
                        }
                    });
                };

                $scope.getWidgetApp = function(app) {
                    /*
                    var template = '';
                    switch($scope.widget.app_type) {
                        case messageConstant.appType.APP_TYPE_WRITING:
                            template  = '<div class="writer-app"></div>';
                            break;
                        case messageConstant.appType.APP_TYPE_PRESENTATION:
                            template = '<div class="presentation-app"></div>';
                            break;
                    }
                    return template; 
                    */
                    return widgetService.getWidgetApp(app);
                };

                $scope.getWidgetContent = function(content) {
                      return widgetService.getWidgetContent(content);
                };

                $scope.getWidgetResponseMarker = function(responseMarker) {
                      return widgetService.getWidgetResponseMarker(responseMarker);
                };

                $scope.getWidgetResponse = function(responseMarker) {
                    if(!responseMarker.response_type) {responseMarker.response_type = 2;}
                    return widgetService.getWidgetResponse(responseMarker);
                };
            }

            function link(scope, $el, attrs, controllers) {

            }
        }
    ])



    /**
     * The generic writer widget directive.
     *
     * @param {Object} $compile
     */
    .directive('writerWidget', ['$templateCache', 'staticUri', 'widgetService', 'datacontext','messageConstant', '$sce','imEmbedService', 'taApplyCustomRenderers' ,
        function($templateCache, staticUri, widgetService, datacontext,messageConstant, $sce,imEmbedService,taApplyCustomRenderers) {
            controller.$inject = ['$scope', '$element', '$attrs', '$transclude'];
            return {
                restrict: 'ACE',
                link: link,
                controller: controller,
                scope: true,
                require: '^canvas',
                template: function (argument) {
                    return $templateCache.get(staticUri.templateUrl.writerWidget);
                }
            };

            function link(scope, $el, attrs, controllers) {
                //console.log(scope);
            }

            function controller($scope, $element, $attrs, $transclude ) {
                function initRichtextContent() {
                     $scope.richtextContent = {
                                            html: '',
                                            text: '',
                                            words: 0,
                                            chars: 0,
                                            user_id: ''
                                        };
                      $scope.previewData = {
                                    html: '',
                                    text: '',
                                    words: 0,
                                    chars: 0,
                                    user_id: ''
                                };               
                    /*
                    $scope.$watch('richtextContent', function() {
                        $scope.previewData = $scope.richtextContent.html;
                    }, true);
                    */
                }


                $scope.submit = function() {
                    $scope.previewData.user_id = $scope.user.user_id;
                    
                    $scope.previewData.html =  taApplyCustomRenderers(imEmbedService.process($scope.ngModel));

                    var message =   widgetService.createMessage(
                                    {'flow':messageConstant.flow.WIDGET_BACKEND,
                                    'type':messageConstant.type.MESSAGE,
                                    //'status':messageConstant.status.GOODBYE,
                                    'timestamp_ms':widgetService.getTimestamp(),
                                    'send_mask':$scope.widget.send_mask, 
                                    'recv_mask':0,
                                    'canvas_set_id': $scope.widget.canvas_set_id,
                                    'canvas_app_id': $scope.appWidget.canvas_app_id,
                                    'widget_id': $scope.content.widget_id,
                                    'widget_content_id': $scope.responseMarker.widget_content_id,
                                    'response_marker_id': $scope.responseMarker.id,
                                    'ordinal':  $scope.responseMarker.ordinal
                                    },{'message':$scope.previewData});
                    //console.log($scope.previewData);

                    $scope.$emit('widget-acivity', message);

                    initRichtextContent();

                    $scope.ngModel = '';
                    $scope.previewData.html =  $scope.ngModel;
                };

                $scope.preview = function() {
                   $scope.previewData.html =  taApplyCustomRenderers(imEmbedService.process($scope.ngModel));
                };


                $scope.$on('widget-check-state', function(event, message) {
                    //console.log('widget-check-state');
                });

                
                $scope.$on('$destroy', function () {
                    //console.log('RichtextWriterWidget destroy');
                    var message = widgetService.createMessage({'flow':messageConstant.flow.WIDGET_BACKEND,'type':messageConstant.type.STATUS,'status':messageConstant.writeWidgetStatus.USER_OFFLINE,'timestamp_ms':widgetService.getTimestamp(),'send_mask':$scope.widget.send_mask, 'recv_mask':0});
                    $scope.$emit('widget-acivity', message);
                });

                function acivate(){
                    //console.log('RichtextWriterWidget Activated');
                    var message = widgetService.createMessage({'flow':messageConstant.flow.WIDGET_BACKEND,'type':messageConstant.type.STATUS,'status':messageConstant.writeWidgetStatus.USER_ONLINE,'timestamp_ms':widgetService.getTimestamp(),'send_mask':$scope.widget.send_mask, 'recv_mask':0});
                    $scope.$emit('widget-acivity', message);

                    initRichtextContent();
                }
                

                acivate();

            }
        }
    ])


    /**
     * The richtext viewer widget directive.
     *
     * @param {Object} $compile
     */
    .directive('viewerWidget', ['$templateCache', 'staticUri','widgetService', 'common','datacontext','messageConstant','imEmbedService',
        function($templateCache, staticUri,widgetService, common,datacontext,messageConstant,imEmbedService) {
            controller.$inject = ['$scope', '$element', '$attrs', '$transclude'];
            return {
                restrict: 'ACE',
                link: link,
                controller: controller,
                scope: true,
                require: '^canvas',
                template: function (argument) {
                    return $templateCache.get(staticUri.templateUrl.viewerWidget);
                }
                //controllerAs: 'vm',
            };

            function controller($scope, $element, $attrs, $transclude ) {

                $scope.richtextContent = []; //{html: '',text: ''}
                $scope.newContent = [];
              

                $scope.$on('widget-message', function(event, message) {
                    if (($scope.widget.recv_mask & message.send_mask) !== 0) {
                        if (message.type === 2) {
                            var content = message.data.message.message || message.data.message;
                            content.addedOn = common.getDateTime(message.timestamp_ms);
                            content.user = $scope.user.user_id === content.user_id ? $scope.user : $scope.otherUser;
                            content.html = content.html;
                            $scope.richtextContent.push(angular.copy(content));
                            
                            common.$timeout(function() {
                                var message =   widgetService.createMessage(
                                    {'flow':messageConstant.flow.W2W,
                                    'type':messageConstant.type.MESSAGE,
                                    'status':messageConstant.status.ACK,
                                    'timestamp_ms':widgetService.getTimestamp(),
                                    'send_mask':$scope.widget.send_mask, 
                                    'recv_mask':0});

                                $scope.$emit('widget-acivity', message);
                            }, 500);
                        }
                    }

                    if(message.status ===3 && message.src_dst === 5){
                        //console.log(message);
                        if(message.data.user){
                            $scope.otherUser.online = message.data.user.online;
                        }
                    }
               });

            }

            function link(scope, $el, attrs, controllers) {
                 //console.log(scope);
            }
        }
    ])

    /**
     * The canvas activity log widget directive.
     *
     * @param {Object} $compile
     */
    .directive('logWidget', ['$templateCache','staticUri', 'widgetService',
        function($templateCache,staticUri,widgetService) {
            controller.$inject = ['$scope', '$element', '$attrs'];
            return {
                restrict: 'ACE',
                link: link,
                controller: controller,
                scope: true,
                require: '^canvas',
                template: function (argument) {
                    return $templateCache.get(staticUri.templateUrl.logWidget);
                }
            };

            function controller($scope, $element, $attrs ) {

                $scope.activities = [];

                $scope.$on('widget-message', function(event, message) {

                    //if (($scope.widget.recv_mask & message.send_mask) !== 0) {

                        $scope.activities.push(message);
                        /*
                        var exists = _.findIndex($scope.activities, function (activity) {
                            return activity.data.id === message.id;
                        });
                        if(exists ===-1) {
                            $scope.activities.push(message);
                        } else {
                            $scope.activities.splice(exists, 0, message);
                        }
                        */
                    //}
                });

            }

            function link(scope, $el, attrs, controllers) {

            }
        }
    ])

    /**
     * The file upload widget directive.
     *
     * @param {Object} $compile
     */
    .directive('uploadWidget', ['$templateCache','$sce','staticUri','$timeout','$location','$rootScope','Upload','datacontext','common',
        function($templateCache, $sce, staticUri,$timeout,$location,$rootScope, Upload,datacontext,common) {
            controller.$inject = ['$scope', '$element', '$attrs', '$transclude', '$http'];
            return {
                restrict: 'ACE',
                template: function (argument) {
                    return $templateCache.get(staticUri.templateUrl.uploadWidget);
                },
                controller: controller,
                link: link,
                scope: true,
                transclude: true,
                replace: false
            };

            function controller($scope, $element, $attrs, $transclude, $http ) {
                $scope.getFilextensions = function() {
                    return $http.get('/generic/file_extensions/' , {}
                    );
                };
                $scope.getFilextensions()
                  .then(function (data) {
                      $scope.allowTypes = data.data.join();
                      console.log($scope.allowTypes);
                  });

                $scope.files   = [];
                $scope.filesUpload   = [];
                $scope.uploadProgress = false;
                $scope.uploadButtonText = 'Upload File';
                //$scope.allowTypes = '.doc,.docx,.docm,.dotx,.dotm,.xls,.xlsx,.xlsm,.xltx,.xltm,.xlsb,.xlam,.csv,.ppt,.pptx,.pptm,.potx,.ppam,.ppsx,.ppsm,.ade,.adp,.accdb,.accde,.accdt,.accdr,.pdf,.psd,.jpg,.jpeg,.gif,.png,.xml,.txt,.vcf,.icl,.ical,.html,.htm,.rtf,.pages,.numbers,.key,.odt,.ods,.odb,.odp,.odg,.odf,.mp4,.mp3,.bmp';
                $scope.dragClass = 'dragover'; //{accept:'dragover', reject:'dragover-err', pattern:'image/*,audio/*,video/*,text/*'}
                $scope.$watch('filesUpload', function (files) {
                    $scope.formUpload = false;
                    if (files !== null) {
                        for (var i = 0; i < files.length; i++) {
                            $scope.errorMsg = null;
                            (function (file) {
                               if(!file.result){ upload(file);}
                            })(files[i]);
                        }
                    }
                });

                if(angular.isDefined($scope.response) && angular.isDefined($scope.response.response_url) && $scope.response.response_url.length>0 ){
                    var file = {};
                    file.name  = common.getFileNameFromUrl($scope.response.response_url);
                    file.savedname = file.name;
                    file.progress= 100;
                    file.result = {url: $scope.response.response_url , filename: file.name };
                    $scope.filesUpload.push(file);
                }

                $scope.getUrl =function (relativeUrl){
                    if($location.absUrl().indexOf(':' + $location.port())!==-1){ 
                        return $location.protocol() + '://'+ $location.host() +':'+  $location.port()  +'' + relativeUrl;
                    }
                    return $location.protocol() + '://'+ $location.host() +'' + relativeUrl;
                };

                $scope.remove =function (file){
                    var index = $scope.filesUpload.indexOf(file);
                    if (index > -1) {
                        $scope.filesUpload.splice(index, 1);
                        var response = {url: '' , filename: '' };
                        $scope.save(response);
                    }
                };


                $scope.abort =function (file){
                    file.result = 'Aborted';
                };

                $scope.save = function (response){
                     var message =  {'message': {'canvas_set_id': $scope.widget.canvas_set_id,
                                                'app_type': $scope.widget.app_type,
                                                'canvas_app_id': $scope.appWidget.canvas_app_id,
                                                'widget_id': $scope.content.widget_id,
                                                'widget_content_id': $scope.responseMarker.widget_content_id,
                                                'response_marker_id': $scope.responseMarker.id,
                                                'ordinal':  $scope.responseMarker.ordinal,
                                                'response': response}};

                            if(angular.isObject($scope.response) && $scope.response.hasOwnProperty('id')){ // && $scope.response.id){
                                message.message.id= $scope.response.id;
                            }

                            //Loggin Disabled
                            
                            try {
                                var log = getlog();
                                log.action = 'Save Work: Before Post';
                                log.transactionId  = transactionId;
                                log.data = message;
                                if(angular.isObject($scope.response)){
                                    log.data.ui_response_object = $scope.response;
                                } else {
                                    log.data.ui_response_object = '';
                                }   
                                //datacontext.logJson(log);
                                logger(log.action, log);
                            } catch(err) {
                                //ignore error just logging code.
                            }
                            

                            //$scope.$emit('widget-acivity', message);
                            
                            $rootScope.savedNotification = true;
                            $rootScope.notSavedNotification = false;
                            datacontext.postPresentation(message, $rootScope.user_id2).then(function (data) {
                            
                                if(data.hasOwnProperty('id')) {

                                    if(angular.isObject($scope.response)){
                                        $scope.response.id = data.id;
                                    } else {
                                        $scope.response = {};
                                        $scope.response.id = data.id;
                                    }
                                   

                                    //Loggin Disabled
                                    
                                    try {
                                        log.action = 'Save Work: Post Success';
                                        log.data =  { 'api_response' : data , 'new_id' : $scope.response.id } ;

                                        if(angular.isObject($scope.response)){
                                            log.data.ui_response_object = $scope.response;
                                        } else {
                                            log.data.ui_response_object = '';
                                        }   
                                        //datacontext.logJson(log);
                                        logger(log.action, log);
                                    } catch(err) {
                                        //ignore error just logging code.
                                    }
                                    

                                    $rootScope.notSavedNotification = false;

                                    var msgDuration = 2000;
                                 
                                
                                    $scope.msgTimer = $timeout(function () {
                                      $rootScope.savedNotification = false;
                                      $rootScope.saveSuccessNotification = true;
                                    },msgDuration);

                                   // if( messageHtml == $scope.ngModel) { 
                                        //Do't disable this if content changed in between getting response!
                                    //    $scope.isSaveWorkRequestPending = false;
                                    //}

                                    $scope.isSavingWork = false;
                                    //var netState = {status: true};
                                    //$rootScope.$broadcast('net-status-changed', netState);

                                } else {    
                                    $rootScope.savedNotification = false;
                                    $rootScope.notSavedNotification = true;
                                    $scope.isSaveWorkRequestPending = true;
                                    $rootScope.saveSuccessNotification = false;

                                    $scope.isSavingWork = false;
                                    //var netState = {status: false};
                                    //$rootScope.$broadcast('net-status-changed', netState);

                                    //Loggin
                                    try {
                                        log.action = 'Save Work: Post Failed';
                                        var id = null;
                                        if(angular.isObject($scope.response)){
                                            if($scope.response.hasOwnProperty('id')) {
                                                id = $scope.response.id;
                                            }
                                        }
                                        log.data = { 'error_data' : data , 'id' : id, message: message  } ;

                                        //$scope.failedSaves.push(angular.copy(log));

                                        //datacontext.logJson(log);
                                        logger(log.action, log);
                                    } catch(err) {
                                        //ignore error just logging code.
                                    }
                                    
                                }

                            });
                };

                $scope.setProgress = function(progress) {
                       $scope.uploadProgress = progress;
                       $scope.uploadButtonText = progress ?"Uploading please wait" : "Upload File" ;
                };

                $scope.validateType = function(file) {
                    var ext = file.name.substr(file.name.lastIndexOf('.'));
                     if($scope.allowTypes.toLowerCase().indexOf(ext.toLowerCase())===-1)
                     { 
                        alert('Unable to upload. Unsupported file type.');
                        return false;
                     }
                     return true;
                };

                function upload(file) {
                    file.savedname = file.name;
                 
                    $scope.setProgress(true);
                    file.upload = Upload.upload({
                        url: staticUri.routeUri.uploadUri, // + '' + $scope.user.user_id + '/',
                        method: 'POST',
                       /* headers: {
                            'my-header': 'my-header-value'
                        },
                        fields: {user_id: $scope.user.user_id},*/
                        file: file,
                        fileFormDataName: 'file'
                    });

                    file.upload.then(function (response) {
                        $timeout(function () {

                            if(angular.isDefined(response)){
                                file.result = response.data;
                                file.savedname = common.getFileNameFromUrl( file.result.url); 
                            }
                            
                            $scope.setProgress(false);
                            

                            var fileinfo = {url: file.result.url , filename: file.savedname };
                            $scope.save(fileinfo);
                           
                        });
                    }, function (response) {
                        if (response.status > 0)
                             file.result = response.status + ': ' + response.data;
                        $scope.errorMsg = 'failed to upload. Please click the red "X" icon to the left and try again, or contact your staff member with the full name of the file to get help.';


                        $scope.setProgress(false);
                    });

                    file.upload.progress(function (evt) {
                        // Math.min is to fix IE which reports 200% sometimes
                        file.progress = Math.min(100, parseInt(100.0 * evt.loaded / evt.total));
                    });

                    file.upload.xhr(function (xhr) {
                        // xhr.upload.addEventListener('abort', function(){console.log('abort complete')}, false);
                    });
                }
            }

            function link(scope, $el, attrs, controllers) {
            }
        }
    ])

    /**
     * The html directive.
     *
     * @param {Object} $compile
     */
    .directive('responseHtmlWidget', ['$templateCache', '$sce','staticUri','widgetService','messageConstant','common',
        function($templateCache, $sce, staticUri, widgetService,messageConstant,common) {
            controller.$inject = ['$scope', '$element', '$attrs', '$transclude'];
            return {
                restrict: 'ACE',
                link: link,
                controller: controller,
                transclude: true,
                replace: false,
                template: function (argument) {
                    return $templateCache.get(staticUri.templateUrl.responseHtml);
                }
            };

            function controller($scope, $element, $attrs, $transclude ) {

                $scope.html = $scope.response.response_html && $scope.response.response_html.length>0 ? $sce.trustAsHtml($scope.response.response_html) : '';
                $scope.url = '';
                if($scope.response.response_url && $scope.response.response_url.length>0) { 
                    $scope.url = common.getUrl($scope.response.response_url); 
                    $scope.filename = common.getFileNameFromUrl($scope.url); 
                }
                $scope.isHtml = $scope.url.length > 0 ? false : true;

                $scope.videoStateChange = function(state, currentTime){
                    if(!currentTime) {currentTime = 0;}

                    var message =   widgetService.createMessage(
                                    {'flow':messageConstant.flow.WIDGET_BACKEND,
                                    'type':messageConstant.type.MESSAGE,
                                    'status':state,
                                    'timestamp_ms':widgetService.getTimestamp(),
                                    'send_mask':$scope.widget.send_mask, 
                                    'recv_mask':0
                                    },{'message':{'canvas_set_id': $scope.widget.canvas_set_id,
                                    'app_type': $scope.widget.app_type,
                                    'canvas_app_id': $scope.appWidget.canvas_app_id,
                                    'widget_id': $scope.content.widget_id,
                                    'widget_content_id': $scope.content.id,
                                    'response_marker_id': $scope.responseMarker.id,
                                    'response_id': $scope.response.id,
                                    'currentTime' : currentTime}});
                   
                    /*
                    datacontext.postPresentation(message, $rootScope.user_id2).then(function (data) {
                        console.log(data);
                    });*/
                    $scope.$broadcast('widget-activity', message);
                    
                };


            }

            function link(scope, $el, attrs, controllers) {
                window.loadIframeObject();
            }
        }
    ])

    
    .directive('responseMarkerHtmlWidget', ['$sce','imEmbedService','widgetService','messageConstant','taApplyCustomRenderers', 'datacontext','$templateCache','staticUri', 'textAngularManager', '$document', 'toastr','$rootScope','$timeout', 'common', function($sce,imEmbedService,widgetService,messageConstant,taApplyCustomRenderers,datacontext,$templateCache,staticUri, textAngularManager, $document, toastr, $rootScope, $timeout, common) {
        controller.$inject = ['$scope', '$element'];
        return {
            restrict: 'ACE', // only activate on element attribute
            require: '?ngModel', // get a hold of NgModelController
            template: function (argument) {
                return $templateCache.get(staticUri.templateUrl.responseMarkerHtml);
            },
            controller: controller,
            link: link,
            scope: true,
            transclude: true,
            replace: false,
        };
        
        function controller($scope, $element) {
            $rootScope.savedNotification = false;
            $scope.previewData = {
                                    html: '',
                                    text: '',
                                    words: 0,
                                    chars: 0
                                };
            $scope.richtextContent = {
                html: '',
                text: '',
                words: 0,
                chars: 0
            };

            
            $scope.failedSaves = [];
            $scope.error = '';
            $scope.prompt = $scope.responseMarker.prompt ? $scope.responseMarker.prompt : '';
            $scope.isSavingWork = false;
            $scope.isSaveWorkRequestPending = false;
            $rootScope.saveSuccessNotification = false;

            $scope.submit = function() {

                if($scope.validateInput()){ 
                    
                    var newTransactionId = (new Date()).getTime();
                    $scope.saveWork(newTransactionId);

                    initRichtextContent();

                    $scope.ngModel = '';
                    $scope.previewData.html =  $scope.ngModel;
                }
            };

            $scope.saveWork =function(transactionId){

                var logger = common.logger.getLogFn('saveWork');
                var log = getlog();
                if($scope.isSavingWork === false) {

                    $scope.isSavingWork = true;
                    
                    try {
                        $scope.validateInput();
                    } catch(err) {
                        //ignore error as validation is not used.
                    }

                    var messageHtml = $scope.ngModel;
                    if(messageHtml) { $scope.previewData.html = taApplyCustomRenderers(imEmbedService.process(messageHtml)); }

                    var message =  {'message': {'canvas_set_id': $scope.widget.canvas_set_id,
                                        'app_type': $scope.widget.app_type,
                                        'canvas_app_id': $scope.appWidget.canvas_app_id,
                                        'widget_id': $scope.content.widget_id,
                                        'widget_content_id': $scope.responseMarker.widget_content_id,
                                        'response_marker_id': $scope.responseMarker.id,
                                        'ordinal':  $scope.responseMarker.ordinal,
                                        'response': $scope.previewData}};

                    if(angular.isObject($scope.response) && $scope.response.hasOwnProperty('id')){ // && $scope.response.id){
                        message.message.id= $scope.response.id;
                    }

                    //Loggin Disabled
                    
                    try {
                        
                        log.action = 'Save Work: Before Post';
                        log.transactionId  = transactionId;
                        log.data = message;
                        if(angular.isObject($scope.response)){
                            log.data.ui_response_object = $scope.response;
                        } else {
                            log.data.ui_response_object = '';
                        }   
                        //datacontext.logJson(log);
                        logger(log.action, log);
                    } catch(err) {
                        //ignore error just logging code.
                    }
                    

                    //$scope.$emit('widget-acivity', message);
                    
                    $rootScope.savedNotification = true;
                    $rootScope.notSavedNotification = false;
                    datacontext.postPresentation(message, $rootScope.user_id2).then(function (data) {
                        
                        if(data.hasOwnProperty('id')) {

                            if(angular.isObject($scope.response)){
                                $scope.response.id = data.id;
                            } else {
                                $scope.response = {};
                                $scope.response.id = data.id;
                            }
                           

                            //Loggin Disabled
                            
                            try {
                                log.action = 'Save Work: Post Success';
                                log.data =  { 'api_response' : data , 'new_id' : $scope.response.id } ;

                                if(angular.isObject($scope.response)){
                                    log.data.ui_response_object = $scope.response;
                                } else {
                                    log.data.ui_response_object = '';
                                }   
                                //datacontext.logJson(log);
                                logger(log.action, log);
                            } catch(err) {
                                //ignore error just logging code.
                            }
                            

                            $rootScope.notSavedNotification = false;

                            var msgDuration = 2000;
                         
                        
                            $scope.msgTimer = $timeout(function () {
                              $rootScope.savedNotification = false;
                              $rootScope.saveSuccessNotification = true;
                            },msgDuration);

                            if( messageHtml == $scope.ngModel) { 
                                //Do't disable this if content changed in between getting response!
                                $scope.isSaveWorkRequestPending = false;
                            }

                            $scope.isSavingWork = false;
                            var netStateTrue = {status: true};
                            $rootScope.$broadcast('net-status-changed', netStateTrue);

                        } else {    
                            $rootScope.savedNotification = false;
                            $rootScope.notSavedNotification = true;
                            $scope.isSaveWorkRequestPending = true;
                            $rootScope.saveSuccessNotification = false;

                            $scope.isSavingWork = false;
                            var netStateFalse = {status: false};
                            $rootScope.$broadcast('net-status-changed', netStateFalse);

                            //Loggin
                            try {
                                log.action = 'Save Work: Post Failed';
                                var id = null;
                                if(angular.isObject($scope.response)){
                                    if($scope.response.hasOwnProperty('id')) {
                                        id = $scope.response.id;
                                    }
                                }
                                log.data = { 'error_data' : data , 'id' : id, message: message  } ;

                                //$scope.failedSaves.push(angular.copy(log));

                                //datacontext.logJson(log);
                                logger(log.action, log);
                            } catch(err) {
                                //ignore error just logging code.
                            }
                            
                        }
                        

                        
                        
                        // Immediately handle any pending saves, not using this as its handled on finish click
                        /* 
                        if($scope.isSaveWorkRequestPending === true){
                            console.log("Executing Save Work Pending");
                            $scope.isSaveWorkRequestPending = false;
                            var newTransactionId = (new Date()).getTime();
                            $scope.saveWork(newTransactionId);
                        }
                        */

                    });
                } else {
                    
                    //Loggin Disabled
                    
                    try {

                        log.action = 'Save Work: Pending as post is in progress!';
                        log.transactionId  = transactionId;
                        //datacontext.logJson(log);
                        logger(log.action, log);
                    } catch(err) {
                        //ignore error just logging code.
                    }
                    
                    $scope.isSaveWorkRequestPending = true; 
                }
            };


            $scope.preview = function() {
               $scope.previewData.html =  taApplyCustomRenderers(imEmbedService.process($scope.ngModel));
            };

            $scope.$on('save-work', function(event, message) {
                if($scope.isSaveWorkRequestPending && $scope.isSavingWork === false) {

                    //Loggin  Disabled
                    var newTransactionId = (new Date()).getTime();
                    /*
                    try {
                        var log = getlog();
                        log.action = 'Call Save: Finish click - pending save!';
                        log.transactionId  = newTransactionId;
                        datacontext.logJson(log);
                    } catch(err) {
                        //ignore error just logging code.
                    }
                    */

                    $scope.saveWork(newTransactionId); //$scope.submit();
                }
            });

            $scope.validateInput = function (){
                var  wordcount = 0;
                $scope.error = '';

                var textAngularElement =  angular.element($element[0]).find("div[text-angular]");
                if(textAngularElement[0]){
                    var textAngularName = textAngularElement[0].attributes['name'].value;
                    var  textAngularEditor = textAngularManager.retrieveEditor(textAngularName);

                    if(textAngularEditor) { 
                        var textElement = textAngularEditor.scope.displayElements.text;
                        var textElementZero = angular.element(textElement[0]);
                        $scope.previewData.text = textElementZero.text(); //textElement[0].innerText || textElement[0].textContent; // to cover the non-jquery use case.      
                    }else {
                        //Edge case work around, needed when finish is clicked before POST is initiated. 
                        if($scope.ngModel) {
                            $scope.previewData.html =  taApplyCustomRenderers(imEmbedService.process($scope.ngModel));
                            var textElement1 = angular.element($scope.previewData.html);
                            if(textElement1.length>1){
                                textElement1 =  angular.element("<div></div>").append(textElement1);
                            }
                            
                            var textElement1Zero = angular.element(textElement1[0]);
                            $scope.previewData.text = textElement1Zero.text(); //textElement1[0].innerText || textElement1[0].textContent; // to cover the non-jquery use case.      
                        }
                    }

                  
                    $scope.previewData.chars = $scope.previewData.text.replace(/(\r\n|\n|\r)/gm,"").replace(/^\s+/g,' ').replace(/\s+$/g, ' ').length;

                    if ($scope.previewData.chars > 0 && $scope.previewData.text.trim() !== '') {
                        try {
                            var textonly = $scope.previewData.text.replace(/(\r\n|\n|\r)/gm," ");
                            textonly = textonly.replace(/^\s+/g,' ');
                            textonly = textonly.replace(/\s+/ig, ' '); // condense spacing
                            textonly = textonly.match(/\S+/g);
                            wordcount = textonly.length; // count remaining non-space strings
                        }
                        catch(err) {}    
                    }

                    $scope.previewData.words = wordcount;
                    if($scope.responseMarker.min_words && wordcount< $scope.responseMarker.min_words) {
                        $scope.error = $scope.error + 'Must write at least ' + $scope.responseMarker.min_words + ' words. You have written ' + wordcount + ' words.'; 
                    }
                    if($scope.responseMarker.max_words  && wordcount > $scope.responseMarker.max_words) {
                         $scope.error = $scope.error + 'Must write less than ' + $scope.responseMarker.max_words + ' words. You have written ' + wordcount + ' words.';
                    }
                    
                }

                return $scope.error === '' ? true : false;
            } ;
            
            function initRichtextContent() {
                $scope.previewData = {
                                        html: '',
                                        text: '',
                                        words: 0,
                                        chars: 0
                                    };
               
                if($scope.response && $scope.response.response_html)
                { 
                   $scope.ngModel = $scope.response.response_html; 
                }

                $scope.$watch('ngModel', function(newValue, oldValue) {
                  
                    $scope.previewData.html =  taApplyCustomRenderers(imEmbedService.process($scope.ngModel)); 

                    if ( typeof oldValue != 'undefined' && newValue !== oldValue && oldValue.trim() !== newValue.trim()) {
                        if(angular.isObject($scope.saveTimer)) { $timeout.cancel($scope.saveTimer); }
                        
                        $scope.saveTimer = $timeout(
                            function() {
                                var logger = common.logger.getLogFn('Data Changed');
                                logger('User Stopped typing for 2 second.');
                                if($scope.isSavingWork === false) {
                                    logger('Saving Work ...');
                                    //Loggin  Disabled
                                    var newTransactionId = (new Date()).getTime();
                                    
                                    try {
                                        var log = getlog();
                                        log.action = 'Call Save: Text change auto save!';
                                        log.transactionId  = newTransactionId;
                                        logger(log.action, log);
                                        //datacontext.logJson(log);
                                    } catch(err) {
                                        //ignore error just logging code.
                                    }
                                    
                                    if (!angular.isDefined($scope.saveCountDownInterval)) {
                                        $scope.saveWork(newTransactionId); 
                                    }
                                } else {
                                    logger('Save in progress.. Save later');
                                    $scope.isSaveWorkRequestPending = true; 
                                }
                            },
                            2000
                        );

                        $scope.isSaveWorkRequestPending = true; 
                    }

                }, true);

            }

            function getlog(action){
                var log = {'identifier':{
                    'timestamp': (new Date()).getTime(),
                    'datetime': (new Date()).toString(),
                    'user_id': $rootScope.useridnum,
                    'user_role': $rootScope.userrole,
                    'user_persona_id': $rootScope.persona,
                    'canvas_set_id': $scope.widget.canvas_set_id,
                    'app_type': $scope.widget.app_type,
                    'canvas_app_id': $scope.appWidget.canvas_app_id,
                    'widget_id': $scope.content.widget_id,
                    'widget_content_id': $scope.responseMarker.widget_content_id,
                    'response_marker_id': $scope.responseMarker.id,
                    'ordinal':  $scope.responseMarker.ordinal
                },
                //'type' : 'CANVAS DEBUG',
                //'browser' : window.navigator.userAgent,
                //'browser_session_id' : window.sessionStorage.getItem('browser_session_id')
                };

                return log;
            }

            initRichtextContent();
            if($scope.ngModel){
                $scope.richtextContent.html = $scope.ngModel;               
                $scope.previewData.html = $scope.ngModel;
            }


        }

        function link(scope, element, attrs, ngModel) {
            
            scope.orginalValue =  angular.copy(scope.ngModel);
            
            element.bind('focusout', function($event) {
                if(scope.ngModel != scope.orginalValue) {
                    /* Save on lost focus is disabled 
                    if(scope.isSavingWork === false) {

                        //Loggin  Disabled
                        var newTransactionId = (new Date()).getTime();
                        try {
                            var log = getlog();
                            log.action = 'Call Save: Widget lost focus!';
                            log.transactionId  = newTransactionId;
                            datacontext.logJson(log);
                        } catch(err) {
                            //ignore error just logging code.
                        }


                        scope.saveWork(newTransactionId); 
                    } else {
                        scope.isSaveWorkRequestPending = true; 
                    }
                    */
                }
            });

            element.bind('focusin', function($event) {
                  scope.orginalValue  =  angular.copy(scope.ngModel);
            });
            
            function read() {
                var html = element.html();
                // When we clear the content editable the browser leaves a <br> behind
                // If strip-br attribute is provided then we strip this out
                if (attrs.stripBr && html === '<br>') {
                    html = '';
                }
                ngModel.$setViewValue(html);
            }

            if(!ngModel) return; // do nothing if no ng-model

            // Specify how UI should be updated
            ngModel.$render = function() {
                if (ngModel.$viewValue !== element.html()) {
                    element.html($sce.getTrustedHtml(ngModel.$viewValue || ''));
                }
            };

            // Listen for change events to enable binding
            element.on('blur keyup change', function() {
                scope.$apply(read);
            });
            read(); // initialize
        }
    }])


 .directive('reconnectingWriter1', ['$sce','imEmbedService','widgetService','messageConstant','taApplyCustomRenderers', 'datacontext','$templateCache','staticUri', function($sce,imEmbedService,widgetService,messageConstant,taApplyCustomRenderers,datacontext,$templateCache,staticUri) {
        controller.$inject = ['$scope', '$q', '$http', 'datacontext'];
        return {
            restrict: 'ACE', // only activate on element attribute
            require: '?ngModel', // get a hold of NgModelController
            template: function (argument) {
                return $templateCache.get(staticUri.templateUrl.reconnectingWriter);
            },
            controller: controller,
            link: link,
            scope: true,
            //transclude: true,
            //replace: false
        };
        
        function controller($scope, $q, $http, datacontext) {

                $scope.previewData = {
                                        html: '',
                                        text: '',
                                        words: 0,
                                        chars: 0
                                    };
            $scope.submit = function() {
               
                $scope.previewData.html =  taApplyCustomRenderers(imEmbedService.process($scope.ngModel));

                var message =   {'message': {
                                    'canvas_set_id': $scope.widget.canvas_set_id,
                                    'app_type': $scope.widget.app_type,
                                    'canvas_app_id': $scope.widget.id,
                                    'response': $scope.previewData}};

                //$scope.$emit('widget-acivity', message);
               
                datacontext.postReconnecting(message,$rootScope.user_id2).then(function (data) {
                    console.log(data);
                });
                
                initRichtextContent();

                $scope.ngModel = null;
                $scope.previewData.html =  $scope.ngModel;
            };
            
            $scope.save1Work =function(){
                        
                if($scope.ngModel) {$scope.previewData.html =  taApplyCustomRenderers(imEmbedService.process($scope.ngModel)); }
              
                var message =   {'message': {
                                    'canvas_set_id': $scope.widget.canvas_set_id,
                                    'app_type': $scope.widget.app_type,
                                    'canvas_app_id': $scope.widget.id,
                                    'response': $scope.previewData}};
                console.log($scope.previewData);

                //$scope.$emit('widget-acivity', message);
               
                datacontext.postPresentation(message, $rootScope.user_id2).then(function (data) {
                    if($scope.response && data.id){
                        $scope.response.id = data.id;
                    } else if(data.id){
                        $scope.response = {};
                        $scope.response.id = data.id;
                    }

                    var msgDuration = 2000;
                    $rootScope.savedNotification = true;
                    $scope.msgTimer = $timeout(function () {
                      $rootScope.savedNotification = false;
                    },msgDuration);
                });
            };

            $scope.preview = function() {
               $scope.previewData.html =  taApplyCustomRenderers(imEmbedService.process($scope.ngModel));
            };
            
            $scope.$on('save-work', function(event, message) {
                //$scope.submit();
            });
            

            function initRichtextContent() {
                 $scope.previewData = {
                                        html: '',
                                        text: '',
                                        words: 0,
                                        chars: 0
                                    };

               
                $scope.$watch('ngModel', function() {
                     //$scope.previewData.html =  imEmbedService.process($scope.ngModel);
                }, true);
                
            }
            
            initRichtextContent();
              
            $scope.previewData.html = $scope.ngModel;
                
        }

        function link(scope, element, attrs, ngModel) {
            function read() {
                var html = element.html();
                // When we clear the content editable the browser leaves a <br> behind
                // If strip-br attribute is provided then we strip this out
                if (attrs.stripBr && html === '<br>') {
                    html = '';
                }
                ngModel.$setViewValue(html);
            }

            if(!ngModel) return; // do nothing if no ng-model

            // Specify how UI should be updated
            ngModel.$render = function() {
                if (ngModel.$viewValue !== element.html()) {
                    element.html($sce.getTrustedHtml(ngModel.$viewValue || ''));
                }
            };

            // Listen for change events to enable binding
            element.on('blur keyup change', function() {
                scope.$apply(read);
            });
            read(); // initialize
        }
    }])


    /**
     * The reconnecting html directive.
     *
     * @param {Object} $compile
     */
    .directive('reconnectingContent', ['$templateCache', '$sce','staticUri',
        function($templateCache, $sce, staticUri) {
            controller.$inject = ['$scope', '$element', '$attrs', '$transclude'];
            return {
                restrict: 'ACE',
                link: link,
                controller: controller,
                transclude: true,
                replace: false,
                template: function (argument) {
                    return $templateCache.get(staticUri.templateUrl.reconnectingContent);
                }
            };

            function controller($scope, $element, $attrs, $transclude ) {
                $scope.html = $scope.content.html ? $sce.trustAsHtml($scope.content.html) : '';
            }

            function link(scope, $el, attrs, controllers) {
            }
        }
    ])

    /**
     * The video widget directive.
     *
     * @param {Object} $compile
     */
    .directive('videoWidget', ['$templateCache', '$sce','staticUri',
        function($templateCache, $sce, staticUri) {
            controller.$inject = ['$scope', '$element', '$attrs', '$transclude'];
            return {
                restrict: 'ACE',
                link: link,
                controller: controller,
                template: function (argument) {
                    return $templateCache.get(staticUri.templateUrl.contentTypeVideoFile);
                }
            };

            function controller($scope, $element, $attrs, $transclude ) {
                $scope.url = $scope.content.url  && $scope.content.url.length>0 ? $scope.content.url : $scope.content.filename;
 
                $scope.url = $sce.trustAsResourceUrl($scope.url);
                $scope.downloadFile = function (file) {
                    var fileUrl = $sce.getTrustedUrl(file);//scope.$eval(file);
                    downloadFile(fileUrl);
                };
            }

            function link(scope, $el, attrs, controllers) {
            }
        }
    ])

    /**
     * The audio widget directive.
     *
     * @param {Object} $compile
     */
    .directive('audioWidget', ['$templateCache', '$sce','staticUri',
     function($templateCache, $sce, staticUri) {
            controller.$inject = ['$scope', '$element', '$attrs', '$transclude'];
            return {
                restrict: 'ACE',
                link: link,
                controller: controller,
                template: function (argument) {
                    return $templateCache.get(staticUri.templateUrl.contentTypeAudioFile);
                }
            };

            function controller($scope, $element, $attrs, $transclude ) {
                $scope.url = $scope.content.url && $scope.content.url.length>0 ? $scope.content.url : $scope.content.filename;
 
                $scope.url = $sce.trustAsResourceUrl($scope.url);
                $scope.downloadFile = function (file) {
                    var fileUrl = $sce.getTrustedUrl(file);//scope.$eval(file);
                    downloadFile(fileUrl);
                };
            }

            function link(scope, $el, attrs, controllers) {
            }
        }
    ])

    /**
     * The image widget directive.
     *
     * @param {Object} $compile
     */
    .directive('imageWidget',  ['$templateCache', '$sce','staticUri',
     function($templateCache, $sce, staticUri) {
            controller.$inject = ['$scope', '$element', '$attrs', '$transclude'];
            return {
                restrict: 'ACE',
                link: link,
                controller: controller,
                template: function (argument) {
                    return $templateCache.get(staticUri.templateUrl.contentTypeImageFile);
                }
            };

            function controller($scope, $element, $attrs, $transclude ) {

                $scope.isFullscreen = false;

                $scope.toggleFullScreen = function() {
                    $scope.isFullscreen = !$scope.isFullscreen;
                };
    
                $scope.url = $scope.content.url  && $scope.content.url.length>0 ? $scope.content.url : $scope.content.filename;
 
                $scope.url = $sce.trustAsResourceUrl($scope.url);
                $scope.downloadFile = function (file) {
                    var fileUrl = $sce.getTrustedUrl(file);//scope.$eval(file);
                    downloadFile(fileUrl);
                };
            }

            function link(scope, $el, attrs, controllers) {
            }
        }
    ])

    /**
     * The document widget directive.
     *
     * @param {Object} $compile
     */
    .directive('documentWidget',  ['$templateCache', '$sce','staticUri',' $timeout','labelMessage',
       function($templateCache, $sce, staticUri, $timeout, labelMessage) {
           controller.$inject = ['$scope', '$element', '$attrs', '$transclude'];
            return {
                restrict: 'ACE',
                link: link,
                controller: controller,
                template: function (argument) {
                    return $templateCache.get(staticUri.templateUrl.contentTypeDocumentFile);
                }
            };

            function controller($scope, $element, $attrs, $transclude ) {
                function handleUrlAccessibleCheck(isAccesible) {
                    $scope.notLoaded = !isAccesible;  
                }

                function handleFileExistsCheck(isAccesible) {
                    if(!isAccesible) {
                       console.log('fileExistsCheck failed.');
                        $timeout(function() {
                            var url = $scope.iframeUrl;
                            $scope.iframeUrl = "";
                            $scope.iframeUrl = url;
                            
                        }, 3000);
                    }
                }

                $scope.notLoadedMessage = labelMessage.failedToLoadDoc;
                $scope.url = $scope.content.url  && $scope.content.url.length>0 ? $scope.content.url : $scope.content.filename;
 
                $scope.url = $sce.trustAsResourceUrl($scope.url);
                $scope.downloadFile = function (file) {
                    var fileUrl = $sce.getTrustedUrl(file);//scope.$eval(file);
                    downloadFile(fileUrl);
                };

                $scope.iframeUrl = $sce.trustAsResourceUrl('https://view.officeapps.live.com/op/embed.aspx?src=' +  $scope.url + '');
                $scope.onlineUrl = $sce.trustAsResourceUrl('https://view.officeapps.live.com/op/view.aspx?src=' +  $scope.url + '');

                fileExistsCheck($scope.url, handleFileExistsCheck);

                $timeout(function() {
                    urlAccessibleCheck('live.com', handleUrlAccessibleCheck);
                }, 1000);
           }

            function link(scope, $el, attrs, controllers) {
            }
        }
    ])

    /**
     * The worksheet widget directive.
     *
     * @param {Object} $compile
     */
    .directive('worksheetWidget', ['$templateCache', '$sce','staticUri',' $timeout','labelMessage',
        function($templateCache, $sce, staticUri, $timeout,labelMessage) {
           controller.$inject = ['$scope', '$element', '$attrs', '$transclude'];
            return {
                restrict: 'ACE',
                link: link,
                controller: controller,
                template: function (argument) {
                    return $templateCache.get(staticUri.templateUrl.contentTypeWorksheetFile);
                }
            };

            function controller($scope, $element, $attrs, $transclude ) {
                function handleUrlAccessibleCheck(isAccesible) {
                    $scope.notLoaded = !isAccesible;  
                }

                function handleFileExistsCheck(isAccesible) {
                    if(!isAccesible) {
                       console.log('fileExistsCheck failed.');
                        $timeout(function() {
                            var url = $scope.iframeUrl;
                            $scope.iframeUrl = "";
                            $scope.iframeUrl = url;
                            
                        }, 3000);
                    }
                }

                $scope.notLoadedMessage = labelMessage.failedToLoadDoc;
                $scope.url = $scope.content.url  && $scope.content.url.length>0 ? $scope.content.url : $scope.content.filename;
 
                $scope.url = $sce.trustAsResourceUrl($scope.url);
                $scope.downloadFile = function (file) {
                    var fileUrl = $sce.getTrustedUrl(file);//scope.$eval(file);
                    downloadFile(fileUrl);
                };

                $scope.iframeUrl = $sce.trustAsResourceUrl('https://view.officeapps.live.com/op/embed.aspx?src=' +  $scope.url + '');
                $scope.onlineUrl = $sce.trustAsResourceUrl('https://view.officeapps.live.com/op/view.aspx?src=' +  $scope.url + '');

                fileExistsCheck($scope.url, handleFileExistsCheck);

                $timeout(function() {
                    urlAccessibleCheck('live.com', handleUrlAccessibleCheck);
                }, 1000);
           }

            function link(scope, $el, attrs, controllers) {
            }
        }
    ])


    /**
     * The pdf widget directive.
     *
     * @param {Object} $compile
     */
    .directive('pdfWidget', ['$templateCache', '$sce','staticUri','$timeout','labelMessage','datacontext',
        function($templateCache,  $sce, staticUri, $timeout, labelMessage,datacontext) {
            controller.$inject = ['$scope', '$element', '$attrs', '$transclude'];
            return {
                restrict: 'ACE',
                link: link,
                controller: controller,
                template: function (argument) {
                    return $templateCache.get(staticUri.templateUrl.contentTypePdfFile);
                }
            };

            function controller($scope, $element, $attrs, $transclude ) {

                var noLoadType = 1;
                var retryCount = 0;
                
                /*var ip = 0;
                if (typeof window.ipAddress != 'undefined')
                {
                   ip = window.ipAddress;
                }*/
                function handleUrlAccessibleCheck(isAccesible, url) {
                    console.log(isAccesible + ' : : ' + url);
                    if(isAccesible === false && retryCount < 2) {
                        retryCount++;
                        $timeout(function() {
                            urlAccessibleCheck('https://docs.google.com/uc?authuser=0&id=0B3_AxqV1Xh-PTU1JdmdnLWtBQU0&export=download', handleUrlAccessibleCheck);
                        }, 500);
                    } else {
                        $scope.notLoaded = !isAccesible;  
                        if($scope.notLoaded === true){
                            datacontext.postNoload({'content_url' : $scope.originalurl, 'content_type_id' : noLoadType, 'product_record_id' : $scope.widget.canvas_set_id, 'product_type_id' : 1});
                        }
                    }
                }

                function handleFileExistsCheck(isAccesible) {
                    if(!isAccesible) {
                       console.log('fileExistsCheck failed.');
                        $timeout(function() {
                            var url = $scope.iframeUrl;
                            $scope.iframeUrl = "";
                            $scope.iframeUrl = url;
                            
                        }, 3000);
                    }
                }

                $scope.notLoadedMessage = labelMessage.failedToLoadDoc;
                $scope.url = $scope.content.url  && $scope.content.url.length>0 ? $scope.content.url : $scope.content.filename;
                $scope.originalurl = $scope.url;
                $scope.url = $sce.trustAsResourceUrl($scope.url);
                $scope.downloadFile = function (file) {
                    var fileUrl = $sce.getTrustedUrl(file);//scope.$eval(file);
                    downloadFile(fileUrl);
                };

                $scope.iframeUrl = $sce.trustAsResourceUrl('https://docs.google.com/viewer?url=' +  $scope.url + '&embedded=true');
                $scope.onlineUrl = $sce.trustAsResourceUrl('https://docs.google.com/viewer?url=' +  $scope.url + '');

                fileExistsCheck($scope.url, handleFileExistsCheck);

                $timeout(function() {
                    urlAccessibleCheck('https://docs.google.com/uc?authuser=0&id=0B3_AxqV1Xh-PTU1JdmdnLWtBQU0&export=download', handleUrlAccessibleCheck);
                }, 1000);

            }

            function link(scope, $el, attrs, controllers) {
            }
        }
    ])

    /**
     * The pages widget directive.
     *
     * @param {Object} $compile
     */
    .directive('pagesWidget', ['$templateCache', '$sce','staticUri',
        function($templateCache,  $sce, staticUri) {
           controller.$inject = ['$scope', '$element', '$attrs', '$transclude'];
            return {
                restrict: 'ACE',
                link: link,
                controller: controller,
                template: function (argument) {
                    return $templateCache.get(staticUri.templateUrl.contentTypePagesFile);
                }
            };

            function controller($scope, $element, $attrs, $transclude ) {
                $scope.url = $scope.content.url  && $scope.content.url.length>0 ? $scope.content.url : $scope.content.filename;
 
                $scope.url = $sce.trustAsResourceUrl($scope.url);
                $scope.downloadFile = function (file) {
                    var fileUrl = $sce.getTrustedUrl(file);//scope.$eval(file);
                    downloadFile(fileUrl);
                };

                $scope.iframeUrl = $sce.trustAsResourceUrl('https://docs.google.com/viewer?url=' +  $scope.url + '&embedded=true');
                $scope.onlineUrl = $sce.trustAsResourceUrl('https://docs.google.com/viewer?url=' +  $scope.url + '');
           }

            function link(scope, $el, attrs, controllers) {
            }
        }
    ])

    /**
     * The pages iframe directive.
     *
     * @param {Object} $compile
     */
    .directive('iframeWidget', ['$templateCache', '$sce','staticUri',' $timeout','labelMessage','datacontext',
        function($templateCache, $sce, staticUri, $timeout, labelMessage, datacontext) {
            controller.$inject = ['$scope', '$element', '$attrs', '$transclude'];
            return {
                restrict: 'ACE',
                link: link,
                controller: controller,
                template: function (argument) {
                    return $templateCache.get(staticUri.templateUrl.contentTypeIframe);
                }
            };

            function controller($scope, $element, $attrs, $transclude ) {

                var retryCount = 0;
                function handleUrlAccessibleCheck(isAccesible, url) {
                    console.log(isAccesible + ' : : ' + url);
                    if(isAccesible === false && retryCount < 2) {
                        retryCount++;
                        urlAccessibleCheck(url, handleUrlAccessibleCheck);
                    } else {
                        $scope.notLoaded = !isAccesible;
                        if($scope.notLoaded === false){
                            datacontext.postNoload({'content_url' : url, 'content_type_id' : noLoadType, 'product_record_id' : $scope.widget.canvas_set_id, 'product_type_id' : 1});
                        }
                    }
                }

                function handleFileExistsCheck(isAccesible) {
                    if(!isAccesible) {
                        console.log('fileExistsCheck failed.');
                        var pageIframeElement = $element.find('iframe');
                        var url = $scope.iframeUrl;
                        pageIframeElement[0].src = url;
                    }
                }

                $scope.notLoadedMessage = labelMessage.failedToLoadDoc;
                var iframe = decodeURI($scope.content.html);
                if (iframe.indexOf('<iframe')===0) {
                    var element = angular.element('<div>' + $scope.content.html + '</div>');
                    var iframeElement = element.find('iframe');
                    if (iframeElement.length>0) {
                        $scope.iframeUrl = iframeElement[0].src; 
                        if ($scope.iframeUrl.indexOf('/presentation/')===-1) {
                              fileExistsCheck($scope.iframeUrl, handleFileExistsCheck);
                        }

                        /*$timeout(function() {
                            urlAccessibleCheck($scope.iframeUrl, handleUrlAccessibleCheck);
                        }, 1000)*/
                    }     
                    $scope.iframe = iframe;
                }
            }

            function link(scope, $el, attrs, controllers) {
            }
        }
    ])

    /**
     * The link directive.
     *
     * @param {Object} $compile
     */
    .directive('linkWidget', ['$templateCache','$sce','staticUri',
        function($templateCache, $sce, staticUri) {
            controller.$inject = ['$scope', '$element', '$attrs', '$transclude'];
            return {
                restrict: 'ACE',
                template: function (argument) {
                    return $templateCache.get(staticUri.templateUrl.contentTypeLink);
                },
                controller: controller,
                link: link,
                scope: true,
                transclude: true,
                replace: false
            };

            function controller($scope, $element, $attrs, $transclude ) {
                $scope.url = $scope.content.url  && $scope.content.url.length>0 ? $scope.content.url : $scope.content.filename;
                $scope.url = $sce.trustAsResourceUrl($scope.url);
            }

            function link(scope, $el, attrs, controllers) {
            }
        }
    ])

    /**
     * The site directive.
     *
     * @param {Object} $compile
     */
    .directive('siteWidget', ['$templateCache','$sce','staticUri',
        function($templateCache, $sce, staticUri) {
            controller.$inject = ['$scope', '$element', '$attrs', '$transclude'];
            return {
                restrict: 'ACE',
                link: link,
                controller: controller,
                template: function (argument) {
                    return $templateCache.get(staticUri.templateUrl.contentTypeSite);
                }
            };

            function controller($scope, $element, $attrs, $transclude ) {
                $scope.url = $scope.content.url  && $scope.content.url.length>0 ? $scope.content.url : $scope.content.filename;
                $scope.url = $sce.trustAsResourceUrl($scope.url);
            }

            function link(scope, $el, attrs, controllers) {
            }
        }
    ])


    /**
     * The html directive.
     *
     * @param {Object} $compile
     */
    .directive('htmlWidget', ['$templateCache', '$sce','staticUri','widgetService','messageConstant','$timeout','labelMessage','datacontext',
        function($templateCache, $sce, staticUri, widgetService,messageConstant, $timeout, labelMessage, datacontext) {
            controller.$inject = ['$scope', '$element', '$attrs', '$transclude'];
            return {
                restrict: 'ACE',
                link: link,
                controller: controller,
                transclude: true,
                replace: false,
                template: function (argument) {
                    return $templateCache.get(staticUri.templateUrl.contentTypeHtml);
                }
            };

            function controller($scope, $element, $attrs, $transclude ) {

                var noLoadType = 0;
                var retryCount = 0;
                /*var ip = 0;
                if (typeof window.ipAddress != 'undefined')
                {
                   ip = window.ipAddress;
                }*/

                function handleUrlAccessibleCheck(isAccesible, url) {
                    console.log(isAccesible + ' : : ' + url);
                    
                    if(isAccesible === false && retryCount < 2) {
                        retryCount++;
                        $timeout(function() {
                            urlAccessibleCheck(url, handleUrlAccessibleCheck);
                        }, 500);
                    } else {
                        $scope.notLoaded = !isAccesible;
                        if($scope.notLoaded === true){
                            datacontext.postNoload({'content_url' : $scope.iframeUrl, 'content_type_id' : noLoadType, 'product_record_id' : $scope.widget.canvas_set_id, 'product_type_id' : 1});
                        }
                    }
                }

                function handleFileExistsCheck(isAccesible) {
                    if(!isAccesible) {
                        console.log('fileExistsCheck failed.');
                        var pageIframeElement = $element.find('iframe');
                        var url = $scope.iframeUrl;
                        pageIframeElement[0].src = url;
                    }
                }
                $scope.useMobileFriendly = false;
                $scope.html = $scope.content.html ? $sce.trustAsHtml($scope.content.html) : '';
                $scope.mobileHtml = $scope.html;
                $scope.notLoadedMessage = labelMessage.failedToLoadDoc;

                if($scope.content.html) {
                    var element = angular.element('<div>' + $scope.content.html + '</div>');
                    var iframeElement = element.find('iframe');
                    if (iframeElement.length>0) {
                        $scope.iframeUrl = angular.isDefined($scope.content.url) ? $scope.content.url : iframeElement[0].src; 
                    }
                }
                
                if($scope.content.html && $scope.content.html.indexOf('Google content')>0) {
                    var element = angular.element('<div>' + $scope.content.html + '</div>');
                    var iframeElement = element.find('iframe');
                    if (iframeElement.length>0) {
                        
                        $scope.iframeUrl = angular.isDefined($scope.content.url) ? $scope.content.url : iframeElement[0].src; 
                        $scope.mobileHtml = "This content is available <a href='" +  $scope.iframeUrl + "' target='_blank'>here</a> on mobile devices.";
                        if(isMobile.phone) {
                            $scope.useMobileFriendly = true;
                        }
                        if ($scope.iframeUrl.indexOf('/presentation/')===-1) {
                            fileExistsCheck($scope.iframeUrl, handleFileExistsCheck);
                            noLoadType = 1;
                        }

                        $timeout(function() {
                            urlAccessibleCheck('https://docs.google.com/uc?authuser=0&id=0B3_AxqV1Xh-PTU1JdmdnLWtBQU0&export=download', handleUrlAccessibleCheck);
                            noLoadType = 1;
                        }, 1000);


                    }
                } else if($scope.content.html && $scope.content.html.indexOf('YouTube content')>0) {
                    console.log('https://youtube.com');
                    $timeout(function() {
                        noLoadType = 3;
                       urlAccessibleCheck('https://www.youtube.com/player_api', handleUrlAccessibleCheck);
                    }, 1000);
                } else if($scope.content.html && $scope.content.html.indexOf('Vimeo content')>0) {
                    console.log('https://vimeo.com');
                    $timeout(function() {
                        noLoadType = 2;
                        urlAccessibleCheck('https://f.vimeocdn.com/js/froogaloop2.min.js', handleUrlAccessibleCheck);
                    }, 1000);
                } else if($scope.content.html && $scope.content.html.indexOf('SoundCloud content')>0) {
                    console.log('https://SoundCloud.com');
                    $timeout(function() {
                        noLoadType = 4;
                        urlAccessibleCheck('https://connect.soundcloud.com/sdk/sdk-3.0.0.js', handleUrlAccessibleCheck);
                    }, 1000);
                }
                /*else if($scope.content.html && $scope.content.html.indexOf('TED content')>0) {
                    console.log('https://www.ted.com/');
                    $timeout(function() {
                        urlAccessibleCheck('https://www.ted.com/', handleUrlAccessibleCheck);
                    }, 1000)
                } else if($scope.content.html && $scope.content.html.indexOf('Prezi content')>0) {
                    console.log('https://prezi.com/');
                    $timeout(function() {
                        urlAccessibleCheck('https://prezi.com/', handleUrlAccessibleCheck);
                    }, 1000)
                }*/



                $scope.videoStateChange = function(state, currentTime){
                    if(!currentTime) {currentTime = 0;}

                    var message =   widgetService.createMessage(
                                    {'flow':messageConstant.flow.WIDGET_BACKEND,
                                    'type':messageConstant.type.MESSAGE,
                                    'status':state,
                                    'timestamp_ms':widgetService.getTimestamp(),
                                    'send_mask':$scope.widget.send_mask, 
                                    'recv_mask':0
                                    },{'message':{'canvas_set_id': $scope.widget.canvas_set_id,
                                    'app_type': $scope.widget.app_type,
                                    'canvas_app_id': $scope.appWidget.canvas_app_id,
                                    'widget_id': $scope.content.widget_id,
                                    'widget_content_id': $scope.content.id,
                                    'currentTime' : currentTime}});
                   
                    /*
                    datacontext.postPresentation(message, $rootScope.user_id2).then(function (data) {
                        console.log(data);
                    });*/
                    $scope.$broadcast('widget-activity', message);
                    
                };


            }

            function link(scope, $el, attrs, controllers) {
                window.loadIframeObject();
            }
        }
    ])

    /**
     * The text directive.
     *
     * @param {Object} $compile
     */
    .directive('textWidget', ['$templateCache', '$sce','staticUri',
        function($templateCache, $sce, staticUri) {
            controller.$inject = ['$scope', '$element', '$attrs', '$transclude'];
            return {
                restrict: 'ACE',
                link: link,
                controller: controller,
                template: function (argument) {
                    return $templateCache.get(staticUri.templateUrl.contentTypeText);
                }
            };

            function controller($scope, $element, $attrs, $transclude ) {
                $scope.plain_text = $scope.content.plain_text;
            }

            function link(scope, $el, attrs, controllers) {
            }
        }
    ])

        /**
     * The file directive.
     *
     * @param {Object} $compile
     */
    .directive('fileWidget', ['$templateCache', '$compile','$sce','staticUri', 'common',
        function($templateCache, $compile, $sce, staticUri, common) {
            controller.$inject = ['$scope', '$element', '$attrs', '$transclude'];
            return {
                restrict: 'ACE',
                link: link,
                controller: controller,
            };

            function controller($scope, $element, $attrs, $transclude ) {
                $scope.url = $scope.content.url  && $scope.content.url.length>0 ? $scope.content.url : $scope.content.filename;
 
                var url = $scope.url.replace(/#[^#]*$/, "").replace(/\?[^\?]*$/, "");
                var urlPath = url.substring(url.lastIndexOf('/')+1);
                var regex = /(?:\.([^.]+))?$/;
                var ext = regex.exec(urlPath)[1];
                
                url = common.getUrl(url);
                
                var wrapper;
                if(ext && ext.length > 0 && ext!==' '){
                    wrapper = angular.element('<div im-embed data-type="' + ext +'" data-url="' + url + '"></div>');
                } else {
                    wrapper = angular.element('<div im-embed data-url="' + url + '"><a href="' + url + '">' + url + '</a></div>');
                }
                var templateParsed = $compile(wrapper)($scope);
                $element.html(templateParsed);
            }

            function link(scope, $el, attrs, controllers) {
            }
        }
    ])


    /**
     * The soundcloud directive.
     *
     * @param {Object} $compile
     */
    .directive('soundcloudWidget', ['$templateCache', '$sce','staticUri',
        function($templateCache, $sce, staticUri) {
            controller.$inject = ['$scope', '$element', '$attrs', '$transclude'];
            return {
                restrict: 'ACE',
                link: link,
                controller: controller,
                template: function (argument) {
                    return $templateCache.get(staticUri.templateUrl.contentTypeSoundcloud);
                }
            };

            function controller($scope, $element, $attrs, $transclude ) {
                $scope.url = $scope.content.url  && $scope.content.url.length>0 ? $scope.content.url : $scope.content.filename;
 
                var scRegex = /soundcloud.com\/[a-zA-Z0-9-_]+\/[a-zA-Z0-9-_]+/gi;
                var matches = $scope.url.match(scRegex);
                if (matches) {
                    var url = 'https://w.soundcloud.com/player/?url=' + $scope.url + '&auto_play=false&hide_related=true&show_comments=false&show_user=false&show_reposts=false&visual=false&download=false&color=f50000&theme_color=f50000';
                    $scope.url = $sce.trustAsResourceUrl(url);
                }
            }

            function link(scope, $el, attrs, controllers) {
            }
        }
    ])

    /**
     * The google docs directive.
     *
     * @param {Object} $compile
     */
    .directive('googleDocsWidget', ['$templateCache', '$sce','staticUri',
        function($templateCache, $sce, staticUri) {
            controller.$inject = ['$scope', '$element', '$attrs', '$transclude'];
            return {
                restrict: 'ACE',
                link: link,
                controller: controller,
                template: function (argument) {
                    return $templateCache.get(staticUri.templateUrl.contentTypeGoogleDocs);
                }
            };

            function controller($scope, $element, $attrs, $transclude ) {
                $scope.url = $scope.content.url  && $scope.content.url.length>0 ? $scope.content.url : $scope.content.filename;
 
                var scRegex = /docs.google.com\/[a-zA-Z0-9-_]+\/[a-zA-Z0-9-_]+/gi;
                var matches = $scope.url.match(scRegex);
                if (matches) {
                    $scope.url = $sce.trustAsResourceUrl($scope.url);
                }
            }

            function link(scope, $el, attrs, controllers) {
            }
        }
    ])

     /**
     * The presentation widget directive.
     *
     * @param {Object} $compile
     */
    .directive('presentationWidget', ['$templateCache', '$sce','staticUri',' $timeout',
        function($templateCache, $sce, staticUri, $timeout) {
           controller.$inject = ['$scope', '$element', '$attrs', '$transclude'];
            return {
                restrict: 'ACE',
                link: link,
                controller: controller,
                template: function (argument) {
                    return $templateCache.get(staticUri.templateUrl.contentTypePresentationFile);
                }
            };

            function controller($scope, $element, $attrs, $transclude ) {
                $scope.url = $scope.content.url  && $scope.content.url.length>0 ? $scope.content.url : $scope.content.filename;
                $scope.downloadFile = function (file) {
                    var fileUrl = $sce.getTrustedUrl(file);//scope.$eval(file);
                    downloadFile(fileUrl);
                };

                $scope.iframeUrl = $sce.trustAsResourceUrl('https://view.officeapps.live.com/op/embed.aspx?src=' +  $scope.url + '');
                $scope.onlineUrl = $sce.trustAsResourceUrl('https://view.officeapps.live.com/op/view.aspx?src=' +  $scope.url + '');

                if(!fileExistsCheck($scope.onlineUrl)){
                    console.log('fileExistsCheck failed.');
                    $timeout(function() {
                        var url = $scope.iframeUrl;
                        $scope.iframeUrl = "";
                        $scope.iframeUrl = url;
                    }, 3000);
                }
           }

            function link(scope, $el, attrs, controllers) {
            }
        }
    ])
    


    .directive('compile', ['$compile', function ($compile) {
        return function (scope, element, attrs, ctrl, transclude) {
                    scope.$watch(
                        function(scope) {
                            return scope.$eval(attrs.compile);
                        },
                        function(value) {

                         var contents, insertPoint, wrapper;
                            wrapper = angular.element(document.createElement('div'));
                            wrapper.html(value);
                            var elementContent = element.contents();
                            insertPoint = angular.element(wrapper[0].querySelector( "[ng-transclude]" ));

                            if(insertPoint.length) {insertPoint.replaceWith(elementContent.clone()); }
                            contents = wrapper.contents();
                            element.html(contents);
                            $compile(element.contents())(scope);

                            //element.html(value);
                            //$compile(element.contents())(scope);

                        }
                    );
                };
         
    }])
    
     .directive('compileTransclude', ['$compile', function ($compile) {
           return {
                link: function (scope, element, attrs, ctrl, transclude) {
                    scope.$watch(
                        function(scope) {
                            return scope.$eval(attrs.compileTransclude);
                        },
                        function(value) {
                            if(value){
                         var contents, insertPoint, wrapper;
                            wrapper = angular.element(document.createElement('div'));
                            wrapper.html(value);
                            var elementContent = element.contents();
                            insertPoint = angular.element(wrapper[0].querySelector( "[transclude]" ));

                            
                            if(insertPoint.length) {
                                transclude( scope, function( childs, scope) {
                                    insertPoint.replaceWith(childs); 
                                });
                            }

                            // if(insertPoint.length) {insertPoint.replaceWith(elementContent.clone()); }
                            contents = wrapper.contents();
                            element.html(contents);
                            $compile(element.contents())(scope);

                            //element.html(value);
                            //$compile(element.contents())(scope);

                            }
                        }
                    );
                },
                 restrict: 'ACE',
                transclude: true,
                replace: false,
                scope:true
            };
    }])

    .directive('includeTransclude', ['$http', '$templateCache', '$compile', '$sce', function($http, $templateCache, $compile, $sce) {
      return {
        link: function(scope, el, attr) {
          var url = $sce.parseAsResourceUrl(attr.includeTransclude)();
          $http.get(url, {cache: $templateCache})
               .success(function(response) {
                 var contents, insertPoint, wrapper;
                 wrapper = angular.element(document.createElement('div'));
                 wrapper.html(response);
                 insertPoint = angular.element(wrapper[0].querySelector('.ng-transclude'));
                 insertPoint.replaceWith(el.contents().clone());
                 contents = wrapper.contents();
                 el.replaceWith(contents);
                 $compile(contents)(scope);
          });
        }
      };
    }]);
    

})();
