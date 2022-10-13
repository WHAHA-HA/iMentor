var controllers = angular.module('ccControllers', ['ccServices','ChatModule']);

controllers
  .controller('CollegeSearchController',[
    '$http', '$scope', '$modal', '$q', 'CollegeSearch', 'CollegePicks', 'dateFunc',
    function($http, $scope, $modal, $q, CollegeSearch, CollegePicks, dateFunc){
    //function($scope){
      var image = "checklist_pg2_bg.jpg";
      $('body').css({'background': 'url(/new_platform/static/cchklist/img/' + image + ')' + 'no-repeat center center fixed'});
      $('body').css({'background-size': 'cover'});
      $scope.checklist = Object;
      $scope.checklist.selected_colleges = [];
      //Placeholder value for test user_id

      $scope.message = '';
      $scope.placeholder = 'Search for colleges';
      $scope.today = new Date();

      var t = moment($scope.today);
      $scope.minDate =new Date(t.subtract(6, 'months').toDate());

      t = moment($scope.today);
      $scope.maxDate =new Date(t.add(6, 'months').toDate());

      $scope.YES = 1;
      $scope.NA = 2;
      $scope.NOT_SELECTED = 0;

      $scope.cpyColleges = [];

      /**
       * IT will be used to iterate 4 college types counting 'Not sure'
       */

      $scope.editColleges = function(){
        location.href = '/cchklist/list/#/';
      };

	    //GET user's list of checklist.selected_colleges
      var getPicks = function() {
        CollegePicks.getList()
        .success(function(response){

          // convert the dates
          for (var i=0; i<response.length; i++) {
            var ele = response[i]
            ele.app_submission = dateFunc.convert(ele.app_submission);
            ele.app_deadline = dateFunc.convert(ele.app_deadline);
          }

          $scope.checklist.selected_colleges = response;
          angular.copy(response, $scope.cpyColleges);

        })
        .error(function(error){
          $scope.picks_error = "Sorry, there are no college picks for this user.";

        });

      };

      /**
       * calculate percentage based on objects
       * @param checklist
       */
      $scope.getProgressPercentage = function(college) {

        var progress = 0;
        var total = 0;

        //n/a = 2
        //yes = 1
        //0 or null = nothing, NOT SELECTED

        /**
         * 10 checklist properties and result attribute
         */
        //
        //app_completion: 0
        //app_deadline: null
        //app_review: 0
        //app_submission: null
        //category: 1
        //choice: 0
        //college: Object
        //essay_submission: 0fafsa_submission: 0fee_payment: 0id: 1recommendation_submission: 0
        //result: 0test_submission: 0transcript_submission: 0

        for(var key in college) {
          if (key != 'app_completion' && key != 'app_deadline' && key != 'app_review'
            && key != 'app_submission' && key != 'essay_submission' && key != 'fafsa_submission'
            && key != 'fee_payment' && key != 'recommendation_submission' && key != 'result'
            && key != 'test_submission' && key != 'transcript_submission' && key != 'choice'
          ) {
            continue;
          }

          var value = college[key];
          total++;
          if (value !==$scope.NOT_SELECTED && value !==null && value !=='' ) {
            progress++;
          }
        }


        return progress/total * 100;
      };


      //based on choice field it will be 'success' or not
      $scope.getCollegeChoiceType = function (college){
        if (college.choice === $scope.YES) {
          return 'success';
        }
        else {
          return '';
        }
      };


      // on list page
      $scope.updateCollegeWithDeadline = function(college) {
        if (isNaN(Date.parse(college.app_deadline)) === true ) {
          alert('Invalid Date');
          return;
        }
        return CollegePicks.updateCollege(college)
          .success(function(response){

            console.log(college);
            /**
             * Update Main College with updated college info
             */
            if (response.success == true) {
              angular.copy(college, $scope.getCollegeById(college.id,$scope.cpyColleges));
            }
            else {
              /**
               * Rollback current college from cpycolleges
               */
              angular.copy($scope.getCollegeById(college.id,$scope.cpyColleges), college);
            }


          })
          .error(function(reason){

            console.log(reason);
            /**
             * Rollback current college from cpycolleges
             */
            angular.copy($scope.getCollegeById(college.id,$scope.cpyColleges), college);

          });
      };

      $scope.updateCollege = function(college) {

        return CollegePicks.updateCollege(college)
          .success(function(response){

            console.log(college);
            /**
             * Update Main College with updated college info
             */
            if (response.success == true) {
              angular.copy(college, $scope.getCollegeById(college.id,$scope.cpyColleges));
            }
            else {
              /**
               * Rollback current college from cpycolleges
               */
              angular.copy($scope.getCollegeById(college.id,$scope.cpyColleges), college);
            }


          })
          .error(function(reason){

            console.log(reason);
            /**
             * Rollback current college from cpycolleges
             */
            angular.copy($scope.getCollegeById(college.id,$scope.cpyColleges), college);

          });
      };

      $scope.showCollegesModal = function(college) {

        var _this = $scope;

        var dlg = $modal.open({
          templateUrl: '/new_platform/static/cchklist/nghtml/colleges_modal.html',
          windowClass: 'colleges-progresswindow',
          controller: function ($scope, $modalInstance, college, colleges) {

            $scope.colleges = colleges;
            $scope.college = _this.getCollegeById(college.id,colleges);

            $scope.YES = 1;
            $scope.NA = 2;
            $scope.NOT_SELECTED = 0;

            /**
             * Used for result
             * @type {number}
             */
            $scope.ACCEPTED = 1;
            $scope.REJECTED = 2;
            $scope.WAITLISTED = 3;

            $scope.updateAttr = function(attr, value) {

              //if attr == 'choice' it will set No in other colleges.
              if (attr === 'choice' && value === $scope.YES) {
                for (var i=0; i< $scope.colleges.length; i++) {
                  var ele = $scope.colleges[i];
                  if (ele.id !== $scope.college.id) {

                    ele['choice'] = $scope.NA;

                    // update other college choice
//                    CollegePicks.updateCollege(ele);
                    _this.updateCollege(ele);
                  }
                }
              }

              if ($scope.college[attr] === value) {
                console.log($scope.college[attr]);
                $scope.college[attr] = $scope.NOT_SELECTED;
              }
              else if (attr!=='app_submission') {
                $scope.college[attr] = value;
              }

              // in case result is not ACCEPTED, ignore choice value
              if (attr == 'result' && value !== $scope.ACCEPTED) {
                $scope.college['choice'] = $scope.NOT_SELECTED;
              }

              return CollegePicks.updateCollege($scope.college)
                .success(function(response){

                  console.log($scope.college);

                  /**
                   * Update Main College with updated college info
                   */
                  if (response.success==true) {
                    angular.copy($scope.college, _this.getCollegeById($scope.college.id,_this.cpyColleges));
                  }
                  else {
                    /**
                     * Rollback current college from cpyColleges
                     */
                    angular.copy(_this.getCollegeById($scope.college.id,_this.cpyColleges), $scope.college);
                  }


                })
                .error(function(reason){

                  console.log(reason);
                  /**
                   * Rollback current college from cpycolleges
                   */
                  angular.copy(_this.getCollegeById($scope.college.id,_this.cpyColleges), $scope.college);

                });

            };

            //$scope.updateResultAttr= function(value) {
            //
            //  if ($scope.college.result === value) {
            //    $scope.college.result = $scope.NOT_SELECTED;
            //  }
            //  else {
            //    $scope.college.result = value;
            //  }
            //};

            //$scope.updateCollege = function(college) {
            //  $scope.college = _this.getCollegeById(college.id,$scope.colleges);
            //};

            $scope.save = function () {
              $modalInstance.close($scope.college);
            };

            $scope.close = function () {
              console.log($scope.college);
              $modalInstance.dismiss('cancel');
            };


          },
          resolve: {
            college: function () {
              return college;
            },
            colleges: function() {
              return $scope.checklist.selected_colleges;
            }
          }


        });

        return dlg.result.then(function (obj) {

          /**
           * If not changing the value, we have internal server error.
           */

          return $scope.updateCollege(obj);

        }, function (reason) {
          console.log('Close clicked');
        });
      };

      $scope.getCollegeById =function(collegeId, colleges) {

        for (var i=0; i< colleges.length; i++) {
          var ele = colleges[i];
          if (ele.id === collegeId) {
            return ele;
          }
        }

        return null;

      };

      function loadCollegeTypes() {

        var url = "/cchklist/picks/choices/";
        var deferred = $q.defer();

        $http.get(url, {})
          .then(function(response) {
            var data = response.data;
            $scope.collegeTypes = data;

            for (var i=0; i<data.length; i++) {

              var type = data[i];

              if (type.id == 1) {
                type.class='target-schools';
              }
              else if (type.id == 2) {
                type.class='safety-schools';
              }
              else if (type.id == 3) {
                type.class='reach-schools';
              }
              else if (type.id == 4) {
                type.class='notype-schools';
              }

            }

            deferred.resolve(data);

          }, function(error) {
            console.log(error);
            deferred.reject(error);
          });

        return deferred.promise;
      }
//
//
 //Fetch CollegeTypes and user's college picks on DOM load
      loadCollegeTypes()
        .then(function(collegeTypes){
          getPicks();
        });


  }])

controllers
.controller('headerController',[
  '$http', '$scope', '$rootScope','$location','$window',
  function($http, $scope, $rootScope,$location,$window) {

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
      'tennesseebig': '/dw_reports/ProgramEngagement-Tennessee/Summary?:iid=9',
      'tucsonbigs': '/dw_reports/ProgramEngagement-Tucson/Summary?:iid=10',
      'bbbsmb': '/dw_reports/ProgramEngagement-MassBay/Summary?:iid=11',
      'bbbsmiami':'/dw_reports/ProgramEngagement-Miami/Summary',
      '127': '/dw_reports/ProgramEngagement-BigBend/Summary/'
    };


    $scope.getProgramParticipationUrlAll = function(url) {
      return $http.get(url, {});
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
      }).catch(function (error) {
      $rootScope.loadingCanvas = false;
      console.log('Error occurred');
    });





    $scope.logout = function () {
      var logoutUrl = "//" + $window.location.host + "/iuser/logout/";
      $window.location.href = logoutUrl;
    };

  }]);
