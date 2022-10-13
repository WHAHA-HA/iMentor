var app = angular.module('portfolio', ['ngResource','ui.bootstrap', 'ngHamburger', 'ngDialog','ngRoute'
      ,'textAngular', 'colorpicker.module', 'ui.bootstrap.dropdownToggle', 'ngDialog','ngCookies', 
        'imBlockUI',
        'imImageSelector',
        'imEmbed',
        'mentio',
        'ngFileUpload',
        'irontec.simpleChat',
        'angular-notification-icons',
        'ChatModule'

        ]);

app.config(function($interpolateProvider, $resourceProvider){

  $resourceProvider.defaults.stripTrailingSlashes = false;
  $interpolateProvider.startSymbol('[[');
  $interpolateProvider.endSymbol(']]');
});

// Whitelist cdn 
app.config(['$sceDelegateProvider', function($sceDelegateProvider){
    $sceDelegateProvider.resourceUrlWhitelist([
        // Allow same origin resource loads.
        'self',
        // Allow loading from outer templates domain.
        'https://cdn.imentor.org/**'
    ]); 
}]);
/*
app.config(['$provide', function($provide) {
  $provide.decorator('taOptions', ['$delegate', function (taOptions) {
    taOptions.forceTextAngularSanitize = true; // set false to allow the textAngular-sanitize provider to be replaced
    taOptions.toolbar = [
      ['bold', 'italics', 'underline', 'quote', 'insertLink', 'insertImage']
    ];
    taOptions.classes = {
      focussed: 'focussed',
      toolbar: 'btn-toolbar',
      toolbarGroup: 'btn-group',
      toolbarButton: 'btn btn-default',
      toolbarButtonActive: 'active',
      disabled: 'disabled',
      textEditor: 'form-control',
      htmlEditor: 'form-control'
    };
    return taOptions;
  }]);
}]);
*/
app.config(['$routeProvider', function($routeProvider) {
  $routeProvider
    .when('/', {
      templateUrl: '/new_platform/static/portfolio/nghtml/portfolio.html',
      title: 'Portfolio'
    })
    .when('/grade/:grade_id/unit/:unit_id/', {
      templateUrl: '/new_platform/static/portfolio/nghtml/specific_portfolio_unit.html',
      title: 'Unit'
    })
    .when('/finish', {
      templateUrl: '/new_platform/static/portfolio/nghtml/finish.html',
      title: 'Finish Lesson'
    })
    .when('/resources', {
      templateUrl: '/new_platform/static/portfolio/nghtml/resources.html',
      title: 'Resources'
    });
}
]);

app.controller('headerController', function ($scope, $http, $location, $window, $rootScope, ngDialog,$cookies) {
  $rootScope.loadPartners = false;
  $rootScope.scheduleDone = false;
  $rootScope.scheduling = false;
  $rootScope.isResources =false;
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
  $scope.openPortfolioVideo = function () {
    $cookies.put('PortfolioVideo', true);
    ngDialog.open({
      template: '/new_platform/static/portfolio/nghtml/PortfolioVimeo.html',
      controller: ['$scope', function ($scope) {
        $scope.closeSurvey = function(){
          ngDialog.closeThisDialog();
        }
      }],
      className: 'ngdialog-theme-plain custom-width',
      showClose: true,
    });
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
      if(data.status == 403) {
          $window.location.href = '/';
      }
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
      if(error.status == 403) {
          $window.location.href = '/';
      }
    $rootScope.loadingCanvas = false;
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

app.controller('PortfolioCtrl',[
  '$scope',
  '$http',
  '$location',
  '$rootScope',
  '$window',
  '$routeParams',
  '$anchorScroll',
  function($scope,$http,$location,$rootScope,$window,$routeParams,$anchorScroll) {
    $scope.init  = function(user_id) {
      $rootScope.user_id2 = user_id;
      console.log("$rootScope.user_id2" + $rootScope.user_id2);
    }

    $scope.getUserInfo = function() {
      if($rootScope.user_id2){
        return $http.get('/generic/user_info/' + $rootScope.user_id2 + '/' , {}
        );
      }else{
        return $http.get('/generic/user_info/' , {}
        );
      }

    };

    $scope.getUserGrades = function() {
      if($rootScope.user_id2) {
        return $http.post(' /portfolio/scheduled_grades/'  + $rootScope.user_id2 + '/', {});
      }
      else{
        return $http.post(' /portfolio/scheduled_grades/', {});
      }
    };

    $scope.getScheduledUnits = function(grade) {
      if($rootScope.user_id2) {
        return $http.post('/portfolio/scheduled_units/' + $rootScope.user_id2 + '/', {
          'grade_id': grade
        });
      }
      else{
        return $http.post('/portfolio/scheduled_units/' , {
          'grade_id': grade
        });
      }
    };



    $scope.subdomain = $window.location.host;

    $scope.updateGrade = function(grdObj, newGrade, grade_num){
            $rootScope.inaccessibleLesson = false;
      $rootScope.loadingCanvas = true;

      console.log(newGrade + ", " + grade_num);
      $scope.theGrade = grdObj;
      $scope.selectedGrade = newGrade;
      $scope.grade_number = grade_num;
      $scope.grade_description = grdObj.grade_description;
      return $scope.getScheduledUnits($scope.selectedGrade)
      .then(function (data) {
        if(data.status == 403) {
          $window.location.href = '/';
      }
      $scope.scheduledUnits = data.data;
      $rootScope.loadingCanvas = false;
      }).catch(function(error){
        if(error.status == 403) {
          $window.location.href = '/';
      }
         $rootScope.loadingCanvas = false;
         $rootScope.inaccessibleLesson = true;
      });
    };

    $scope.getUserInfo()
      .then(function (data) {

        if(data.status == 403) {
            $window.location.href = '/';
        }
        $scope.user_info = data.data;
        $rootScope.useridnum = data.data.self.user_id;


        //for obo - to show other parties profile info in reflection card
        $rootScope.useridnum = data.data.self.user_id;
        $rootScope.userrole = data.data.self.role;
        $rootScope.persona = data.data.self.persona_id;
        $rootScope.match_status = data.data.self.match_status;
        if(typeof data.data.mentor !== 'undefined' && typeof data.data.mentor.f_name !== 'undefined'){
         // console.log("1" + data.data.mentor.f_name);
          $rootScope.otherPersonMentor = data.data.mentor.f_name;
          $rootScope.otherMentorPhoto = data.data.mentor.photo;
        }
        else if(typeof data.data.mentee !== 'undefined' && typeof data.data.mentee.f_name !== 'undefined'){
          console.log("2");
          $rootScope.otherPersonMentee = data.data.mentee.f_name;
          $rootScope.otherMenteePhoto = data.data.mentee.photo;
        }
        else if($rootScope.userrole == 'Mentor'){
          console.log("Mentor");
          $rootScope.otherPersonMentee = " ";
        }
        else if($rootScope.userrole == 'Mentee'){
          console.log("Mentee");
          $rootScope.otherPersonMentor = " ";
        }

        $rootScope.loadingCanvas = true;
        return $scope.getUserGrades($rootScope.useridnum);
      })
      .then(function(data) {
        if(data.status == 403) {
            $window.location.href = '/';
        }
        $scope.userGrades = data.data;
        $scope.showDropdown = $scope.userGrades.length > 1;
        $rootScope.noLessonsScheduled = $scope.userGrades.length == 0;
        $scope.selectedGrade = data.data[0];
        if(data.data[0]) {
          $scope.grade_number = data.data[0].grade_number;
          $scope.grade_description = data.data[0].grade_description;
          return $scope.getScheduledUnits($scope.selectedGrade.grade_id);
        }
      }).then(function (data) {
        
        $rootScope.loadingCanvas = false;
        if(data){
          if(data.status == 403) {
              $window.location.href = '/';
          }
          $scope.scheduledUnits = data.data;
          if(!angular.isDefined($scope.scheduledUnits) || $scope.scheduledUnits.length === 0 ) {
            $rootScope.noUnitsAvailable = true; 
          } else {
            $rootScope.noUnitsAvailable = false; 
          }
        }
      }).catch(function (error) {
      if(error.status == 403) {
          $window.location.href = '/';
      }
      $rootScope.loadingCanvas = false;
      $rootScope.inaccessibleLesson = true;
      console.log('Error occurred');
    });
    
    $scope.go = function ( path, description ) {
      $location.path( path );
      $rootScope.unitDescription = description;
    };
    $scope.goHref = function ( path ) {
      var newUrl = '//' + $scope.subdomain  + path + '/';
      $window.location.href = newUrl;
    };

    $scope.gotoTop = function() {
      $(window).scrollTop(0);
    };
    }
]);

app.controller('UnitCtlr',[
  '$scope',
  '$http',
  '$location',
  '$rootScope',
  '$window',
  '$routeParams',
  '$interval',
  '$timeout',
  '$element',
  'textAngularManager',
  '$anchorScroll',
  '$route',
  function($scope,$http,$location,$rootScope,$window,$routeParams,$interval,$timeout,$element,textAngularManager,$anchorScroll,$route) {


    $scope.reflectionHtml;

    var connectionTimeout = 10000;

    $scope.init  = function(cl,lt ){


      $scope.unlockReflection = false;

      $scope.gotoTop = function() {
        $(window).scrollTop(0);
      };

      var result1 = document.getElementsByClassName("ta-scroll-window");
      var wrappedResult1 = angular.element(result1);
      wrappedResult1.addClass('reflectionUnderlay');

      $timeout(function () {
            var ele =  $(document).find(".reflectionPad");
      if(ele.length>0){
        var result2 = $(ele).find(".btn-group");
        //document.getElementsByClassName("btn-group");
        //var wrappedResult2 = angular.element(result2);
        result2.css('display','none');
      }
          },400);

      


      console.log(cl + lt);

      if(lt == 3 && cl == 'True'){
        $scope.unlockReflection = true;
      }
    }
    $scope.go = function ( path, description ) {
      $location.path( path );
      $rootScope.unitDescription = description;
    };
    $scope.goHref = function ( path ) {
      var newUrl = '//' + $scope.subdomain  + path + '/';
      $window.location.href = newUrl;
    };
    $scope.goHrefLesson = function(path, unlocked){
      console.log(unlocked);
      if(unlocked == 'True') {
        var newUrl = '//' + $scope.subdomain + path + '/';
        $window.location.href = newUrl;
      }
    };

    $scope.saveReflection = function(reflection){
      $rootScope.savedNotification = true;
      $rootScope.notSavedNotification = false;
      if($scope.isSavingWork === false) {
        $scope.isSavingWork = true;
        console.log(reflection);
        $scope.saveReflectionCard(reflection).then(function (data) {
          console.log(data);
           if(data.status == 403) {
            $window.location.href = '/';
        }           
          if(angular.isDefined(data.data) && angular.isDefined(data.data.id)) {
            $scope.reflectionResponseId = data.data.id;
          }

          if( reflection == $scope.reflectionHtml) { 
            //Do't disable this if content changed in between getting response!
            $scope.isSaveWorkRequestPending = false;
          }
          $scope.isSavingWork = false;
          var msgDuration = 2000;               
          $scope.msgTimer = $timeout(function () {
            $rootScope.savedNotification = false;
            $rootScope.saveSuccessNotification = true;
          },msgDuration);

          $scope.netStatusChanged(true);

        }).catch(function (error) {
          if(error.status == 403) {
            $window.location.href = '/';
        }
          console.log('Error occurred');
          $scope.isSavingWork = false;
          $rootScope.savedNotification = false;
          $rootScope.notSavedNotification = true;
          $scope.isSaveWorkRequestPending = true;
          $scope.saveSuccessNotification = false;
          $scope.netStatusChanged(false);
        })
      } else {
        $scope.isSaveWorkRequestPending = true;
      }
    };

    $scope.unit_number = $routeParams.unit_number;
    $scope.grade_number = $route.current.params.grade_id;
    console.log($scope.unit_number)
    
    $scope.setIds = function() {
      if(!angular.isDefined($scope.grade_id)) { $scope.grade_id = $routeParams.grade_id; }
      if(!angular.isDefined($scope.unit_id)) { $scope.unit_id = $routeParams.unit_id; }

      if(!angular.isDefined($scope.grade_id) && angular.isDefined($route.current.params.grade_id)) { $scope.grade_id = $route.current.params.grade_id; }
      if(!angular.isDefined($scope.unit_id) && angular.isDefined($route.current.params.unit_id)) { $scope.grade_id =  $route.current.params.unit_id; }

      if(angular.isDefined($scope.grade_id) && angular.isDefined($scope.unit_id)) {
        return true;
      } else {
        return false;
      }
    }

    $scope.$on('$routeChangeSuccess', function() { 
      console.log('routeChangeSuccess');
      $rootScope.loadingCanvas = true;
      $scope.setIds();
      getData();
    });


    $scope.getScheduledLessons = function() {
      if($rootScope.user_id2) {
        return $http.post('/portfolio/scheduled_lessons/' + $rootScope.user_id2 + '/', {
          'grade_id': $scope.grade_id,
          'unit_id': $scope.unit_id
        });
      }else{
        return $http.post('/portfolio/scheduled_lessons/', {
          'grade_id': $scope.grade_id,
          'unit_id': $scope.unit_id
        });
      }
    };

    $scope.getReflectionResponse = function() {
      if($rootScope.user_id2) {
        return $http.post('/portfolio/reflection_response_html/' + $rootScope.user_id2 + '/', {
          'grade_id': $scope.grade_id,
          'unit_id': $scope.unit_id
        });
      }else{
        return $http.post('/portfolio/reflection_response_html/', {
          'grade_id': $scope.grade_id,
          'unit_id': $scope.unit_id
        });
      }
    };
    $scope.saveReflectionCard = function(reflection) {
      var wordcount = 0;
      var charcount = 0;
      var text = '';

      var textAngularElement =  angular.element($element[0]).find("text-angular");
      if(textAngularElement[0]){
          var textAngularName = textAngularElement[0].attributes['name'].value;
          var  textAngularEditor = textAngularManager.retrieveEditor(textAngularName);

          if(textAngularEditor) { 
              var textElement = textAngularEditor.scope.displayElements.text;
              var textElementZero = angular.element(textElement[0]);
              text = textElementZero.text(); //textElement[0].innerText || textElement[0].textContent; // to cover the non-jquery use case.      
          }else {
              //Edge case work around, needed when finish is clicked before POST is initiated. 
              if($scope.reflectionHtml) {
                  var html =  reflection;
                  var textElement = angular.element(html)
                  if(textElement.length>1){
                      textElement =  angular.element("<div></div>").append(textElement);
                  }
                  
                  var textElementZero = angular.element(textElement[0]);
                  text = textElementZero.text(); //textElement[0].innerText || textElement[0].textContent; // to cover the non-jquery use case.      
              }
          }

        
          charcount = text.replace(/(\r\n|\n|\r)/gm,"").replace(/^\s+/g,' ').replace(/\s+$/g, ' ').length;

          if (charcount > 0 && text.trim() !== '') {
              try {
                  var textonly = text.replace(/(\r\n|\n|\r)/gm," ");
                  textonly = textonly.replace(/^\s+/g,' ');
                  textonly = textonly.replace(/\s+/ig, ' '); // condense spacing
                  textonly = textonly.match(/\S+/g);
                  wordcount = textonly.length; // count remaining non-space strings
              }
              catch(err) {}    
          }   
      }

      console.log(reflection.toString());
      var reflection_response_url = '/portfolio/reflection_response/';
      if($rootScope.user_id2) {
          reflection_response_url = reflection_response_url + $rootScope.user_id2 + '/'
      }
      if(angular.isDefined($scope.reflectionResponseId)) {
        return $http.post(reflection_response_url, {
          'grade_id': parseInt($scope.grade_id),
          'unit_id': parseInt($scope.unit_id),
          'words': wordcount,
          'chars': charcount,
          'message': reflection,
          'reflection_card_id': $scope.reflectionCardId,
          'reflection_response_id': $scope.reflectionResponseId
        }, {timeout : connectionTimeout});
      } else {
        return $http.post(reflection_response_url, {
          'grade_id': parseInt($scope.grade_id),
          'unit_id': parseInt($scope.unit_id),
          'words': wordcount,
          'chars': charcount,
          'message': reflection,
          'reflection_card_id': $scope.reflectionCardId
        }, {timeout : connectionTimeout});
      }
    };

    $scope.getReflectionCard = function() {
      if($rootScope.user_id2) {
        return $http.post('/portfolio/reflection_card_html/'  + $rootScope.user_id2 + '/', {
          'grade_id': $scope.grade_id,
          'unit_id': $scope.unit_id
        });
      }else{
        return $http.post('/portfolio/reflection_card_html/', {
          'grade_id': $scope.grade_id,
          'unit_id': $scope.unit_id
        });
      }
    };

    $scope.getUserInfo = function() {
      if($rootScope.user_id2) {
        return $http.get('/generic/user_info/' + $rootScope.user_id2 + '/', {}
        );
      }else{
        return $http.get('/generic/user_info/', {}
        );
      }
    };

    function getData(){
      $scope.getUserInfo()
        .then(function (data) {
          if(data.status == 403) {
              $window.location.href = '/';
          }     
          $scope.user_info = data.data;
          $rootScope.useridnum = data.data.self.user_id;

          //for obo - to show other parties profile info in reflection card
        $rootScope.useridnum = data.data.self.user_id;
        $rootScope.userrole = data.data.self.role;
        $rootScope.persona = data.data.self.persona_id;
        $rootScope.match_status = data.data.self.match_status;
        if(typeof data.data.mentor !== 'undefined' && typeof data.data.mentor.f_name !== 'undefined'){
         // console.log("1" + data.data.mentor.f_name);
          $rootScope.otherPersonMentor = data.data.mentor.f_name;
          $rootScope.otherMentorPhoto = data.data.mentor.photo;
        }
        else if(typeof data.data.mentee !== 'undefined' && typeof data.data.mentee.f_name !== 'undefined'){
          console.log("2");
          $rootScope.otherPersonMentee = data.data.mentee.f_name;
          $rootScope.otherMenteePhoto = data.data.mentee.photo;
        }
        else if($rootScope.userrole == 'Mentor'){
          console.log("Mentor");
          $rootScope.otherPersonMentee = " ";
        }
        else if($rootScope.userrole == 'Mentee'){
          console.log("Mentee");
          $rootScope.otherPersonMentor = " ";
        }

        
          return $scope.getScheduledLessons();
        }).then(function (data) {
          if(data.status == 403) {
              $window.location.href = '/';
          }
          $scope.lessons = data.data;
          if(!angular.isDefined($scope.lessons) || $scope.lessons.length===0) {
            $rootScope.noLessonsAvailable = true;
          }
          $scope.unitTitle = $scope.lessons[0].unit_description;
          return $scope.getReflectionResponse();
        }).then(function (data) {
          if(data.status == 403) {
              $window.location.href = '/';
          }
          console.log(data);
          $scope.reflection = data.data[0];
          //console.log("$scope.reflection" + $scope.reflection.party_reflection_html);
          if(angular.isDefined($scope.reflection)){
            $scope.reflectionHtml = $scope.reflection.party_reflection_html;
            $scope.reflectionResponseId = $scope.reflection.reflection_response_id;
            $scope.counterparyReflection = $scope.reflection.counterparty_reflection_html;
          }
          return $scope.getReflectionCard();
        }).then(function (data) {
          if(data.status == 403) {
              $window.location.href = '/';
          }
          $scope.reflectionCard = data.data[0];
          $scope.reflectionCardId = $scope.reflectionCard.reflection_card_id;
          console.log($scope.reflectionCard);
          $scope.mentee_card = $scope.reflectionCard.mentee_card_html;
          $scope.mentor_card = $scope.reflectionCard.mentor_card_html;
          console.log($scope.mentee_card );
          $rootScope.loadingCanvas = false;
        }).catch(function (error) {
          if(error.status == 403) {
              $window.location.href = '/';
          }     
          $rootScope.loadingCanvas = false;
          console.log('Error occurred');
        });
        
      }

      // Auto save and counter 
      function init() {       
        if($scope.reflection && $scope.reflection.party_reflection_html)
        { 
          $scope.reflectionHtml = $scope.reflection.party_reflection_html; 
        }
      }

      $scope.finishButtonDefaultText = "Finish";
      $scope.finishButtonText = $scope.finishButtonDefaultText;

      $scope.isSavingWork = false;
      $scope.isSaveWorkRequestPending = false;
      
      var retrySaveInterval;
      var retrySaveTimeout = 2500;
      $scope.netStatusChanged =  function(isConnected) {
          stopRetrySave();
          if(isConnected === false) {
              $scope.finishButtonText = 'No Internet.'
              //if(retrySaveTimeout < 80000) {
                retrySaveTimeout = randomIntFromInterval(2,15) * 1000;  //retrySaveTimeout * 2;
              //}  
              startSaveCountDown(retrySaveTimeout);
              retrySaveInterval = $interval(function() {
                  retrySave();
              }, retrySaveTimeout + 1000);
              
          } else {
              
              retrySaveTimeout = 2500;
              if($scope.finishButtonText === 'No Internet.'){
                  $scope.finishButtonText = $scope.finishButtonDefaultText;                  
              }

              if(angular.isDefined(finishReflectionTimeout)){
                $scope.finishReflection();
              }
          } 
      };
      
      $scope.$watch('reflectionHtml', function(newValue, oldValue) {
            
            if ( typeof oldValue != 'undefined' && newValue !== oldValue && oldValue.trim() !== newValue.trim()) {
                if(angular.isObject($scope.saveTimer)) { $timeout.cancel($scope.saveTimer); }
                $scope.saveTimer = $timeout(
                  function() {
                      $scope.saveReflection(newValue);
                },2000);
                $scope.isSaveWorkRequestPending = true; 
            }
            
      }, true);



      var saveCountDownInterval;
      function startSaveCountDown(time) {
          stopSaveCountDown();
          var i = time / 1000;
          $rootScope.retrySavedNotification = true;
          $rootScope.notSavedNotification = false;
          $("#retrySavedNotification").html("Not yet saved. Check your Internet connection. Retrying in "  + i + " seconds…");
          saveCountDownInterval = $interval(function() {
              $rootScope.retrySavedNotification = true;
              $rootScope.notSavedNotification = false;
              $("#retrySavedNotification").html("Not yet saved. Check your Internet connection. Retrying in "  + i + " seconds…");
              i--;
              if(i==-1) {
                  stopSaveCountDown();
              }
          }, 1000);
      }

      function stopSaveCountDown() {
          if (angular.isDefined(saveCountDownInterval)) {
              $interval.cancel(saveCountDownInterval);
              saveCountDownInterval = undefined;
          }
          $rootScope.retrySavedNotification = false;
      };

    function retrySave() {
        stopRetrySave();

        if($scope.isSaveWorkRequestPending === false) {
                stopRetrySave();
        } else {
            $scope.saveReflection($scope.reflectionHtml);
        }
    };

    function stopRetrySave() {
        if (angular.isDefined(retrySaveInterval)) {
            $interval.cancel(retrySaveInterval);
            retrySaveInterval = undefined;
        }
        if(!$rootScope.finishingActivity) {
          stopSaveCountDown();
        }
    };

    var finishReflectionInterval;
    var finishReflectionTimeout;


    $scope.finishReflection = function() {
        $rootScope.finishingActivity = true;
        finishReflectionInterval = undefined;
        finishReflectionTimeout = 2500;
        finishReflectionTry();
    }

    $scope.finishReflectionCard = function() {
      console.log($scope.reflectionCardId);
      if( $rootScope.user_id2) {
        return $http.post('/portfolio/finish_reflection_response/' + $rootScope.user_id2 + '/' , {
          'grade_id': parseInt($scope.grade_id),
          'unit_id': parseInt($scope.unit_id),
          'reflection_card_id': $scope.reflectionCardId
        }, {timeout : connectionTimeout});
      } else {
        return $http.post('/portfolio/finish_reflection_response/' , {
          'grade_id': parseInt($scope.grade_id),
          'unit_id': parseInt($scope.unit_id),
          'reflection_card_id': $scope.reflectionCardId
        }, {timeout : connectionTimeout});
      }
    };

    function finishReflectionTry() {
        
        if($scope.finishButtonText != 'No Internet.'){
            $scope.finishButtonText = "Saving...";
        }

        if (angular.isDefined(finishReflectionInterval)) {
            $interval.cancel(finishReflectionInterval);
            finishReflectionInterval = undefined;
        }

        
        if($scope.isSaveWorkRequestPending === true) {
            $scope.saveReflection($scope.reflectionHtml);
            /*
            //if(finishReflectionTimeout < 80000) {
                finishReflectionTimeout = randomIntFromInterval(2,15); //finishReflectionTimeout * 2 ;
            //}

            startSaveCountDown(finishReflectionTimeout);

            finishReflectionInterval = $interval(function() {
                finishReflectionTry();
            }, finishReflectionTimeout + 1);
            */
            
            //setTimeout(finishReflection, 2000) //wait 2 seconds before retrying
        } else {
            //$scope.$broadcast('save-work'); 
            
            $rootScope.savedNotification = true;
            $rootScope.notSavedNotification = false;
            $scope.finishReflectionCard().then(function (data) {
                if (angular.isDefined(finishReflectionInterval)) {
                    $interval.cancel(finishReflectionInterval);
                    finishReflectionInterval = undefined;
                }

                var msgDuration = 1000;
                $scope.msgTimer = $timeout(function () {
                  $rootScope.savedNotification = false;
                },msgDuration);

                finishReflectionTimeout = undefined;
                // go to finish portfolio on success
                $scope.go('finish');
            }).catch(function (error) {
                $rootScope.savedNotification = false;
                $rootScope.notSavedNotification = true;
        
                $scope.finishButtonText = 'No Internet.';
                if (angular.isDefined(finishReflectionInterval)) {
                    $interval.cancel(finishReflectionInterval);
                    finishReflectionInterval = undefined;
                }
                
                //if(finishReflectionTimeout < 80000) {
                    finishReflectionTimeout = randomIntFromInterval(2,15) * 1000; //finishReflectionTimeout * 2 ;
                //}

                startSaveCountDown(finishReflectionTimeout);
                finishReflectionInterval = $interval(function() {
                    finishReflectionTry();
                }, finishReflectionTimeout + 1000);
                
            });
        }
        
    }

    init();

}]);


app.controller('FinishCtlr',[
  '$scope',
  '$http',
  '$location',
  '$rootScope',
  '$window',
  '$routeParams',
  '$timeout',
  function($scope,$http,$location,$rootScope,$window,$routeParams,$timeout) {

    $('body').css({'background': 'url(//cdn.imentor.org/new_platform/static/portfolio/img/celebration.jpg' + ')' + 'no-repeat center center fixed'});
    $('body').css({'background-size': 'cover'});

    $scope.go = function ( path, description ) {
      $location.path( path );
      $rootScope.unitDescription = description;
    };
    $scope.goHref = function ( path ) {
      var newUrl = '//' + $scope.subdomain  + path;
      $window.location.href = newUrl;
    };
    $scope.gotoTop = function() {
      $(window).scrollTop(0);
    };
    $scope.logout = function () {
      var logoutUrl = "//" + $window.location.host + "/iuser/logout/";
      $window.location.href = logoutUrl;
    };

    //Workaround for some background size issue
    $scope.$on('$viewContentLoaded', function(event) {
      $timeout(function() {
         $window.triggerHandler('resize');
      },0);
    });
  }]);

app.controller('ResourcesCtlr',[
  '$scope',
  '$http',
  '$location',
  '$rootScope',
  '$window',
  '$routeParams',
  function($scope,$http,$location,$rootScope,$window,$routeParams) {
    $scope.init  = function( ) {
      console.log('resouecs');


      $http({method: 'post', url: '/portfolio/supplemental_resources/'}).then(function (data, status, headers, config) {
        if(data.status == 403) {
            $window.location.href = '/';
        }
        console.log(data.data);
        $scope.resources = data.data;
        $rootScope.noResources = data.data.length == 0;
        console.log($rootScope.noResources);
        return data.data;

      }, function (error) {
        if(error.status == 403) {
              $window.location.href = '/';
          }
        console.log(error);
        return error;
      });
    }
    $scope.openResource = function(url) {
      var win = window.open(url, '_blank');
      win.focus();
    }
  }]);

app.directive('errSrc', function() {
  return {
    link: function(scope, element, attrs) {
      element.bind('error', function() {
        if (attrs.src != attrs.errSrc) {
          attrs.$set('src', attrs.errSrc);
        }
      });
    }
  }
});


