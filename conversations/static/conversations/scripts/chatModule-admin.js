/*jshint sub:true*/
(function () {
  'use strict';
  var ChatModule = angular.module('ChatModuleAdmin', []);
  // Whitelist cdn 
    ChatModule.config(['$sceDelegateProvider', function($sceDelegateProvider){
        $sceDelegateProvider.resourceUrlWhitelist([
            // Allow same origin resource loads.
            'self',
            // Allow loading from outer templates domain.
            'https://cdn.imentor.org/**'
        ]); 
    }]);
  var controllerId = 'Shell';
  Shell.$inject = ['$scope','$interval','$rootScope','ngDialog','$location','$http','Data','$timeout','$resource', '$window'];

  ChatModule.controller(controllerId, Shell).filter('highlight', ['$sce', function($sce) {
    return function(text, phrase) {

      if (phrase) text = text.replace(new RegExp('('+phrase+')', 'gi'),
        '<span class="highlighted">$1</span>');

      return $sce.trustAsHtml(text);
    };
  }]).factory('Data', ['$resource', function ($resource) {
    return $resource('/conv/unseen/', {}, {
      query: { method: 'GET', params: {}, isArray: true }
    });
  }]).filter('reverse', function() {
        return function(items) {
            return items.slice().reverse();
        };
    });

  function Shell($scope,$interval,$rootScope,ngDialog,$location,$http,Data,$timeout,$resource,$window) {


    var vm = this;
        $scope.data = [];
$scope.getMessages = function() {
            if($rootScope.user_id2) {
                return $http.get('/conv/chat/' + $rootScope.user_id2 + '/', {});
            }else{
                return $http.get('/conv/chat/', {});
            }
        };

        $scope.getCombinedMessages = function() { //get unseen and messages from other window
            if(typeof $rootScope.lastMessageDatestamp != 'undefined') {
                 return $scope.getMessagesLive();//return $http.get('/conv/chat/live/from_datetime/' + $rootScope.lastMessageDatestamp + '/limit/100/', {});  
            } else {
                return $scope.getMessagesLive();  
            }
        };

        $scope.postMessage = function(message, recipient) {
            recipient = $rootScope.mentorId2 ? $rootScope.mentorId2 : $rootScope.menteeId2;
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
            var partnerSiteId = data.data[0].id;
            console.log("id" + partnerSiteId);
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


         function addMessages(messages) {
                if (messages.length > 0) {
                    console.log("new messages");
                    //var lastMessage = '';
                    //lastMessage = vm.messages[vm.messages.length - 1].id;
                   
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

    vm.sendMessage = function(message, username) {
            var messageCopy = angular.copy(message);
        
            $rootScope.chatTitle = "Sending...";
            username = $rootScope.mentorId2 ? $rootScope.mentorId2 : $rootScope.menteeId2;
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

        // test pushing more stuff onto chat
        $rootScope.loadMoreMessages = function() {
            if($rootScope.chatLoadMoreText == 'Reload' ) {            
                $rootScope.openChatAdmin($rootScope.user_id2, $rootScope.conversationSnapshotStartDate, $rootScope.conversationSnapshotEndDate) 
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

        vm.username = $rootScope.mentorId2 ? $rootScope.mentorId2 : $rootScope.menteeId2;
        vm.user = $rootScope.firstname;
        vm.visible = false;
        vm.expandOnNew = true;
        vm.title = "Write to your mentor/mentee";
        vm.theme = 'material';
        vm.messages = [];
        $rootScope.chatLoadMoreText = 'Reload';

  }
})();