(function() {
    'use strict';
    var controllerId = 'FlipbookController';
    angular.module('flipbook').controller(controllerId, FlipbookController);
    FlipbookController.$inject = ['$scope', '$interval', '$rootScope', 'ngDialog', '$location', 'datacontext'];

    function FlipbookController($scope, $interval, $rootScope, ngDialog, $location, datacontext) {
        var vm = this;

        function lsCheck() {
            var test = 'test';
            try {
                localStorage.setItem(test, test);
                localStorage.removeItem(test);
                return true;
            } catch (e) {
                return false;
            }
        }
        if (lsCheck() === true) {
            $rootScope.storageAvailable = true;
            console.log("avail");
        } else {
            $rootScope.storageAvailable = false;
            console.log("not avail");
            var result2 = document.getElementsByClassName("container");
            var wrappedResult2 = angular.element(result2);
            wrappedResult2.css("display", "none");
        }
        vm.partner_info = [];
        vm.new_content = [];
        vm.selectedPartner = {};
        vm.selectedPartnerids = [];
        vm.filter = "new";
        vm.searchString = "";
        vm.selectedPartnerSites = [];
        vm.filteredItems = [];
        vm.partnerSitesLang = {
            selectAll: 'Select All',
            selectNone: 'Select None',
            //reset: 'Reset choice',
            search: 'Search...',
            nothingSelected: 'Choose a class'
        };
        vm.useFixedHeader = true;
        if(isMobile.phone) {
            vm.useFixedHeader = false;
        }
        // hack for ben, will be deleted soon!
        var currDomain = $location.host();
        var ch = currDomain.split(".")[0];
        $rootScope.subdomain = ch;
        // -----------------------------------
        vm.updatePartnerAll = function() {
            if (vm.apiCall == true) {
                return;
            }
            var partnerIds = _.pluck(vm.partner_info, 'id');
            vm.selectedPartnerids = partnerIds;
            vm.selectedPartner = partnerIds.length === 0 ? undefined : partnerIds[0];
            getNewContent(vm.selectedPartnerids, vm.filter);
        };

        vm.updatePartner = function() {
            if (vm.apiCall == true) {
                return;
            }
            var partnerIds = _.pluck(vm.selectedPartnerSites, 'id');
            vm.selectedPartnerids = partnerIds;
            vm.selectedPartner = partnerIds.length === 0 ? undefined : partnerIds[0];
            getNewContent(vm.selectedPartnerids, vm.filter);
        };

        vm.resetPartner = function() {
            vm.selectedPartner = undefined;
            vm.selectedPartnerids = [];
            getNewContent(vm.selectedPartnerids, vm.filter);
        };
        vm.updateFilter = function(show) {
            vm.searchString = "";
            vm.filter = show;
            getNewContent(vm.selectedPartnerids, vm.filter);
        };
        vm.updateContentSelection = function(content) {
            if (content.content_id === vm.selectedContentId) {
                vm.selectedContentId = undefined;
                vm.selectedContent = undefined;
            } else {
                vm.selectedContentId = content.content_id;
                vm.selectedContent = content;
            }
        }
        vm.addFlag = function(flag_type_id) {
            $rootScope.savedNotification = true;
            $rootScope.saveSuccessNotification = false;
            var content_id = vm.selectedContent.content_id;
            var content_type = vm.selectedContent.content_type;
            return datacontext.addFlag(vm.selectedContent.flag_id, flag_type_id, vm.selectedContent.content_id, vm.selectedContent.content_type).then(function(data) {
                $rootScope.savedNotification = false;
                if (angular.isDefined(data.content_id)) {
                    var content = _.find(vm.new_content, function(o) {
                        return content_id == o.content_id && content_type == o.content_type;
                    });
                    if (content) {
                        content.flag_type_id = flag_type_id;
                        content.flag_id = data.flag_id;
                    }
                }
            });
        }
        vm.openContent = function(content, index) {
            vm.currentContent = content;

            ngDialog.open({
                template: '/new_platform/static/flipbook/nghtml/flipbox.html',
                controller: ['$scope','$rootScope','$timeout', function($scope, $rootScope, $timeout) {
                    $scope.currentContent = content;
                    $scope.currentContentIndex = index;
                    $scope.vm = vm;
                    $scope.vm.selectedContentId = $scope.currentContent.content_id;
                    $scope.vm.selectedContent = $scope.currentContent;
                    
                    $scope.next = function() {
                        //$rootScope.loadingFlipbook = true;
                        $scope.currentContentIndex++;

                        $scope.currentContent = $scope.vm.filteredItems[$scope.currentContentIndex];
                        $scope.vm.selectedContentId = $scope.currentContent.content_id;
                        $scope.vm.selectedContent = $scope.currentContent;
                        if($scope.currentContent.content_type == 'Conversation'){
                            $rootScope.openChatAdmin($scope.currentContent.content_link.split(',')[0], $scope.currentContent.content_link.split(',')[1], $scope.currentContent.content_link.split(',')[2]);
                        }
                    };

                    $scope.previous = function() {
                        //$rootScope.loadingFlipbook = true;
                        $scope.currentContentIndex--;

                        $scope.currentContent = $scope.vm.filteredItems[$scope.currentContentIndex];
                        $scope.vm.selectedContentId = $scope.currentContent.content_id;
                        $scope.vm.selectedContent = $scope.currentContent;
                        if($scope.currentContent.content_type == 'Conversation'){
                            $rootScope.openChatAdmin($scope.currentContent.content_link.split(',')[0], $scope.currentContent.content_link.split(',')[1], $scope.currentContent.content_link.split(',')[2]);
                        }
                    };

                    $scope.close = function() {   
                        ngDialog.close();
                    };

                    $scope.iframeLoaded = function(){
                        //$rootScope.loadingFlipbook = false;
                    }

                    
                    if($scope.currentContent.content_type == 'Conversation'){
                        $timeout(function() {
                            $rootScope.openChatAdmin($scope.currentContent.content_link.split(',')[0], $scope.currentContent.content_link.split(',')[1], $scope.currentContent.content_link.split(',')[2]);
                        }, 1000);
                    }
                }],
                className: 'ngdialog-theme-plain',
                showClose: false,
                $scope:  vm
            });
        };
        activate();

        $scope.$watchCollection("vm.filteredItems", function handleFooChange( newValue, oldValue ) {
                if(oldValue && oldValue != newValue) {
                    $rootScope.flipbookNoContent = newValue.length === 0 ? true : false;
                }
            }
        );

        $rootScope.$on('ngDialog.closing', function (e, $dialog) {
            $rootScope.loadingFlipbook = false;
            vm.updatePartner();
        });
        
        function activate() {
            sessionStorage.setItem("browser_session_id", (new Date()).getTime());
            getPartners();
        }

        function getPartners() {
            $rootScope.loadingFlipbook = true;
            return datacontext.getPartnerInfo().then(function(data) {
                vm.partner_info = data;
                $scope.showDropdown = vm.partner_info.length > 1;
                $rootScope.flipbookNoContent = data.length === 0 ? true : false;
                $rootScope.loadingFlipbook = false;
            });
        }

        function getNewContent(partner_ids, filter) {
            vm.selectedContentId = undefined;
            vm.selectedContent = undefined;

            vm.apiCall = true;
            if (partner_ids && partner_ids.length > 0) {
                $rootScope.loadingFlipbookNewContent = true;
                $rootScope.flipbookNoContent = false;
                datacontext.getNewContent(partner_ids, filter).then(function(data) {
                    vm.apiCall = false;

                    if (data.status && data.status === -1 && vm.selectedPartnerids.length > 0) {} else {
                        vm.new_content = data;
                        $rootScope.flipbookNoContent = data.length === 0 ? true : false;
                        $rootScope.loadingFlipbookNewContent = false;
                    }
                }, function(error) {
                    vm.apiCall = false;
                });
            } else {
                vm.apiCall = false;
                datacontext.cancelNewContentRequest();
                vm.new_content = [];
                $rootScope.loadingFlipbookNewContent = false;
                $rootScope.flipbookNoContent = false;
                vm.filter = "new";
            }
        }
    }
    // Controller for all functions related to header/menu.
    angular.module('flipbook').controller('headerController', headerController);
    headerController.$inject = ['$scope', '$http', '$location', '$window', '$rootScope', 'ngDialog', '$cookies'];

    function headerController($scope, $http, $location, $window, $rootScope, ngDialog, $cookies) {
        $scope.isOnPartnerList = false;
        $scope.allReady = false;
        // hover state for hamburger menu svg bars...
        $scope.hamburgerHover = function() {
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
            return $http.get('/conv/unseen/count/', {});
        };
        /*
        $scope.getMessagesUnseenCount().then(function (data) {
            $rootScope.messageCount =  data.data['unseen'];
            console.log("$rootScope.messageCount" + $rootScope.messageCount);
        }).catch(function (error) {
            console.log('Error occurred');
        });*/
        function lsCheck() {
            var test = 'test';
            try {
                localStorage.setItem(test, test);
                localStorage.removeItem(test);
                return true;
            } catch (e) {
                return false;
            }
        }
        if (lsCheck() === true) {
            $rootScope.storageAvailable = true;
        } else {
            $rootScope.storageAvailable = false;
            var result2 = document.getElementsByClassName("presentation");
            var wrappedResult2 = angular.element(result2);
            wrappedResult2.css("display", "none");
        }
        var currDomain = $location.host();
        console.log("$rootScope.showChat" + currDomain);
        var ch = currDomain.split(".")[0];
        $scope.subdomain = ch;
        var chatPartners = ['127', 'platformtraining'];
        $rootScope.showChat = chatPartners.indexOf(ch) != -1 || $location.host() == "nyc.imentordev.org";
        // user info for header bar and menu links
        $http({
            method: 'GET',
            url: '/generic/user_info/'
        }).then(function(data, status, headers, config) {
            console.log('user: ' + data.data.self.f_name);
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
            } else if (typeof data.data.mentee !== 'undefined' && typeof data.data.mentee.f_name !== 'undefined') {
                console.log("2");
                $rootScope.otherPersonMentee = data.data.mentee.f_name;
                $rootScope.otherMenteePhoto = data.data.mentee.photo;
                $rootScope.menteeId = data.data.mentee.user_id;
            }
            $scope.allReady = true;
            return data.data;
        }, function(error) {
            if(error.status == 403){
                $window.location.href = '/';
            }
            console.log(error);
            return error;
        });
        $scope.openCanvasVideo = function() {
            $cookies.put('canvasVideo', true);
            ngDialog.open({
                template: '/new_platform/static/canvas/nghtml/canvasVimeo.html',
                controller: ['$scope', function($scope) {
                    $scope.closeSurvey = function() {
                        ngDialog.closeThisDialog();
                    };
                }],
                className: 'ngdialog-theme-plain custom-width',
                showClose: true,
            });
        };
        // review button on finish page
        $scope.reviewWork = function() {
            var canvasUrl = "//" + $window.location.host + "/canvas/#/";
            $window.location.href = canvasUrl;
        };
        // function to show canvas video to specified partners.
        $scope.isOnPartnerList = function() {
            var currDomain = $location.host();
            var ch = currDomain.split(".")[0];
            //var ch = 'mentor2';
            console.log("ch: " + ch);
            var partners = ['mentor2', 'bbbspgh', 'bbbscharlotte', 'bbbswillgrundy', 'bbbsc', 'bbbscil', 'nyc', 'chicago', 'platformtraining', 'bbbsmilwaukee', '127'];
            var a = partners.indexOf(ch);
            //console.log(a);
            if (a !== -1) {
                $scope.isOnPartnerList = true;
                return true;
            } else {
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
        $scope.logout = function() {
            var logoutUrl = "//" + $window.location.host + "/iuser/logout/";
            $window.location.href = logoutUrl;
        };
        //helper function to clear view history. Could be used on signout (but not used now as most pages are non angular).
        $scope.clearViewHistory = function() {
            console.log('clearViewHistory');
            $rootScope.$viewHistory = {
                histories: {
                    root: {
                        historyId: 'root',
                        parentHistoryId: null,
                        stack: [],
                        cursor: -1
                    }
                },
                backView: null,
                forwardView: null,
                currentView: null,
                disabledRegistrableTagNames: []
            };
        };
    }

    angular.module('flipbook').directive('iframeOnload', [function(){
        return {
            scope: {
                callBack: '&iframeOnload'     },     link: function(scope, element, attrs){
                element.on('load', function(){
                    return scope.callBack();
                })     }
        }}
    ]);

})();
