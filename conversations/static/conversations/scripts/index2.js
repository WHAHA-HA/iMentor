// Copy for apps with [[]] brackets in template.
(function() {
    'use strict';

    //temp polyfill for IE
    if (!String.prototype.startsWith) {
        String.prototype.startsWith = function(searchString, position){
          position = position || 0;
          return this.substr(position, searchString.length) === searchString;
      };
    }

    angular.module('irontec.simpleChat', ['cp.ng.fix-image-orientation']);
    // Whitelist cdn 
    angular.module('irontec.simpleChat').config(['$sceDelegateProvider', function($sceDelegateProvider){
        $sceDelegateProvider.resourceUrlWhitelist([
            // Allow same origin resource loads.
            'self',
            // Allow loading from outer templates domain.
            'https://cdn.imentor.org/**'
        ]); 
    }]);
    angular.module('irontec.simpleChat').directive('irontecSimpleChat', ['$timeout', SimpleChat]);


    function SimpleChat($timeout) {
        var directive = {
            restrict: 'EA',
            templateUrl: '/new_platform/static/conversations/templates/chatTemplate2.html',
            replace: true,
            scope: {
                messages: '=',
                username: '=',
                myUserId: '=',
                inputPlaceholderText: '@',
                submitButtonText: '@',
                title: '@',
                theme: '@',
                submitFunction: '&',
                visible: '=',
                infiniteScroll: '&',
                expandOnNew: '='
            },
            link: link,
            controller: ChatCtrl,
            controllerAs: 'vm'
        };

        function link(scope, element) {
            if (!scope.inputPlaceholderText) {
                scope.inputPlaceholderText = 'Write your message here...';

            }

            if (!scope.submitButtonText || scope.submitButtonText === '') {
                scope.submitButtonText = 'Send';
            }

            if (!scope.title) {
                scope.title = 'Chat';
            }

            scope.$msgContainer = $('.msg-container-base'); // BS angular $el jQuery lite won't work for scrolling
            scope.$chatInput = $(element).find('.chat-input');

            var elWindow = scope.$msgContainer[0];
            scope.$msgContainer.bind('scroll', _.throttle(function() {
                var scrollHeight = elWindow.scrollHeight;
                if (elWindow.scrollTop <= 10) {
                    scope.historyLoading = true; // disable jump to bottom
                    scope.$apply(scope.infiniteScroll);
                    $timeout(function() {
                        scope.historyLoading = false;
                        if (scrollHeight !== elWindow.scrollHeight) // don't scroll down if nothing new added
                            scope.$msgContainer.scrollTop(360); // scroll down for loading 4 messages
                    }, 150);
                }
            }, 300));
        }

        return directive;
    }

    ChatCtrl.$inject = ['$scope', '$timeout', '$rootScope', '$http', '$location', 'Upload'];

    function ChatCtrl($scope, $timeout, $rootScope, $http, $location, Upload) {

        var vm = this;
        //vm.user = 'aaa';
        vm.firstname = $rootScope.firstname;
        vm.isHidden = false;
        vm.messages = $scope.messages;
        vm.username = $rootScope.mentorId ? $rootScope.mentorId : $rootScope.menteeId;
        vm.myUserId = $scope.myUserId;
        vm.inputPlaceholderText = "Write your message here.";
        vm.submitButtonText = $scope.submitButtonText;
        vm.title = $scope.title;
        vm.theme = 'chat-th-' + $scope.theme;
        vm.writingMessage = '';
        vm.panelStyle = {
            'display': 'block'
        };
        vm.chatButtonClass = 'fa-angle-double-down icon_minim';
        $rootScope.markAsRead = false;
        vm.toggle = toggle;
        vm.close = close;
        vm.submitFunction = submitFunction;
        $scope.isSavingWork = false;
        vm.toggleLoadMore = function(show) {
            $rootScope.showLoadMore = show;
        };

        function submitFunction(message) {
            //preventDefault();
            //console.log("message" + message);
            vm.sendingTxt = true;
            if (!message) {
                message = vm.writingMessage;
            }
            $scope.submitFunction()(message, vm.username).then(function(success) {
                console.log(success);
                if (success == true && !message.startsWith('<a href')) {
                    vm.writingMessage = '';

                }
                vm.sendingTxt = false;
                scrollToBottom();
            });
            scrollToBottom();
        }

        $scope.getPartnerInfo = function() {
            return $http.get('/generic/partner_info/', {});
        };


        $scope.getUserInfo = function() {
            return $http.get('/generic/user_info/', {});

        };

        $scope.getMessages = function() {
            if ($rootScope.user_id2) {
                return $http.get('/conv/chat/' + $rootScope.user_id2 + '/', {});
            } else {
                return $http.get('/conv/chat/', {});
            }
        };

        $scope.getFilextensions = function() {
            return $http.get('/generic/file_extensions/', {});
        };

        $scope.getMessagesUnseen = function() {
            return $http.get('/conv/unseen/', {});
        };

        $scope.getMessagesLimit = function() {
            return $http.get('/conv/chat/limit/1/', {});
        };

        $scope.postMessage = function(message, recipient) {
            if ($scope.isSavingWork === false) {

                $scope.isSavingWork = true;
                recipient = $rootScope.mentorId ? $rootScope.mentorId : $rootScope.menteeId;
                //console.log("recipient" + recipient);
                if ($rootScope.user_id2) {
                    return $http.post('/conv/chat/live/' + $rootScope.user_id2 + '/', {
                        'data': message,
                        'recipient_user_id': recipient,
                    });
                } else {
                    return $http.post('/conv/chat/live/', {
                        'data': message,
                        'recipient_user_id': recipient,
                    });
                }
            } else {
                $scope.isSaveWorkRequestPending = true;
            }
        };

        $scope.$watch('visible', function() { // make sure scroll to bottom on visibility change w/ history items
            scrollToBottom();
            $timeout(function() {
                $scope.$chatInput.focus();
            }, 250);
        });

        $scope.$watch('messages.length', function() {
            if (!$scope.historyLoading) scrollToBottom(); // don't scrollToBottom if just loading history
            if ($scope.expandOnNew && vm.isHidden) {
                toggle();
            }
        });

        $rootScope.isChatOpen = function() {
            console.log("is hidden!" + vm.isHidden);
            return $scope.visible;
        }

        $rootScope.getDataAutosaved = function() {

            $scope.getMessages()
                .then(function(data) {
                    //console.log(data);
                    vm.messages = data.data.messages;
                    //console.log(vm.messages);
                    var lastMessage = 0;
                    if (vm.messages.length > 0) {
                        lastMessage = vm.messages[vm.messages.length - 1];
                        console.log('atuosaved: ' + lastMessage.auto_saved);
                        if (lastMessage.auto_saved) {
                            vm.writingMessage = lastMessage.data;
                            $scope.writingMessage = lastMessage.data;
                            //console.log("vm.writingMessage" + vm.writingMessage);
                        }
                    }
                }).catch(function(error) {

                    $rootScope.loadingCanvas = false;
                    console.log('Error occurred');
                });
        };

        $scope.unseenCount = function() {
            var pollInterval = 10000;
            var randomIntFromInterval = function(min, max) {
                return Math.floor(Math.random() * (max - min + 1) + min);
            };
            $rootScope.markAsRead = $rootScope.isChatOpen();
            if (!$rootScope.markAsRead) {
                $scope.getMessages().then(function(data) {
                    $rootScope.messageCount = data.data.unseen_count; //messages.length;//> 0 ? data.data.messages.length - 1 : 0;
                    pollInterval = data.data.other_online === true ? 10000 : 60000;
                });

                $timeout($scope.unseenCount, pollInterval);
            }
        };

        $scope.unseenCount();
        $scope.$watch('vm.writingMessage', function(newVal, oldVal) {
            if (typeof oldVal != 'undefined' && newVal !== oldVal) {

                if (angular.isObject($scope.saveTimer)) {
                    $timeout.cancel($scope.saveTimer);
                }
                if ($rootScope.lastSentMessage === vm.writingMessage) {
                    $timeout.cancel($scope.saveTimer);
                    return;
                }
                $scope.saveTimer = $timeout(function() {
                    //console.log("vm.writingMessage.length" + vm.writingMessage.length);
                    if ($scope.isSavingWork === false) {
                        console.log('Saving Chat ...');
                        if (vm.writingMessage.length > 0) {
                            var message = vm.writingMessage;
                            if ($rootScope.lastSentMessage === vm.writingMessage) {
                                return;
                            }
                            $scope.postMessage(message).then(function() {
                                $scope.isSavingWork = false;
                                if (message === vm.writingMessage) { // No new change since post was called check.
                                    $scope.isSaveWorkRequestPending = false;
                                }
                            }, function() {
                                $scope.isSavingWork = false;
                                if (message === vm.writingMessage) { // No new change since post was called check.
                                    $scope.isSaveWorkRequestPending = false;
                                }
                            });
                        }
                    } else {
                        console.log('Save in progress.. Save later');
                        $scope.isSaveWorkRequestPending = true;
                    }
                }, 2000);

                $scope.isSaveWorkRequestPending = true;
            }
        });

        function scrollToBottom() {
            $timeout(function() { // use $timeout so it runs after digest so new height will be included
                $scope.$msgContainer.scrollTop($scope.$msgContainer[0].scrollHeight);
            }, 200, false);
        }

        vm.scrollToBottom = function() {
            $timeout(function() { // use $timeout so it runs after digest so new height will be included
                $scope.$msgContainer.scrollTop($scope.$msgContainer[0].scrollHeight);
            }, 200, false);
        }

        function close() {
            console.log("$rootScope.markAsRead" + $rootScope.markAsRead);
            $scope.visible = false;
            $rootScope.markAsRead = false;
            console.log("$rootScope.markAsRead" + $rootScope.markAsRead);
            vm.chatButtonClass = 'fa-expand icon_minim';
            vm.panelStyle = {
                'display': 'none'
            };
            vm.isHidden = true;
            $rootScope.markAsRead = false;
            $scope.visible = false;
        }

        function toggle() {
            if (vm.isHidden) {
                vm.chatButtonClass = 'fa-angle-double-down icon_minim';
                vm.panelStyle = {
                    'display': 'block'
                };
                vm.isHidden = false;
                $rootScope.markAsRead = true;
                scrollToBottom();
            } else {
                $rootScope.markAsRead = false;
                vm.chatButtonClass = 'fa-expand icon_minim';
                vm.panelStyle = {
                    'display': 'none'
                };
                vm.isHidden = true;
            }
        }
        $rootScope.openChat = function() {
            vm.chatButtonClass = 'fa-angle-double-down icon_minim';
            vm.panelStyle = {
                'display': 'block'
            };
            vm.isHidden = false;
            $rootScope.markAsRead = true;
            $scope.visible = true;

        }

        $rootScope.toggleChat = function() {
            if (vm.isHidden) {
                vm.chatButtonClass = 'fa-angle-double-down icon_minim';
                vm.panelStyle = {
                    'display': 'block'
                };
                vm.isHidden = false;
                $rootScope.markAsRead = true;
                $scope.visible = true;
                //scrollToBottom();
            } else {
                vm.chatButtonClass = 'fa-expand icon_minim';
                vm.panelStyle = {
                    'display': 'none'
                };
                vm.isHidden = true;
                $rootScope.markAsRead = false;
                $scope.visible = false;

                if ($scope.isSaveWorkRequestPending) {
                    $scope.postMessage(vm.writingMessage).then(function() {
                        $scope.isSavingWork = false;
                        $scope.isSaveWorkRequestPending = false;
                    }, function() {
                        $scope.isSavingWork = false;
                        $scope.isSaveWorkRequestPending = false;
                    });
                }
            }
        }


        $scope.getFilextensions()
            .then(function(data) {
                $scope.allowTypes = data.data.join();
                console.log($scope.allowTypes);
            });

        //File upload option
        $scope.files = [];
        $scope.filesUpload = [];
        $scope.uploadProgress = false;
        $scope.uploadButtonText = 'Upload File';
        //$scope.allowTypes = '.doc,.docx,.docm,.dotx,.dotm,.xls,.xlsx,.xlsm,.xltx,.xltm,.xlsb,.xlam,.csv,.ppt,.pptx,.pptm,.potx,.ppam,.ppsx,.ppsm,.ade,.adp,.accdb,.accde,.accdt,.accdr,.pdf,.psd,.jpg,.jpeg,.gif,.png,.xml,.txt,.vcf,.icl,.ical,.html,.htm,.rtf,.pages,.numbers,.key,.odt,.ods,.odb,.odp,.odg,.odf,.mp4,.mp3';
        $scope.dragClass = 'dragover'; //{accept:'dragover', reject:'dragover-err', pattern:'image/*,audio/*,video/*,text/*'}
        $scope.$watch('filesUpload', function(files) {
            $scope.formUpload = false;
            if (files !== null) {
                for (var i = 0; i < files.length; i++) {
                    $scope.errorMsg = null;
                    (function(file) {
                        if (!file.result) {
                            upload(file);
                        }
                    })(files[i]);
                }
            }
        });

        if (angular.isDefined($scope.response) && angular.isDefined($scope.response.response_url) && $scope.response.response_url.length > 0) {
            var file = {};
            file.name = getFileNameFromUrl($scope.response.response_url);
            file.savedname = file.name;
            file.progress = 100;
            file.result = {
                url: $scope.response.response_url,
                filename: file.name
            };
            $scope.filesUpload.push(file);
        }

        $scope.getUrl = function(relativeUrl) {
            if ($location.absUrl().indexOf(':' + $location.port()) !== -1) {
                return $location.protocol() + '://' + $location.host() + ':' + $location.port() + '' + relativeUrl;
            }
            return $location.protocol() + '://' + $location.host() + '' + relativeUrl;
        };

        $scope.remove = function(file) {
            var index = $scope.filesUpload.indexOf(file);
            if (index > -1) {
                $scope.filesUpload.splice(index, 1);
                var response = {
                    url: '',
                    filename: ''
                };
                $scope.save(response);
            }
        };


        $scope.abort = function(file) {
            file.result = 'Aborted';
        };

        $scope.save = function(response) {

        };

        $scope.setProgress = function(progress) {
            $scope.uploadProgress = progress;
            $scope.uploadButtonText = progress ? "Uploading please wait" : "Upload File";
        };

        $scope.validateType = function(file) {
            var ext = file.name.substr(file.name.lastIndexOf('.'));
            if ($scope.allowTypes.toLowerCase().indexOf(ext.toLowerCase()) === -1) {
                alert('Unable to upload. Unsupported file type.');
                return false;
            }
            return true;
        };

        function upload(file) {
            file.savedname = file.name;
            $scope.setProgress(true);
            file.upload = Upload.upload({
                url: "/user_content/", // + '' + $scope.user.user_id + '/',
                method: 'POST',
                /* headers: {
				 'my-header': 'my-header-value'
				 },
				 fields: {user_id: $scope.user.user_id},*/
                file: file,
                fileFormDataName: 'file'
            });

            file.upload.then(function(response) {
                $timeout(function() {

                    if (angular.isDefined(response)) {
                        file.result = response.data;
                        file.savedname = getFileNameFromUrl(file.result.url);
                    }

                    $scope.setProgress(false);


                    var fileinfo = {
                        url: file.result.url,
                        filename: file.savedname
                    };
                    //console.log("file.result.url" + file.result.url);
                    //console.log("file.savedname" + file.savedname.split('.'));
                    var ext = file.savedname.substr(file.savedname.lastIndexOf('.'));
                    ext = ext.toLowerCase();
                    //console.log("ext" + ext);
                    if (ext == '.jpg' || ext == '.jpeg' || ext == '.gif' || ext == '.png') {
                        vm.submitFunction("<a href='" + file.result.url + "' target='_blank'>" + "<img  img-fix-orientation='" + file.result.url + "' style='width: auto;max-height:240px;max-width: 100%;' src='" + file.result.url + "' />" + "</a>");
                    } else {
                        vm.submitFunction("<a href='" + file.result.url + "' target='_blank'>" + file.savedname + "</a>");
                    }


                    scrollToBottom();
                    $scope.remove(file);

                });
            }, function(response) {
                if (response.status > 0)
                    file.result = response.status + ': ' + response.data;
                $scope.errorMsg = 'failed to upload. Please click the red "X" icon to the left and try again, or contact your staff member with the full name of the file to get help.';


                $scope.setProgress(false);
            });

            file.upload.progress(function(evt) {
                // Math.min is to fix IE which reports 200% sometimes
                file.progress = Math.min(100, parseInt(100.0 * evt.loaded / evt.total));
            });

            file.upload.xhr(function(xhr) {
                // xhr.upload.addEventListener('abort', function(){console.log('abort complete')}, false);
            });
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


    }


})();