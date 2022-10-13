/*jshint sub:true*/
(function () {
  'use strict';
  var controllerId = 'Shell';

  Shell.$inject = ['$scope','$interval','$rootScope','$location','$http','Data','$timeout','$resource','Upload'];

  angular.module("ccControllers").controller(controllerId, Shell).filter('highlight', ['$sce', function($sce) {
    return function(text, phrase) {

      if (phrase) text = text.replace(new RegExp('('+phrase+')', 'gi'),
        '<span class="highlighted">$1</span>');

      return $sce.trustAsHtml(text);
    };
  }]).factory('Data', ['$resource','$window','$location', function ($resource,$window,$location) {
    var currDomain = $location.host();
    if (currDomain == '127.0.0.1'){
      currDomain += ':8000'
    }
    var url = "//" + currDomain + '/conv/unseen/ ';

    return $resource(url, {}, {
      query: { method: 'GET', params: {}, isArray: true }
    });
  }]).filter('reverse', function () {
    return function(items) {
      return items.slice().reverse();
    };
  });

  function Shell($scope,$interval,$rootScope,$location,$http,Data,$timeout,$resource, Upload) {

    var vm = this;
    $scope.data = [];
    $scope.getMessages = function() {
      return $http.get('/conv/chat/', {}
      );

    };
    $scope.getMessagesLimit = function() {
      return $http.get('/conv/chat/limit/2/', {}
      );

    };
    $scope.getMessagesUnseen = function() {
      return $http.get('/conv/unseen/', {}
      );

    };
    $scope.getMessagesUnseenCount = function() {
      return $http.get('/conv/unseen/count/', {}
      );

    };
    $scope.postLastSeenMessage = function(last_id){
      return $http.post('/conv/unseen/', {
        'last_seen_id': last_id,
      });
    };

    $scope.postMessage = function(message, recipient){
      recipient = $rootScope.mentorId?  $rootScope.mentorId: $rootScope.menteeId;
      console.log("recipient" + recipient);
      return $http.post('/conv/chat/', {
        'data': message,
        'recipient_user_id': recipient,
        'sent': true,
      });

    };

    $scope.getMoreMessages = function(msgId){
      return $http.get('/conv/chat/to_id/' + 10 + '/', {});

    };

    $scope.getPartnerInfo = function() {
      return $http.get('/generic/partner_info/', {}
      );
    };

    $scope.getPartnerInfo().then(function(data){
      //console.log(data);
      var partnerSiteId = data.data[0].id;
      console.log("id" + partnerSiteId);
      var siteIds = [2338,2339,2340,2341,2372,2373,2374,2375,2376,2377,1930,1931,1932,1933,1962,1963,1964,1965,2211,2212,2033,2213,2214];

      var a = siteIds.indexOf(partnerSiteId);
      if(a !== -1){
        $rootScope.isOnPartnerIdList = true;
        console.log("partner on list");
      }
      else{
        $rootScope.isOnPartnerIdList = false;
        //console.log("partner is not on list");
      }

    });

    $scope.getUserInfo = function() {
      if($rootScope.user_id2){
        return $http.get('/generic/user_info/' + $rootScope.user_id2 + '/' , {}
        );
      }else{
        return $http.get('/generic/user_info/' , {}
        );
      }
    };

    $scope.getUserInfo()
      .then(function (data) {
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
        if(typeof data.data.mentor !== 'undefined' && typeof data.data.mentor.f_name !== 'undefined'){
          // console.log("1" + data.data.mentor.f_name);
          $rootScope.otherPersonMentor = data.data.mentor.f_name;
          $rootScope.otherMentorPhoto = data.data.mentor.photo;
          $rootScope.mentorId = data.data.mentor.user_id;
          console.log("$rootScope.mentorId " + $rootScope.mentorId)
        }
        else if(typeof data.data.mentee !== 'undefined' && typeof data.data.mentee.f_name !== 'undefined'){
          console.log("2");
          $rootScope.otherPersonMentee = data.data.mentee.f_name;
          $rootScope.otherMenteePhoto = data.data.mentee.photo;
          $rootScope.menteeId = data.data.mentee.user_id;
          console.log("$rootScope.menteeId " + $rootScope.menteeId)
        }

        return $scope.getPartnerInfo();
      })
      .then(function(data) {
        //console.log(data);
        var partnerSiteId = data.data[0].id;
        console.log("id" + partnerSiteId);
        var siteIds = [2338,2339,2340,2341,2372,2373,2374,2375,2376,2377,1930,1931,1932,1933,1962,1963,1964,1965,2211,2212,2033,2213,2214];

        var a = siteIds.indexOf(partnerSiteId);
        if(a !== -1){
          $rootScope.isOnPartnerIdList = true;
          console.log("partner on list");
        }
        else{
          $rootScope.isOnPartnerIdList = false;
          //console.log("partner is not on list");
        }

        var currDomain = $location.host();
        console.log("$rootScope.showChat" + currDomain);
        var ch = currDomain.split(".")[0];
        $scope.subdomain = ch;
        var chatPartners = ['127','platformtraining', 'chicago'];
        $rootScope.showChat = (((chatPartners.indexOf(ch) != -1) || ($location.host() == "nyc.imentor.org" && $rootScope.isOnPartnerIdList) || ($location.host() == "nyc.imentordev.org" && $rootScope.isOnPartnerIdList == true))&&($rootScope.match_status == 'M'));
        console.log("$rootScope.showChat" + $rootScope.showChat);
        console.log("$rootScope.isOnPartnerIdList" + $rootScope.isOnPartnerIdList);
        console.log("$rootScope.match_status" + $rootScope.match_status);
        console.log("$location.host()" + $location.host());
        $scope.allReady = true;
      }).then(function(){

      if($rootScope.showChat == true) {
        vm.getData = function () {
          $scope.getMessages()
            .then(function (data) {
              console.log(data);
              vm.messages = data.data;
              var lastMessage = 0;
              if (vm.messages.length > 0) {
                lastMessage = vm.messages[vm.messages.length - 1];
                console.log(lastMessage);
              }
              var lastMessageSaved = vm.messages[vm.messages.length - 1].auto_saved;
              if (lastMessageSaved == true) {
                vm.writingMessage = lastMessage.data;
                console.log("vm.writingMessage" + vm.writingMessage);
              }

            }).then(function (data) {
            console.log(data);
            //return $scope.postMessage()
          }).then(function (data) {
            console.log(data);
          }).catch(function (error) {
            $rootScope.loadingCanvas = false;
            console.log('Error occurred');
          });
        }();

        var tick = function(){
          $scope.data = Data.query(function () {
            $rootScope.markAsRead = $rootScope.isChatOpen();
            console.log("$rootScope.markAsRead " + $rootScope.markAsRead );
            $timeout(tick, 10000);
            //console.log($scope.data);
            $scope.getMessagesUnseenCount().then(function (data) {
              $rootScope.messageCount = data.data['unseen'];
            }).catch(function (error) {
              console.log('Error occurred');
            });
            if ($rootScope.markAsRead === true) {
              if ($scope.data.length > 0) {
                console.log("new messages");
                var lastMessage = '';
                lastMessage = vm.messages[vm.messages.length - 1].id;
                for (var x = 0; x < $scope.data.length; x++) {
                  // vm.sendMessage($scope.data[x].data,$scope.data[x].user_id);

                  if ($rootScope.markAsRead == true) {
                    $scope.postLastSeenMessage($scope.data[x].id);
                    vm.messages.push({
                      'data': $scope.data[x].data,
                      'first_name': $scope.data[x].first_name,
                      'received_by_server': $scope.data[x].received_by_server
                    });
                  }

                  //console.log($scope.data[x].data);
                  //console.log($scope.data[x].user_id);
                  //lastMessage = vm.messages[vm.messages.length - 1].id;
                }
              }}
            else {
              //console.log("no new messages");
            }
          });
        }

        console.log("$rootScope.markAsRead " + $rootScope.markAsRead );
        $rootScope.markAsRead = $rootScope.isChatOpen();
        $timeout(tick, 10000);
        // polling for unseen messages
      }
    }).catch(function (error) {
      $rootScope.loadingCanvas = false;
      console.log('Error occurred');
    });



    vm.sendMessage = function(message, username) {
      username = $rootScope.mentorId?  $rootScope.mentorId: $rootScope.menteeId;
      console.log("send msg username: " + username);
      var currentdate = new Date();

      function formatAMPM(date) {
        var hours = date.getHours();
        var minutes = date.getMinutes();
        var ampm = hours >= 12 ? 'PM' : 'AM';
        hours = hours % 12;
        hours = hours ? hours : 12; // the hour '0' should be '12'
        minutes = minutes < 10 ? '0'+minutes : minutes;
        var strTime = hours + ':' + minutes + '' + ampm;
        return strTime;
      }

      vm.dateSent = "Today" + " at " +
        formatAMPM(currentdate);
      $scope.postMessage(message, username).then(function (data) {
        console.log(data);
        vm.writingMessage = '';
        if(message && message !== '' && username) {
          vm.messages.push({
            'data': message,
            'first_name': $rootScope.firstname,
            'received_by_server': vm.dateSent,
          });
        }
      }).catch(function (error) {
        console.log('Error occurred');
      });
    };

    // test pushing more stuff onto chat
    $rootScope.loadMoreMessages = function () {
      console.log("load more msgs!!");
    };

    vm.username = $rootScope.mentorId?  $rootScope.mentorId: $rootScope.menteeId;
    vm.user = $rootScope.firstname;
    vm.visible = false;
    vm.expandOnNew = true;
    vm.title="Write to your mentor/mentee";
    vm.theme = 'material';
  }
})();