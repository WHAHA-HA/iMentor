(function () {
    'use strict';
    var controllerId = 'HomeController';

    angular.module('canvas').controller(controllerId, HomeController);

    HomeController.$inject = ['common', 'datacontext','toastr', 'gridsterBuilder', '$scope', '$interval','authentication','$cookies'];

    function HomeController(common, datacontext,toastr, gridsterBuilder, $scope, $interval,authentication) {
        var getLogFn = common.logger.getLogFn;
        var log = getLogFn(controllerId);

        var vm = this;
        vm.info = {
            title: 'Welcome To Your Canvas',
            description: 'Fill it with your imagination.'
        };

        vm.canvas = {
            config: {draggable:false},
            widgets: []
        };
        
        vm.canvasName = '';
        vm.title = 'Home';
        vm.removeWidgetId = null;
        vm.addWidget = addWidget;
        vm.getState = getState;
        vm.removeWidget = removeWidget;
        vm.blockui=false;

        activate();

        $interval( function(){ 
            //console.log('Checking canvas state.');
            //getState(); 
        }, 30000);

        function activate() {

            sessionStorage.setItem("browser_session_id", (new Date()).getTime());
            var promises = [getCanvas(), getPresentation()];
            common.activateController(promises, controllerId)
                .then(function () { 
                /*log('Activated Home View');*/ 
            });

            // authentication.login('imentor','2qa3ws4ed5rf6tg7yh');
        }

        function getCanvas() {
            return datacontext.getCanvas().then(function (data) {
                vm.canvasName = data.description;
                vm.canvas.widgets =  setCanvasOrder(data.apps);
                vm.canvas.canvas_set = data;
                if(data.config) {vm.canvas.config = data.config;}
                return vm.canvas.apps;
            });
        }

        function getPresentation(){
            return datacontext.getPresentation().then(function (data) {
               
                return data;
            });
        }

        function getSurvey(){
            return datacontext.getSurvey().then(function (data) {
                console.log("survey!");
                console.log(data);
                return data;
            });
        }

        function getState() {
            return datacontext.getState().then(function (data) {
                vm.canvasName = data.name;
                vm.canvas.config = data.config;
                vm.canvas.widgets =  setCanvasOrder(data.widgets);

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

        function setCanvasOrder(canvasData){
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
    // Controller for all functions related to header/menu.
    angular.module('canvas')
        .controller('headerController', headerController);

    headerController.$inject = ['$scope', '$http', '$location', '$window', '$rootScope', 'ngDialog', '$cookies'];
    function headerController($scope, $http, $location, $window, $rootScope, ngDialog,$cookies) {
        $scope.isOnPartnerList = false;
        $scope.allReady = false;
        // hover state for hamburger menu svg bars...
        $scope.hamburgerHover = function(){
            var result2 = document.getElementsByClassName("material-design-hamburger__layer");
            var wrappedResult2 = angular.element(result2);
            wrappedResult2.css("background", "gray");
        };
        $scope.HamburgerUnhover = function() {
            var result2 = document.getElementsByClassName("material-design-hamburger__layer");
            var wrappedResult2 = angular.element(result2);
            wrappedResult2.css("background", "white");
        };
        $scope.getMessagesUnseenCount = function() {
            return $http.get('/conv/unseen/count/' , {}
            );
        };
        $scope.getMemberProfileId = function() {
            return $http.get('/generic/can_access_messaging/', {
            });
        };
        // show member profile dynamic link + get link url
        $scope.getMemberProfileId()
          .then(function(data) {
              console.log(data);
              $scope.showMemberProfileLink = data.data.messaging;
              console.log("$scope.showMemberProfileLink" + $scope.showMemberProfileLink);
          });
        $scope.gotoProfile = function(){
            $scope.getMemberProfileId()
              .then(function(data) {
                  console.log(data);
                  if(data.data.member_id != undefined) {
                      $scope.memberId = data.data.member_id;
                      var memberProfilePage = "//" + $window.location.host + "/member/profile/" + memberId + "/";
                      $window.location.href = memberProfilePage;
                  }
              });

        };

        /*
        $scope.getMessagesUnseenCount().then(function (data) {
            $rootScope.messageCount =  data.data['unseen'];
            console.log("$rootScope.messageCount" + $rootScope.messageCount);
        }).catch(function (error) {
            console.log('Error occurred');
        });*/

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
        }else{
            $rootScope.storageAvailable = false;
            var result2 = document.getElementsByClassName("presentation");
            var wrappedResult2 = angular.element(result2);
            wrappedResult2.css("display", "none");
        }

        $scope.getPartnerInfo = function() {
            return $http.get('/generic/partner_info/', {}
            );
        };

        $scope.getUserInfo = function() {
            if($rootScope.user_id2){
                $rootScope.isOBO = true;
                return $http.get('/generic/user_info/' + $rootScope.user_id2 + '/' , {}
                );
            }else{
                $rootScope.isOBO = false;
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

              //return $scope.getPartnerInfo();
          }).catch(function (error) {
            $rootScope.loadingCanvas = false;
            console.log('Error occurred');
        });




        $scope.openCanvasVideo = function () {
            var imentor_cdn_prefix =  '';//typeof getCdnUrlPrefix == 'function' ? getCdnUrlPrefix() : '';

            $cookies.put('canvasVideo', true);
            ngDialog.open({
                template: imentor_cdn_prefix + '/new_platform/static/canvas/nghtml/canvasVimeo.html',
                controller: ['$scope', function ($scope) {
                    $scope.closeSurvey = function(){
                        ngDialog.closeThisDialog();
                    };
                }],
                className: 'ngdialog-theme-plain custom-width',
                showClose: true,
            });
        };
        // review button on finish page
        $scope.reviewWork = function () {
            var canvasUrl = "//" + $window.location.host + "/canvas/#/";
            $window.location.href = canvasUrl;
        };
        // function to show canvas video to specified partners.
        $scope.isOnPartnerList = function(){
            var currDomain = $location.host();
            var ch = currDomain.split(".")[0];
            //var ch = 'mentor2';
            console.log("ch: " + ch);
            var partners = ['mentor2','bbbspgh','bbbscharlotte','bbbswillgrundy','bbbsc','bbbscil','nyc','chicago','platformtraining','bbbsmilwaukee', '127'];
            var a = partners.indexOf(ch);
            //console.log(a);
            if(a !== -1){
                $scope.isOnPartnerList = true;
                return true;
            }
            else{
                $scope.isOnPartnerList = false;
                return false;
            }
        };

        // ----------------------------------------------------------------------------------
        $scope.isOnPartnerListTableau = function(){
            var currDomain = $location.host();
            var ch = currDomain.split(".")[0];
            $scope.subdomain = ch;
            //var ch = 'mentor2';
            console.log("ch: " + ch);

            // link will only show for following partners
            var partners = [
                'nyc',
                'bayarea',
                'platformtraining',
                'chicago',
                'mentor2',
                'bbbscil',
                'bbbs-cnm',
                'bbbscharlotte',
                'bbbsc',
                'bbbspgh',
                'bbbstx',
                'bbbsmilwaukee',
                'bbbsu',
                'bbbswillgrundy',
                'tennesseebig',
                'tucsonbigs',
                'bbbsmb',
                'bbbsmiami',
                '127'];

            var a = partners.indexOf(ch);
            //console.log(a);
            if(a !== -1){
                $scope.isOnPartnerListTableau = true;
            }
            else{
                $scope.isOnPartnerListTableau = false;
            }
        };

        $scope.isOnPartnerListTableau();
        var domainUrls = {
            'bayarea':'/dw_reports/S_T_E_V_E_BAY/ProgramManagerSummary/',
            'nyc': '/dw_reports/S_T_E_V_E_NYC/ProgramManagerSummary/',
            'platformtraining': '/dw_reports/S_T_E_V_E_NYC/ProgramManagerSummary/',
            'chicago': '/dw_reports/S_T_E_V_E__CHI/ProgramManagerSummary/',
            'mentor2': '/dw_reports/ProgramEngagement-BigBend/Summary/',
            'bbbscil': '/dw_reports/ProgramEngagement-CentralIllinois/Summary/',
            'bbbs-cnm': '/dw_reports/ProgramEngagement-CentralNewMexico/Summary/',
            'bbbscharlotte': '/dw_reports/ProgramEngagement-Charlotte/Summary/',
            'bbbsc': '/dw_reports/ProgramEngagement-Colorado/Summary/',
            'bbbspgh': '/dw_reports/ProgramEngagement-GreaterPittsburgh/Summary/',
            'bbbstx': '/dw_reports/ProgramEngagement-LoneStar/Summary/',
            'bbbsmilwaukee': '/dw_reports/ProgramEngagement-Milwaukee/Summary/',
            'bbbsu': '/dw_reports/ProgramEngagement-Utah/Summary/',
            'bbbswillgrundy': '/dw_reports/ProgramEngagement-WillandGrundy/Summary/',
            'tennesseebig': '/dw_reports/ProgramEngagement-Tennessee/Summary/?:iid=9',
            'tucsonbigs': '/dw_reports/ProgramEngagement-Tucson/Summary/?:iid=10',
            'bbbsmb': '/dw_reports/ProgramEngagement-MassBay/Summary/?:iid=11',
            'bbbsmiami':'/dw_reports/ProgramEngagement-Miami/Summary/',
            '127': '/dw_reports/ProgramEngagement-BigBend/Summary/'
        };

        $scope.getProgramParticipationUrlAll = function(url) {
            var domainUrlFull = $location.protocol() + "://" + $location.host() + url;
            return $http.get(domainUrlFull, {});
          };

        $scope.getProgramParticipation = function(subdomain){

            console.log(subdomain);
            console.log("subdomain add" + domainUrls[subdomain]);
            var domainUrl = domainUrls[subdomain];
            if(domainUrl) {
                $scope.getProgramParticipationUrlAll(domainUrl).then(function (data) {
                    $scope.programUrl = data.data.standard_url;
                });
            }
        };

        $scope.getProgramParticipation($scope.subdomain);


// ----------------------------------------------------------------------------------
        $scope.logout = function () {
            var logoutUrl = "//" + $window.location.host + "/iuser/logout/";
            $window.location.href = logoutUrl;
        };
        //helper function to clear view history. Could be used on signout (but not used now as most pages are non angular).
        $scope.clearViewHistory = function() {
            console.log('clearViewHistory');
              $rootScope.$viewHistory = {
                  histories: { root: { historyId: 'root', parentHistoryId: null, stack: [], cursor: -1 } },
                  backView: null,
                  forwardView: null,
                  currentView: null,
                  disabledRegistrableTagNames: []
            };
        };


    }

})();
