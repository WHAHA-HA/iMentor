var controllers = angular.module('ccControllers', ['ccServices','ChatModule']);

controllers
  .controller('CollegePickController',[
    '$scope', '$modal', '$http', '$location', 'CollegeSearch', 'CollegePicks', '$window', '$q',
    function($scope, $modal, $http, $location, CollegeSearch, CollegePicks, $window, $q){
console.log("checklist 1")
      /**
       * Initialize the colleges
       * @type {$item|*}
       */
      $scope.colleges = [];

      $scope.NONE = 0;

      $scope.currentPath = $location.path();

      $scope.loadColleges = function() {

        return CollegePicks.getList()
          .then(function(response){
            $scope.colleges = response.data;
          }, function(reason){
            console.log(reason);
            $scope.picks_error = 'Error while loading colleges';

          });
      };

      // validation function checks whether user has selected a school type for all his school picks.
      // doesn't allow user to proceed until all picks havea chosen category.
      $scope.checkValid = function() {
        angular.forEach($scope.colleges, function (school, index) {
          if (school.category_id === 0) {
            $scope.fieldNotSel = true;
          }
        });
      };

      $scope.updateProgress = function(){
        console.log(" $scope.fieldNotSel: " +  $scope.fieldNotSel);
        if($scope.fieldNotSel === false){
          $window.location.href = '/cchklist/progress/#/';
        }
        else{
          $scope.fieldNotSel = true;
        }
      };

	    //GET user's list of colleges
      $scope.getCollegePicks = function(filter) {

        return CollegeSearch.getList(filter)
          .then(function(response){
            return response.data;
          }, function(reason){
            console.log(reason);
            $scope.picks_error = 'Error while picking colleges';

          });
      };

      /**
       * college
       * @param $item
       * @param $model
       * @param $label
       */
      $scope.onSelect = function ($item, $model, $label) {

        var college = {
          category_id: $scope.NONE,
          college: {
            id: $item.id,
            name: $item.name
          }
        };

        return CollegePicks.updateCollege(college)
          .success(function(response){
            if (response.success == true ){
              college.id = response.id;
              $scope.colleges.unshift(college);
              $scope.college = '';
            }
            else {
              console.log('error in add');
            }

          })
          .error(function(reason){

            console.log(reason);

          });

      };

      $scope.removeCollege = function(college) {
        return CollegePicks.deleteCollege(college)
          .success(function(response) {
            for (var i = 0; i < $scope.colleges.length; i++) {
              if ($scope.colleges[i] === college) {
                $scope.colleges.splice(i, 1);
                // check if all colleges have a type selected after removing one.
                $scope.fieldNotSel = false;
                $scope.checkValid();
                return;
              }
            }
            college.error = '';
          })
          .error(function(reason) {
            console.log (reason);
            college.error = 'Error while deleting college';
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

      $scope.updateCategoryId = function (college, categoryId) {

        if (college.category_id === categoryId) {
          college.category_id = $scope.NONE ;
          // trigger missing type validation for selection.
          $scope.fieldNotSel = true;
        }
        else {
          college.category_id = categoryId;

          // check if all colleges have a type selected after changing type selection.
          $scope.fieldNotSel = false;
          $scope.checkValid();
        }

        return CollegePicks.updateCollege(college)
          .success(function(response){
            college.error = '';
          })
          .error(function(reason){
            console.log(reason);
            college.error = 'Error while updating College';
          });

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

              if (type.name == 'Target') {
                type.class='target-schools';
                $scope.TARGET = type.id;
              }
              else if (type.name == 'Safety') {
                type.class='safety-schools';
                $scope.SAFETY = type.id;
              }
              else if (type.name == 'Reach') {
                type.class='reach-schools';
                $scope.REACH = type.id;
              }
              else if (type.name == 'Not sure') {
                type.class='notype-schools';
                $scope.UNSURE = type.id;
              }

            }

            deferred.resolve(data);

          }, function(error) {
            console.log(error);
            deferred.reject(error);
          });

        return deferred.promise;
      }

      /**
       * Initial Calls
       */
        //Fetch CollegeTypes and user's college picks on DOM load
      loadCollegeTypes()
        .then(function(collegeTypes){
          $scope.loadColleges();
        });
      // check if all colleges have a type selected on college load.
      $scope.fieldNotSel = false;
      $scope.checkValid();
  }]);

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
        console.log("$rootScope.useridnum" + $rootScope.useridnum);
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

      console.log('Error occurred');
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


    $scope.logout = function () {
      var logoutUrl = "//" + $window.location.host + "/iuser/logout/";
      $window.location.href = logoutUrl;
    };
  }]);
