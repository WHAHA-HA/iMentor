var app = angular.module('lesson_mgmt', ['ngResource','ui.bootstrap', 'ngHamburger', 'ngDialog','tasks','720kb.datepicker','ngRoute',
        'isteven-multi-select']);

app.config(function($interpolateProvider, $resourceProvider){

  $resourceProvider.defaults.stripTrailingSlashes = false;
  $interpolateProvider.startSymbol('[[');
  $interpolateProvider.endSymbol(']]');

});

app.config(['$routeProvider', function($routeProvider) {
  $routeProvider
    .when('/', {
      templateUrl: '/new_platform/static/lesson_mgmt/nghtml/schedule.html',
      title: 'Schedule'
    })
    .when('/scheduled', {
      templateUrl: '/new_platform/static/lesson_mgmt/nghtml/scheduled.html',
      title: 'Scheduled'
    });
}
]);

// Whitelist cdn 
app.config(['$sceDelegateProvider', function($sceDelegateProvider){
    $sceDelegateProvider.resourceUrlWhitelist([
        // Allow same origin resource loads.
        'self',
        // Allow loading from outer templates domain.
        'https://cdn.imentor.org/**'
    ]); 
}]);


app.controller('scheduledController', function ($scope, $http, $location, $window, $rootScope) {

  $('body').css({'background': 'url(/new_platform/static/lesson_mgmt/img/lesson_mgmt_04.png' + ')' + 'no-repeat center center fixed'});
  $('body').css({'background-size': 'cover'});
  $("#lesson-mgmt-body").css({'background-color':'transparent'});

});
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

app.controller('MainCtrl',[
  '$scope',
  '$http',
  '$location',
  '$rootScope',
  '$timeout',
  function($scope,$http,$location,$rootScope,$timeout) {
    /**
     * init variables
     */
    $("#lesson-mgmt-body").css({'background-color':'white'});
    $scope.showbanner = false;
    $scope.loaded = false;


    $scope.selectedGrade = "";
    $scope.selectedUnit = "";
    $scope.selectedLesson = "";
    $scope.selectedPartner = "";
    $scope.selectedPartnerSites = [];
    $scope.partnerSitesLang = {
        selectAll: 'Choose all',
        selectNone: 'Choose none',
        reset: 'Reset choice',
        search: 'Search...',
        nothingSelected: 'Choose a class'
    };
    $scope.lesson= new Date();
    $scope.deleteText = "";

    $rootScope.loadPartners = false;
    $rootScope.scheduleDone = false;

    //console.log($scope.lesson);
    //console.log(dateValue);
    $scope.updateGrade = function(selectedGrade){
      //console.log(selectedGrade);
      $scope.newGrade = selectedGrade;
      return selectedGrade;
    }
    $scope.updateUnit= function(selectedUnit){
      //console.log(selectedUnit);
    }
    $scope.updateLesson = function(selectedLesson){
      //console.log(selectedLesson);
    }
    
    $scope.geContent = function(){
        $scope.selectedLessonId = undefined;
        $scope.selectedLesson = undefined;

        if($scope.selectedPartner != "") {
          $http.post('/canvas/get_assigned_lessons/', {
            partner_id: $scope.selectedPartner.id
          })
          .success(function (data, status, headers, config) {
            console.log(data);
            $scope.scheduledLessons = data;
            //$location.path('/scheduled');
          })
          .error(function (data, status, headers, config) {
            console.log("Error scheduling lessson");

          });
        } else {
             $scope.scheduledLessons = [];
        }
    }

    $scope.updatePartner = function() {
        //var partnerIds = _.pluck($scope.selectedPartnerSites, 'id');
        $scope.selectedPartner = $scope.selectedPartnerSites.length === 0 ? "" : $scope.selectedPartnerSites[0];
        $scope.geContent();
    };

    $scope.resetPartner = function() {
        $scope.selectedPartnerSites = [];
        $scope.selectedPartner = "";
        $scope.geContent();
    };

    $scope.updateLessonSelection = function(lesson) {
        $scope.showDelete = false;
        if (lesson.curriculum_id === $scope.selectedLessonId) {
            $scope.selectedLessonId = undefined;
            $scope.selectedLesson = undefined;
        } else {
            $scope.selectedLessonId = lesson.curriculum_id;
            $scope.selectedLesson = lesson;
        }
    }

    $scope.toggled = function (open){
      $scope.showDelete = false;
      $scope.deleteText = "";
    }
    
    $scope.showDeleteBox = function () {
      $timeout(function() {
        $scope.showDelete = true;
      },300);
      
    }

    $scope.confirmDelete = function () {
      if($scope.deleteText==='delete') {
        $scope.deleteLesson();     
        $scope.showDelete = false;
      }
    }

    $scope.cancelDelete = function () {
      $scope.showDelete = false;
    }

    $scope.deleteLesson = function() {

            var partner_id = $scope.selectedLesson.partner_id;
            var curriculum_id = $scope.selectedLesson.curriculum_id;
            var session_id = $scope.selectedLesson.session_id;
            
            $http.post('/canvas/delete_lessons/', {
              partner_id: $scope.selectedLesson.partner_id,
              curriculum_id: $scope.selectedLesson.curriculum_id,
              session_id: $scope.selectedLesson.session_id
            })
            .success(function (data, status, headers, config) {
              console.log(data);
              $scope.showDelete = false;
               $scope.geContent();
            })
            .error(function (data, status, headers, config) {
              console.log("Error deleting lessson");
               $scope.showDelete = false;
            });
        }


    /* --- TIME Settings --- */
    $scope.mytime = new Date();

    $scope.hstep = 1;
    $scope.mstep = 1;

    $scope.options = {
      hstep: [1, 2, 3],
      mstep: [1, 5, 10, 15, 25, 30]
    };

    $scope.ismeridian = true;
    $scope.toggleMode = function () {
      $scope.ismeridian = !$scope.ismeridian;
    };
    $scope.updateHours = function(){
      //console.log("hours!!");
    }
    $scope.update = function () {
      //console.log("update!");
      var d = new Date();
      d.setHours(14);
      d.setMinutes(0);
      $scope.mytime = d;
    };

    $scope.changed = function (mytime) {
      //console.log("changed!");
      var el = angular.element(document.querySelectorAll('.form-group input'));
      //console.log(el);
      //var el = document.getElementsByClassName("form-group")[0];
      el.attr("type", "number");
    };

    $scope.clear = function () {
      $scope.mytime = null;
    };
    /* --- End of TIME Settings --- */

    // --- API Calls ---
    $scope.loadPartnerSites = function () {
      //http://127.0.0.1:8000/generic/partner_info/
      return $http.get('/generic/partner_info/', {});
    };

    $scope.loadCurriculum = function () {
      //http://127.0.0.1:8000/canvas/curricula/
      return $http.get('/canvas/curricula/', {});
    };

    $scope.loadPartnerSites()
      .then(function (res) {
        $scope.classes = res.data;
        return $scope.loadCurriculum();
      })
      .then(function (res) {
        $scope.curriculum = res.data;

       // console.log($scope.curriculum);
        $scope.loaded = true;
        $rootScope.loadPartners = true;
      })
      .catch(function (error) {
        console.log('Error occurred');
      });
    $scope.scheduleAnother = function(){
      $location.path('/');
    }
    $scope.scheduleLesson = function () {
      var partners = [];
      $rootScope.scheduling = true;
      var month = $scope.lesson.sch_date.split("/")[0];
      var day = $scope.lesson.sch_date.split("/")[1];
      var year = $scope.lesson.sch_date.split("/")[2];

      //console.log("month: " + month + " day " + day + " year" + year);
      //console.log("time: " +  $scope.mytime);
      var hour = $scope.mytime.getHours();
      var minutes = $scope.mytime.getMinutes();

      partners.push($scope.selectedPartner.id);

      $http.post('/canvas/assign_lessons/', {
        start_year: parseInt(year),
        start_month: parseInt(month),
        start_day: parseInt(day),
        start_hour: hour,
        start_min: minutes,
        curriculum_id: $scope.selectedLesson,
        partner_ids: partners
      })
        .success(function (data, status, headers, config) {
         //console.log(data);
          $rootScope.scheduling = false;
          $rootScope.scheduleDone = true;
          $location.path('/scheduled');

          if(data.success == false) {
            alert("Please contact iMentor Platform Support\nto investigate a scheduling error for this lesson.");
          }
        })
        .error(function (data, status, headers, config) {
          console.log("Error scheduling lessson");

        });
    }}]);

app.filter('unique', function () {
  return function (items, filterOn) {

    if (filterOn === false) {
      return items;
    }

    if ((filterOn || angular.isUndefined(filterOn)) && angular.isArray(items)) {
      var hashCheck = {}, newItems = [];

      var extractValueToCompare = function (item) {
        if (angular.isObject(item) && angular.isString(filterOn)) {

          var resolveSearch = function (object, keyString) {
            if (typeof object == 'undefined') {
              return object;
            }
            var values = keyString.split(".");
            var firstValue = values[0];
            keyString = keyString.replace(firstValue + ".", "");
            if (values.length > 1) {
              return resolveSearch(object[firstValue], keyString);
            } else {
              return object[firstValue];
            }
          }

          return resolveSearch(item, filterOn);
        } else {
          return item;
        }
      };

      angular.forEach(items, function (item) {
        var valueToCheck, isDuplicate = false;

        for (var i = 0; i < newItems.length; i++) {
          if (angular.equals(extractValueToCompare(newItems[i]), extractValueToCompare(item))) {
            isDuplicate = true;
            break;
          }
        }
        if (!isDuplicate) {
          if (typeof item != 'undefined') {
            newItems.push(item);
          }
        }

      });
      items = newItems;
    }
    return items;
  };
});

app.directive('bDatepicker', function () {
  return {
    restrict: 'A',
    link: function (scope, el, attr) {
      el.datepicker({});
      var component = el.siblings('[data-toggle="datepicker"]');
      if (component.length) {
        component.on('click', function () {
          el.trigger('focus');
        });
      }
    }
  };
});

app.filter('property', property);

function property(){
  function parseString(input){
    return input.split(".");
  }

  function getValue(element, propertyArray){
    var value = element;

    _.forEach(propertyArray, function(property){
      value = value[property];
    });

    return value;
  }

  return function (array, propertyString, target){
    var properties = parseString(propertyString);

    return _.filter(array, function(item){
      return getValue(item, properties) == target;
    });
  }
}




