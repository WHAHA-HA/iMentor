var app = angular.module('attendance', ['ngResource','ui.bootstrap', 'ngHamburger', 'ngDialog','ngRoute',
        'isteven-multi-select','fsm']);

app.config(function($interpolateProvider, $resourceProvider){

  $resourceProvider.defaults.stripTrailingSlashes = false;
  $interpolateProvider.startSymbol('[[');
  $interpolateProvider.endSymbol(']]');

});

app.config(['$routeProvider', function($routeProvider) {
  $routeProvider
    .when('/', {
      templateUrl: '/new_platform/static/attendance/nghtml/attendance.html',
      title: 'Attendance'
    })
}
]);

app.controller('headerController', function ($scope, $http, $location, $window, $rootScope) {
  $rootScope.loadPartners = false;
  $rootScope.scheduleDone = false;
  $rootScope.scheduling = false;

  var currDomain = $location.host();
  var ch = currDomain.split(".")[0];
  $scope.subdomain = ch;

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
  $scope.logout = function () {
    var logoutUrl = "//" + $window.location.host + "/iuser/logout/";
    $window.location.href = logoutUrl;
  }

  $http({method: 'GET', url: '/generic/user_info/'}).then(function (data, status, headers, config) {
    //console.log('user' + data.data);
    $rootScope.firstname = data.data.self.f_name;
    $rootScope.lastname = data.data.self.l_name;
    $rootScope.useridnum = data.data.self.user_id;
    $rootScope.userrole = data.data.self.role;
    $rootScope.persona = data.data.self.persona_id;

    return data.data;
  }, function (error) {
    console.log(error);
    return error;
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

});

app.controller('AttendanceCtrl',[
  '$scope',
  '$http',
  '$location',
  '$rootScope',
  '$timeout',
  function($scope,$http,$location,$rootScope,$timeout) {
console.log("hello attendance!");

    // API calls
    $scope.loadPartnerSites = function() {
      return $http.get('/generic/partner_info/', {
      });
    };

    $scope.getClassRoster = function(classId) {
      return $http.post('/attendance/class_roster/', {
        'partner_id': classId,
      });
    };

    $scope.getClassAttendance = function(partnerIds, period, index) {
      return $http.post('/attendance/lesson/', {
        'partner_id': 1840,
        'period': period,
      });
    };

    $scope.getAttendanceData = function() {
      return $http.post('/attendance/attendance_data/', {
        'partner_id': 1840,
        'curriculum_id' : 37,
      });
    };

    $scope.getAttendanceStats = function() {
      return $http.post('/attendance/attendance_statistics/', {
        'partner_id': 1840,
        'curriculum_id' : 37,
      });
    };

    $scope.updateAttendanceData = function(partnerId,userId,personaId,curriculumId,detailId) {
      return $http.post('/attendance/mentee_data/', {
        'partner_id': partnerId,
        'user_id': userId,
        'persona_id': personaId,
        'curriculum_id': curriculumId,
        'detail_id': detailId
      });
    };

    // /attendance/attendance_statistics/
// /attendance/mentee_data/


    $scope.loadPartnerSites()
      .then(function(data) {
        console.log(data);
        $scope.partnerSites = data.data;
    });

/*
    $scope.loadStudents = function(partnerIds){
      console.log("class id: " + partnerIds);
      $scope.getClassRoster(partnerIds).then(function(data) {
        console.log("class roster");
        console.log(data);
        $scope.class_students = data.data;
        $scope.getClassAttendance(partnerIds, 'current', 0);
        $scope.getClassAttendance(partnerIds, 'current_minus_1', 1);
        return $scope.getClassAttendance(partnerIds, 'current_minus_2', 2);
      }).then(function(data){
        console.log("class attendance");
        console.log(data);
        return $scope.getAttendanceData(partnerIds);
      }).then(function(data){
        console.log("class attendance stats");
        console.log(data);
      });
    };
*/

    /**
     * data loads:
     */
    $scope.localLang = {
      nothingSelected : "Choose a class"         //default-label is deprecated and replaced with this.
    }


    $scope.useFixedHeader = true;
    if(isMobile.phone) {
        $scope.useFixedHeader = false;
    }

    $scope.updatePage = function() {

      //clear past data
      $scope.selectedPartner1 = true;
      //var partnerIds = $scope.selectedPartner.id;
      var partnerIds = _.pluck($scope.selectedPartner, 'id')[0];
      console.log("selectedPartner" + partnerIds)

      if (partnerIds.length == 0) {
        return;
      }

      if ($scope.callsOnApi > 0) {
        return;
      }

      $scope.roster = null;
      $scope.lessons = [{}, {}, {}];

      //reset lesson info
      $scope.loadLessonDetail(partnerIds, 'current', 0);
      $scope.loadLessonDetail(partnerIds, 'current_minus_1', 1);
      $scope.loadLessonDetail(partnerIds, 'current_minus_2', 2);
      $scope.loadRoster(partnerIds);
    };
    //$scope.updatePage();

    // --- API Calls ---
    $scope.loadPartnerSites = function () {
      return $http.get('/generic/partner_info/', {});
    };
    $scope.select= function(index) {
      $scope.selected = index;
    };
    // load lesson detail
    $scope.loadLessonDetail = function(partnerIds, period, index) {

      $http.post( '/attendance/lesson/', {
          partner_id: partnerIds,
          period: period
        })
        .then(function(res) {

          $scope.lessons[index].description = res.data.lesson_description;
          $scope.lessons[index].lesson_start = res.data.lesson_start;
          $scope.lessons[index].lesson_end = res.data.lesson_end;
          $scope.lessons[index].curriculum_id = res.data.curriculum_id;

          if (null !== res.data.curriculum_id && 'NA' !== res.data.curriculum_id) {
            return $http.post ('/attendance/attendance_statistics/', {
              partner_id: partnerIds,
              curriculum_id: $scope.lessons[index].curriculum_id
            });
          }
          else {
            console.log('no curr id');
          }
        })
        .then(function(res) {
          // stats
          $scope.lessons[index].present_percentage = res.data.present_percentage;

          return $http.post ('/attendance/attendance_data/', {
            partner_id: partnerIds,
            curriculum_id: $scope.lessons[index].curriculum_id
          });
        })
        .then(function(res) {
          $scope.lessons[index].engagement = res.data;
          $scope.allready = true;
        })
        .catch(function(error) {
        });
    };

    $scope.studentData = function(student, lesson, detailId) {
      var partnerIds = _.pluck($scope.selectedPartner, 'id')[0];
      console.log(student.user_id);
      console.log(student.persona_id);
      console.log(lesson.curriculum_id);
      console.log($scope.selectedPartner.id);
      console.log(detailId);
      $rootScope.savingStudentData = true;
      return $http.post('/attendance/mentee_data/', {
        'partner_id': partnerIds,
        'user_id': student.user_id,
        'persona_id': student.persona_id,
        'curriculum_id': lesson.curriculum_id,
        'detail_id': detailId

      }).then(function (res) {
          return $http.post('/attendance/attendance_data/', {
            partner_id: partnerIds,
            curriculum_id: lesson.curriculum_id
        })
        .then(function (res) {
          $scope.lessons[0].engagement = res.data;
          $scope.allready = true;
          return $http.post('/attendance/attendance_statistics/', {
            partner_id: partnerIds,
            curriculum_id: lesson.curriculum_id
          })
        }).then(function(res){
              $scope.lessons[0].present_percentage = res.data.present_percentage;
              $rootScope.savingStudentData = false;
            }).catch(function (error) {
        });
      });
    }

    //load list of table
    $scope.loadRoster = function (partnerIds) {

      $http.post( '/attendance/class_roster/', {
          partner_id: partnerIds
        })
        .then(function(res) {
          $scope.roster= res.data;
        });
    };

    $scope.refresh = function() {
      $scope.updatePage();
    };


    //update Individual Selection
    $scope.updateRosterSelection = function(ele) {

      if (ele.selected === true) {
        ele.selected = false;
      }
      else {
        ele.selected = true;
      }

      $scope.updateGlobalSelection(ele.selected);
      $scope.updateAnySelection();
    };

    //update table selections
    $scope.updateSelections = function() {
      if ($scope.globalSelection === true) {
        $scope.globalSelection = false;
      }
      else {
        $scope.globalSelection = true;
      }
      _.each($scope.roster, function(ele) {
        ele.selected = $scope.globalSelection;
      });

      $scope.updateAnySelection();

    };

    // global selection
    $scope.updateGlobalSelection = function(selected) {

      var diff = _.find($scope.roster, function(ele){ return ele.selected !== selected; });

      if (diff) {
        $scope.globalSelection = false;
      }
      else if (selected === true) {
        $scope.globalSelection = true;
      }
      else {
        $scope.globalSelection = false;
      }
    };

    //any selection
    $scope.updateAnySelection = function() {

      var trueItem= _.find($scope.roster, function(ele){ return ele.selected === true; });

      if (trueItem) {
        $scope.anySelection = true;
      }
      else {
        $scope.anySelection = false;
      }
    };

    $scope.sendEmails = function(option) {
      var selectedItems = _.where($scope.roster, {selected: true});
      var bcc = '';

      if (!selectedItems || 0 == selectedItems.length) {
        alert('Please select the row');
      }
      else {
        _.each(selectedItems, function(ele) {
            bcc += ele.email + ',';
        });

        window.location.href = 'mailto:?bcc='+bcc;
        console.log('mailto:?bcc='+bcc);
      }

    };

  }]);






