/*jshint sub:true*/
//sequence
(function() {
    'use strict';
    var ChatModule = angular.module('ChatModule', []);
    // Whitelist cdn 
    ChatModule.config(['$sceDelegateProvider', function($sceDelegateProvider){
        $sceDelegateProvider.resourceUrlWhitelist([
            // Allow same origin resource loads.
            'self',
            // Allow loading from outer templates domain.
            'https://cdn.imentor.org/**'
        ]); 
    }]);
    ChatModule.directive('disableBackgroundScrolll', function ($timeout) {
        return {
            restrict: 'A',
            link: function (scope, element, attr) {
                var scrollPosition = 0;
                var bodyElement = document.body; 
                element.on('blur', function () {

                   
                    $("html").css({ "overflow-y": "" });
                    $("body").css({ "height" : "", "overflow-y": "" });
                    $(".content").css({ "top" : "", "position": "" });
                    console.log('enableBackgroundScroll');

                    $timeout(function(){
                      bodyElement.scrollTop = scrollPosition;
                    },0);
                });

                element.on('focus', function () {
                    scrollPosition = (document.documentElement || document.body.parentNode || document.body).scrollTop;
                    
                    if(document.documentElement  && document.documentElement.scrollTop > 0 ) {
                        bodyElement = document.documentElement;
                        scrollPosition = document.documentElement.scrollTop;
                    } else if(document.body.parentNode  && document.body.parentNode.scrollTop > 0 ) {
                        bodyElement = document.body.parentNode;
                        scrollPosition = document.body.parentNode.scrollTop;
                    } else if(document.body  && document.body.scrollTop > 0 ) {
                        bodyElement = document.body;
                        scrollPosition = document.body.scrollTop;
                    }  
                    $("body").css({ "height" : ($(window).height() - 1) + 'px', "overflow-y": "hidden" });
                    $("html").css({ "overflow-y": "scroll" });
                    $(".content").css({ "top" : '-' + scrollPosition + 'px', "position": "relative" });

                    //$(window).scrollTop(scrollPosition);
                    console.log('disableBackgroundScroll');

                });

            }
        }
    });


    var controllerId = 'Shell';

    Shell.$inject = ['$scope', '$interval', '$rootScope', '$location', '$http', 'Data', '$timeout', '$resource', 'Upload', '$window'];

    ChatModule.controller(controllerId, Shell).filter('highlight', ['$sce', function($sce) {
        return function(text, phrase) {

            if (phrase) text = text.replace(new RegExp('(' + phrase + ')', 'gi'),
                '<span class="highlighted">$1</span>');

            return $sce.trustAsHtml(text);
        };
    }]).factory('Data', ['$resource', '$window', '$location', function($resource, $window, $location) {
        var currDomain = $location.host();
        if (currDomain == '127.0.0.1' || currDomain == '192.168.0.107' || currDomain == '192.168.1.9') {
            currDomain += ':8000'
        }
        var url = "//" + currDomain + '/conv/unseen/ ';

        return $resource(url, {}, {
            query: { method: 'GET', params: {}, isArray: true }
        });
    }]).filter('reverse', function() {
        return function(items) {
            return items.slice().reverse();
        };
    });

    function Shell($scope, $interval, $rootScope, $location, $http, Data, $timeout, $resource, Upload, $window) {

        var vm = this;
        $scope.data = [];
        $scope.getMessages = function() {
            if($rootScope.user_id2) {
                return $http.get('/conv/chat/' + $rootScope.user_id2 + '/', {});
            }else{
                return $http.get('/conv/chat/', {});
            }
        };
        $scope.getMessagesLive = function() {
            if($rootScope.user_id2) {
                return $http.get('/conv/chat/live/' + $rootScope.user_id2 + '/', {});
            }else{
                return $http.get('/conv/chat/live/', {});
            }
        };
        $scope.getMessagesUnseen = function() {
            return $http.get('/conv/unseen/', {});

        };
        $scope.getMessagesUnseenLive = function() {
            return $http.get('/conv/unseen/live/', {});

        };
        $scope.getMessagesLimit = function() {
            return $http.get('/conv/chat/limit/1/', {});
        };
        $scope.getMessagesDateTimeLimit = function() {
            return $http.get('/conv/chat/from_datetime/' + $rootScope.lastMessageDatestamp + '/limit/100/', {});
        };

        $scope.getCombinedMessages = function() { //get unseen and messages from other window
            if(typeof $rootScope.lastMessageDatestamp != 'undefined') {
                 return $scope.getMessagesLive();//return $http.get('/conv/chat/live/from_datetime/' + $rootScope.lastMessageDatestamp + '/limit/100/', {});  
            } else {
                return $scope.getMessagesLive();  
            }
        };

        $scope.getMessagesIdLimit = function() {
            return $http.get('/conv/chat/to_id/' + $rootScope.lastMessageId + '/limit/20/', {});
        };        


        $scope.postMessage = function(message, recipient) {
            recipient = $rootScope.mentorId ? $rootScope.mentorId : $rootScope.menteeId;
            console.log("recipient" + recipient);

            if($rootScope.user_id2) {
                return $http.post('/conv/chat/live/' + $rootScope.user_id2 + '/', {
                    'data': message,
                    'recipient_user_id': recipient,
                    'sent': true,
                });
            }else{
                return $http.post('/conv/chat/live/', {
                    'data': message,
                    'recipient_user_id': recipient,
                    'sent': true,
                });
            }

        };

        $scope.getPartnerInfo = function() {
            return $http.get('/generic/partner_info/', {});
        };

        $scope.getPartnerInfo().then(function(data) {
            //console.log(data);
            var partnerSiteId = null;

            if (data.data.length > 0) {
                partnerSiteId = data.data[0].id;
                console.log("id" + partnerSiteId);
            }

            var siteIds = [2338, 2339, 2340, 2341, 2372, 2373, 2374, 2375, 2376, 2377, 1930, 1931, 1932, 1933, 1962, 1963, 1964, 1965, 2211, 2212, 2033, 2213, 2214];

            var a = siteIds.indexOf(partnerSiteId);
            if (a !== -1) {
                $rootScope.isOnPartnerIdList = true;
                console.log("partner on list");
            } else {
                $rootScope.isOnPartnerIdList = false;
                //console.log("partner is not on list");
            }

        });

        $scope.getUserInfo = function() {
            if ($rootScope.user_id2) {
                return $http.get('/generic/user_info/' + $rootScope.user_id2 + '/', {});
            } else {
                return $http.get('/generic/user_info/', {});
            }
        };

        $scope.getUserInfo()
            .then(function(data) {
                $rootScope.firstname = data.data.self.f_name;
                $rootScope.lastname = data.data.self.l_name;
                $rootScope.useridnum = data.data.self.user_id;
                $rootScope.userrole = data.data.self.role;
                $rootScope.persona = data.data.self.persona_id;
                $rootScope.match_status = data.data.self.match_status;
                console.log('user role: ' + $rootScope.userrole);
                /*if($rootScope.userrole === 'Mentor' && !($cookies.get('canvasVideo')) && ($scope.isOnPartnerList()) ) {
                 $scope.openCanvasVideo();
                 } */
                if (typeof data.data.mentor !== 'undefined' && typeof data.data.mentor.f_name !== 'undefined') {
                    // console.log("1" + data.data.mentor.f_name);
                    $rootScope.otherPersonMentor = data.data.mentor.f_name;
                    $rootScope.otherMentorPhoto = data.data.mentor.photo;
                    $rootScope.mentorId = data.data.mentor.user_id;
                    console.log("$rootScope.mentorId " + $rootScope.mentorId)
                     $rootScope.chatDefautTitle = "Message with " + $rootScope.otherPersonMentor;
                } else if (typeof data.data.mentee !== 'undefined' && typeof data.data.mentee.f_name !== 'undefined') {
                    console.log("2");
                    $rootScope.otherPersonMentee = data.data.mentee.f_name;
                    $rootScope.otherMenteePhoto = data.data.mentee.photo;
                    $rootScope.menteeId = data.data.mentee.user_id;
                    console.log("$rootScope.menteeId " + $rootScope.menteeId)
                    $rootScope.chatDefautTitle = "Message with " + $rootScope.otherPersonMentee;
                }
                $rootScope.chatTitle = "Loading...";
                $rootScope.showChat = $rootScope.match_status == 'M';
                return $scope.getMessages(); 
            })
            .then(function(data) {
                if(data.status == 403) {
                    $window.location.href = '/';
                }
                console.log("messages unseen" + data.data.count);
                $rootScope.messageCount = data.data.unseen_count; // > 0 ? data.data.count - 1 : 0;
                $rootScope.showCount = $rootScope.messageCount > 0;
                //console.log("$rootScope.messageCount" + $rootScope.messageCount);
                if ($rootScope.showChat == true) {
                    $rootScope.getDataAutosaved();
                    vm.getData();
                }
            }).catch(function(){
                if($rootScope.chatTitle ==  "Loading...") {
                    $rootScope.chatLoadMoreText = "Reload";
                    $rootScope.chatLoadingMore = false;
                    $rootScope.chatTitle = "Load failed. Click reload below.";
                }
            });

            function addMessages(messages) {
                if (messages.length > 0) {
                    console.log("new messages");
                    var lastMessage = '';
                    lastMessage = vm.messages[vm.messages.length - 1].id;
                   
                    for (var x = 0; x < messages.length; x++) {
                        if(messages[x].auto_saved == true) {
                            break;
                        }
                        
                        var isDuplicate = false;
                        
                        for (var i = 0; i < vm.messages.length; i++) {
                            if(vm.messages[i].sequence === messages[x].sequence && vm.messages[i].first_name === messages[x].first_name && vm.messages[i].data === messages[x].data) {
                              isDuplicate = true;
                              if(vm.messages[i].first_name != $rootScope.firstname) {
                                //$rootScope.messageCount = $rootScope.messageCount - 1;
                                //$rootScope.showCount = $rootScope.messageCount > 0;
                              }
                              break;
                            } else if(vm.messages[i].first_name === $rootScope.firstname && vm.messages[i].first_name === messages[x].first_name && vm.messages[i].data === messages[x].data && typeof vm.messages[i].received_by_server === 'undefined') {
                              isDuplicate = true;
                              break;
                            } 
                        }

                        if(isDuplicate === false) {
                          vm.messages.push({
                              'data': messages[x].data,
                              'first_name': messages[x].first_name,
                              'received_show_date': messages[x].received_show_date,
                              'received_by_server': messages[x].received_by_server,
                              'sequence': messages[x].sequence,
                              'recipient_user_id' : messages[x].recipient_user_id
                          });
                        }
                    }
                    if(vm.messages.length > 0){
                      $rootScope.lastMessageDatestamp = vm.messages[vm.messages.length - 1].received_by_server;
                    }
                }
            }

        vm.getData = function() {
            $rootScope.chatTitle = "Loading..." ;
            return $scope.getMessages()
                .then(function(data) {
                    if(data.status == 403) {
                        $window.location.href = '/';
                    }
                    //console.log(data);
                    vm.messages = data.data.messages;
                    $rootScope.lastMessageId = vm.messages[0].id;
                    $rootScope.chatShowLoadMore = vm.messages.length < 20 ? false : true;
                    if($rootScope.chatTitle ==  "Loading...") {
                        $rootScope.chatTitle = $rootScope.chatDefautTitle;
                    }
                     $rootScope.chatLoadMoreText = "load previous messages";
                     $rootScope.chatLoadingMore = false;
                    //console.log(vm.messages);
                    return true;
                }).catch(function(error) {
                    console.log('Error occurred');
                    if($rootScope.chatTitle ==  "Loading...") {
                        $rootScope.chatLoadMoreText = "Reload";
                        $rootScope.chatLoadingMore = false;
                        $rootScope.chatTitle = "Load failed. Click reload below.";
                    }
                    return false;
                });
            };
        vm.sendMessage = function(message, username) {
            var messageCopy = angular.copy(message);
        
            $rootScope.chatTitle = "Sending...";
            username = $rootScope.mentorId ? $rootScope.mentorId : $rootScope.menteeId;
            console.log("send msg username: " + username);
            var currentdate = new Date();

            function formatAMPM(date) {
                var hours = date.getHours();
                var minutes = date.getMinutes();
                var ampm = hours >= 12 ? 'PM' : 'AM';
                hours = hours % 12;
                hours = hours ? hours : 12; // the hour '0' should be '12'
                minutes = minutes < 10 ? '0' + minutes : minutes;
                var strTime = hours + ':' + minutes + '' + ampm;
                return strTime;
            }

            vm.dateSent = "Today" + " at " +
                formatAMPM(currentdate);
            vm.sendingTxt = true;
            var autolinker = new Autolinker( {
                urls : {
                    schemeMatches : true,
                    wwwMatches    : true,
                    tldMatches    : true
                },
                email       : true,
                phone       : true,
                twitter     : false,
                hashtag     : false,

                stripPrefix : false,
                newWindow   : true,

                truncate : {
                    length   : 0,
                    location : 'end'
                },

                className : ''
            } );
            messageCopy = autolinker.link( messageCopy ); 
            console.log(messageCopy);
            $rootScope.lastSentMessage = angular.copy(message);

            return $scope.postMessage(messageCopy, username).then(function(data) {
                if(data.status == 403) {
                    $window.location.href = '/';
                }
                vm.sendingTxt = false;
                console.log(data);
                vm.writingMessage = '';
                var messages = data.data.messages;

                addMessages(messages);
                
                /*
                var messageObj = {
                        'data': message,
                        'first_name': $rootScope.firstname,
                        'received_show_date': vm.dateSent,
                }
                
                for (var i = 0; i < messages.length; i++) {
                    if(messages[i].first_name === $rootScope.firstname && messages[i].data === message && messages[i].auto_saved = false) {
                      messageObj = messages[i];
                      break;
                    }
                }

                if (message && message !== '' && username) {
                    vm.messages.push(messageObj);
                }*/
                $rootScope.chatTitle = $rootScope.chatDefautTitle;

                return true;
            }).catch(function(error) {
                $scope.sendingTxt = false;
                $rootScope.chatTitle = "Send failed. Please resend.";
                console.log('Error occurred');
                return false;
            });
        };

        $rootScope.unseenPolling = function() {
            var randomIntFromInterval = function(min, max) {
                return Math.floor(Math.random() * (max - min + 1) + min);
            };
            if(typeof $scope.pollingCallback == 'undefined' ) {
                
                $scope.pollingCallback = $scope.getMessagesLive; 
            }
            var pollInterval = 10000;
            $rootScope.markAsRead = $rootScope.isChatOpen();
            if ($rootScope.markAsRead === true) {
                $scope.pollingCallback().then(function(data) {
                    if(data.status == 403) {
                        $window.location.href = '/';
                    }
                    var otherUserMessages = $.grep(data.data.messages, function (element, index) {
                        return element.first_name != $rootScope.firstname;
                    });
                    var myMessages = $.grep(data.data.messages, function (element, index) {
                        return element.first_name === $rootScope.firstname;
                    });

                    $rootScope.messageCount = 0; data.data.unseen_count; // otherUserMessages.length; //data.data.messages.length;
                    $rootScope.showCount = $rootScope.messageCount > 0;
                    console.log($rootScope.messageCount)
                    $scope.data = data.data.messages;
                    $rootScope.markAsRead = $rootScope.isChatOpen();
                    if(data.data.other_online === false){
                      pollInterval = 60000;
                    }
                    if ($rootScope.markAsRead === true) {
                        addMessages($scope.data);
                    }
                });

                if(vm.messages.length > 0){
                  $rootScope.lastMessageDatestamp = vm.messages[vm.messages.length - 1].received_by_server;
                }
                $scope.pollingCallback = $scope.getCombinedMessages;
                $timeout($rootScope.unseenPolling, pollInterval);
            };
        };
        // test pushing more stuff onto chat
        $rootScope.loadMoreMessages = function() {
            if($rootScope.chatLoadMoreText == 'Reload' ) {            
                $rootScope.getDataAutosaved();
                vm.getData().then(function(){
                    $rootScope.unseenPolling();
                    return;
                });

                return;
            }

            $rootScope.chatLoadingMore = true;
            $rootScope.chatLoadMoreText = "loading...";
            $rootScope.chatTitle = "Loading...";
            var wrapper = document.getElementsByClassName('msg-container-base')[0],
            scrollRemaining = wrapper.scrollHeight - wrapper.scrollTop;
            console.log("load more msgs!!");
            $scope.getMessagesIdLimit().then(function(data) {
                    if(data.status == 403) {
                        $window.location.href = '/';
                    }
                    $rootScope.chatLoadingMore = false;
                    $rootScope.chatLoadMoreText = "load previous messages";

                    var otherUserMessages = $.grep(data.data.messages, function (element, index) {
                        return element.first_name != $rootScope.firstname;
                    });
                    var myMessages = $.grep(data.data.messages, function (element, index) {
                        return element.first_name === $rootScope.firstname;
                    });

                    $scope.moredata = data.data.messages;
                    
                        
                        if ($scope.moredata.length > 0) {
                            console.log("new messages");
                            $rootScope.lastMessageId = $scope.moredata[0].id;
                            
                            for (var x = $scope.moredata.length - 1; x >=0; x--) {
                                var isDuplicate = false;
                                
                                for (var i = 0; i < vm.messages.length; i++) {
                                    if(vm.messages[i].sequence === $scope.moredata[x].sequence && vm.messages[i].first_name === $scope.moredata[x].first_name && vm.messages[i].data === $scope.moredata[x].data) {
                                      isDuplicate = true;
                                      break;
                                    } else if(vm.messages[i].first_name === $rootScope.firstname && vm.messages[i].first_name === $scope.moredata[x].first_name && vm.messages[i].data === $scope.moredata[x].data && typeof vm.messages[i].received_by_server === 'undefined') {
                                      isDuplicate = true;
                                      break;
                                    }
                                }

                                if(isDuplicate === false) {
                                  vm.messages.unshift({
                                      'data': $scope.moredata[x].data,
                                      'first_name': $scope.moredata[x].first_name,
                                      'received_show_date': $scope.moredata[x].received_show_date,
                                      'received_by_server': $scope.moredata[x].received_by_server,
                                      'sequence': $scope.moredata[x].sequence,
                                      'recipient_user_id' : $scope.moredata[x].recipient_user_id
                                  });
                                }
                            }

                            if($scope.moredata.length < 20){
                                $rootScope.chatLoadMoreText = 'no more messages';
                                $rootScope.chatLoadingMore = true;
                                //$rootScope.chatShowLoadMore = false;
                            }

                            $timeout(function(){
                              wrapper.scrollTop = wrapper.scrollHeight - scrollRemaining;
                            },500);
                        } else {
                            $rootScope.chatLoadMoreText = 'no more messages';
                            $rootScope.chatLoadingMore = true;
                            //$rootScope.chatShowLoadMore = false;
                        }
                    if($rootScope.chatTitle ==  "Loading...") {
                        $rootScope.chatTitle = $rootScope.chatDefautTitle;
                    }
                }).catch(function() {
                    $rootScope.chatLoadMoreText = "load previous messages";
                    $rootScope.chatTitle = "Load failed. Please retry.";
                    $rootScope.chatLoadingMore = false;

                });
        };

        vm.username = $rootScope.mentorId ? $rootScope.mentorId : $rootScope.menteeId;
        vm.user = $rootScope.firstname;
        vm.visible = false;
        vm.expandOnNew = true;
        vm.title = "Write to your mentor/mentee";
        vm.theme = 'material';
        vm.messages = [];
        vm.sendingTxt = false;
        $rootScope.chatLoadMoreText = 'load previous messages';

    }
})();
