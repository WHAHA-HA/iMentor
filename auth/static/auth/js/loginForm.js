/**
 * Module for iMentor Landing Page.
 */

var app = angular.module('landingPage', ['ngRoute','LoginModule','ngHamburger','ngDialog','textAngular']);

app.run(function($location, $rootScope, $route) {
  $rootScope.page_title = 'Admin';
  $rootScope.$on('$routeChangeSuccess', function() {
    $rootScope.page_title = $route.current.title;
  });
  $rootScope.showSignbox = false;
});

// Headers
app.config(['$httpProvider','$locationProvider', function($httpProvider,$locationProvider) {
  $httpProvider.defaults.headers.common["X-Requested-With"] = 'XMLHttpRequest';
  $httpProvider.defaults.withCredentials = true;
}]);

// ---------- routes ----------
app.config(['$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
  $routeProvider
  .when('/', {
    templateUrl : '/new_platform/static/auth/nghtml/welcome.html',
    title: 'Welcome'
  })
  .when('/signin', {
    templateUrl: '/new_platform/static/auth/nghtml/signin-box.html',
    controller: 'LoginController',
    title: 'Sign In'
  })
  .when('/pswforgot', {
    templateUrl: '/new_platform/static/auth/nghtml/password-forgot.html',
    controller: 'ResetPasswordController',
    title: 'Forgot Password'
  })
  .when('/pswsent', {
    templateUrl: '/new_platform/static/auth/nghtml/password-sent.html',
    title: 'Sent Link'
  })
  .when('/signupmentor', {
    templateUrl: '/new_platform/static/auth/nghtml/signup-mentor.html',
    title: 'Sign Up'
  })
  .when('/signupmentee', {
    templateUrl: '/new_platform/static/auth/nghtml/signup-mentee.html',
    title: 'Sign Up'
  })
  .when('/appinfo', {
    templateUrl: '/new_platform/static/auth/nghtml/application-info.html',
    title: 'Info'
  })
  .when('/appinfom', {
    templateUrl: '/new_platform/static/auth/nghtml/application-info-mentor.html',
    title: 'Info'
  })
  .when('/appsubmitted', {
    templateUrl: '/new_platform/static/apiforms/nghtml/application-submitted.html',
    title: 'appsubmitted - Congrats'
  })
  .when('/appsubmittedm', {
    templateUrl: '/new_platform/static/apiforms/nghtml/application-submitted-mentee.html',
    title: 'appsubmitted - Congrats'
  })
  .otherwise ({
    redirectTo: '/'
  });;

  $locationProvider.html5Mode(false);
}
]);

// ---------- controllers ----------
// Takes care of picking a background-picture every time landing page loads.
app.controller('LandingController', function ($scope) {
  var images = ['bg1.jpg', 'bg2.jpg', 'bg3.jpg', 'bg4.jpg', 'bg5.jpg', 'bg6.jpg', 'bg7.jpg', 'bg8.jpg'];
  // TO DO: turn this jquery bit into a directive.
  $('.landingPage').css({'background': 'url(//cdn.imentor.org/new_platform/static/apiforms/img/' + images[Math.floor(Math.random() * images.length)] + ')' + 'no-repeat center center fixed'});
  $('.landingPage').css({'background-size': 'cover'});
});

app.controller('AppSubmittedController', function ($scope, $location, $window) {
  var images = ['done.jpg'];
  // TO DO: turn this jquery bit into a directive.
  $('body').css({'background': 'url(//cdn.imentor.org/new_platform/static/apiforms/img/' + images[Math.floor(Math.random() * images.length)] + ')' + 'no-repeat center center fixed'});
  $('body').css({'background-size': 'cover'});
  var currDomain = $location.host();
  var ch = currDomain.split(".")[0];
  //console.log("ch: " + ch);
  // custom message for app submitted mentors in location bbbsc.
  if(ch === 'bbbsc'){
    $scope.message = "Thank you for taking the time to enroll in Big Brothers Big Sisters of Colorado’s mentor2.0 program. Your application is now complete. We will be contacting you within the next few days to schedule an orientation/training. After attending an orientation/training, you will be scheduled for a brief in-person interview at a time that works best for you. If you have any questions, please call 720-460-6898."
  }else{
    $scope.message = "Your application has been submitted!"
  }

  $scope.continue = function () {
    var formUrl = "//" + $window.location.host + "/message/list/";
    $window.location.href = formUrl;
  }
});

app.controller('WelcomeController', ['$scope', '$http','$location', '$window','$rootScope',
  function ($scope, $http, $location, $window,$rootScope) {
    var images = ['bg1.jpg', 'bg2.jpg', 'bg3.jpg', 'bg4.jpg', 'bg5.jpg', 'bg6.jpg', 'bg7.jpg', 'bg8.jpg'];
    // TO DO: turn this jquery bit into a directive.
    $('.landingPage').css({'background': 'url(//cdn.imentor.org/new_platform/static/apiforms/img/' + images[Math.floor(Math.random() * images.length)] + ')' + 'no-repeat center center fixed'});
    $('.landingPage').css({'background-size': 'cover'});
    // gets imentor location and returns the name to include in page text.
    $scope.subdomain = $window.location.host;
    $scope.goHref = function ( path ) {
      console.log("path" + path);
      var newUrl = '//' + $scope.subdomain  + path;
      $window.location.href = newUrl;
    };

    $scope.showSignin = function(){
      $rootScope.showSignbox = true;
    }

    var init = function () {

      var url = $location.host();
      console.log(url);
      $http.post("/forms_data/url_name/", {
        url: url
      }, {
        withCredentials: true
      }).success(function (data) {
        $scope.name = data;
      }).error(function (data) {
        console.log(data.error);
        $scope.authenticationError = data.error;
      });
      var partnersLinks =
      {
        "127" : "//imentor.org",
        "mentor2":"http://bigbendmentoring.org/site/c.5oIGJVPtGbIUF/b.6229577/k.B6A/Big_Brothers_Big_Sisters_of_the_Big_Bend.htm",
        "bbbs-cnm": "http://bbbs-cnm.org/mentor2.0",
        "bbbstx": "http://bbbsmentor2.org/",
        "bbbspgh": "http://bbbspgh.org/site/c.ahKLIYMIImI2E/b.9145659/k.C695/mentor20.htm",
        "bbbsu": "http://bbbsu.org/volunteer/mentor20/",
        "bbbscharlotte": "http://bbbscharlotte.org/site/c.7gLMK5MKLgIUF/b.9124549/k.C655/mentor20.htm",
        "bbbsmilwaukee": "http://bbbsmilwaukee.org/site/c.8hKPI2MGIkI0E/b.9255917/k.7703/Changing_lives8212one_story_at_a_time.htm",
        "bbbswillgrundy": "http://bbbswillgrundy.org/mentor2.0",
        "bbbscil": "http://bbbscil.org/Volunteer/mentor2-0",
        "bbbsc": "http://biglittlecolorado.org/mentor2_denver.html",
        "bbbsmb": "http://info.bbbsmb.org/imentor",
        "tennesseebig": "http://www.tennesseebig.org/portfolio/mentor-2-0/",
        "tucsonbigs": "//tucsonbigs.org/imentor/"
      };
//        "bbbsn": "http://bbbsn.org/site/c.biKQJ6NOIpI6F/b.8462643/k.EF0B/Home_Page.htm",

      var currDomain = $location.host();
      var ch = currDomain.split(".")[0];
      //ch = "bbbsc";
      console.log("ch: " + ch);
      if(ch == '127'){
        $scope.partnerSite = "//imentor.org";
        console.log($scope.partnerSite);
      }
      if (ch in partnersLinks) {
        $scope.partnerSite = partnersLinks[ch];
        console.log($scope.partnerSite);
      }

      $scope.isOnPartnerList = function(){
        var currDomain = $location.host();
        var ch = currDomain.split(".")[0];
        //var ch = 'mentor2';
        console.log("ch: " + ch);
        // link will only show for following partners
        var partners = ['127', 'mentor2','bbbs-cnm','bbbstx','bbbspgh','bbbsu','bbbscharlotte','bbbsmilwaukee','bbbswillgrundy','bbbscil','bbbsc','bbbsmb','tennesseebig','tucsonbigs'];
        var a = partners.indexOf(ch);
        //console.log(a);
        if(a !== -1){
          $scope.isOnPartnerList = true;
        }
        else{
          $scope.isOnPartnerList = false;
        }
      };
      $scope.isOnPartnerList();
    };
    init();
    $scope.oldSigninPage = function () {
      var currDomain = $location.host();
      $window.location.href = "//" + currDomain + '/alt_login/';
    }
  }
]);

app.controller('InfoController', function ($scope, $http, $location, $window) {
  var url = $location.host();
  $scope.ch = url.split(".")[0];
  // url name for text references,ej imentor, imentor2 etc...
  $http.post("/forms_data/url_name/", {
    url: url
  }, {
    withCredentials: true
  }).success(function (data) {
    $scope.name = data;
  }).error(function () {
    console.log("could not get application name");
  });
  // user clicks button to start application - go to form.
  $scope.gotoform = function () {
    var formUrl = "//" + $window.location.host + "/forms/two/";
    $window.location.href = formUrl;
  };
  $scope.logout = function () {
    var url = $location.host();
    var landingUrl = "//" + url + "/iuser/logout/";
    $window.location.href = landingUrl;
  }
});

app.controller('SignUpController', function ($scope, $http, $location, $window) {
  // sign up user and sign in too, then redirect to appropiate mentor/mentee application info page.
  $scope.submitInProgress = false;
  $scope.submitBtnText = 'Create';

  $scope.signUp = function (email, password, confirmpass, userType) {
    if ($scope.signupForm.$valid) {
      $scope.busy = true;
      $scope.submitInProgress = true;
      $scope.submitBtnText = 'Creating...';
      $scope.location = $location.path();
      var url = $location.host();
      console.log("URL" + url);
      var req = {
        method: 'POST',
        url: '/iuser/ajax_createuser/',
        data: {
          email: email,
          password: password,
          password_confirm: confirmpass,
          url: url,
          user_type: userType
        },
        withCredentials: true
      };
      var req2 = {
        method: 'POST',
        url: '/iuser/ajax_login/',
        data: {email: email, password: password},
        withCredentials: true
      };
      $http(req).success(function (response) {
        if (response.success == true) {
          $http(req2).success(function (response) {
            if ($location.path() === '/signupmentor') {
              $location.path("/appinfom");
            } else {
              $location.path("/appinfo");
            }
          }).error(function (response) {
            $scope.busy = false;
            $scope.submitInProgress = false;
            $scope.submitBtnText = 'Create';
            $scope.authenticationError = response.error;
            $scope.authenticationError = "Error creating account.";
          });
        }
        else {
          $scope.busy = false;
          $scope.authenticationError = response.error;
          $scope.submitInProgress = false;
          $scope.submitBtnText = 'Create';
          //$scope.authenticationError = "Error signing in";
        }
      }).error(function (response) {
        $scope.busy = false;
        $scope.submitInProgress = false;
        $scope.submitBtnText = 'Create';
        $scope.authenticationError = response.error;
        $scope.authenticationError = "Account already exists. Please sign in.";
      });
    }
  }
});

app.controller('ResetPasswordController', function ($scope, $http, $location) {
  // Send request to reset password by email.
  $scope.resetPassword = function (email) {
    $http.post("/password/ajax_reset_request/", {
      email: email
    }).success(function (data) {
      $location.path("/pswsent");
    }).error(function (error) {
      $scope.authenticationError = error;
    });
  }
});

app.controller('headerController', function ($scope, $http, $location, $window, $rootScope) {
  $('.trouble').css({'display': 'none'});
  $('.landingPage').css({'background': 'none'});
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
  $http({method: 'GET', url: '/generic/user_info/'}).then(function (data, status, headers, config) {
    console.log('user: ' + data.data.self.f_name);
    $rootScope.firstname = data.data.self.f_name;
    $rootScope.lastname = data.data.self.l_name;
    $rootScope.useridnum = data.data.self.user_id;
    $rootScope.userrole = data.data.self.role;
    $rootScope.persona = data.data.self.persona_id;
    //alert($rootScope.useridnum );
    return data.data;
  }, function (error) {
    console.log(error);
    return error;
  });
});

// ---------- directives ----------
app.directive('pwCheck', function () {
  // checks that passwords match.
  return {
    require: 'ngModel',
    link: function (scope, elem, attrs, ctrl) {
      var firstPassword = '#' + attrs.pwCheck;
      elem.add(firstPassword).on('keyup', function () {
        scope.$apply(function () {
          var v = elem.val() === $(firstPassword).val();
          ctrl.$setValidity('pwmatch', v);
        });
      });
    }
  }
});

app.directive('form', function () {
  return {
    require: 'form',
    restrict: 'E',
    link: function (scope, element, attributes) {
      var $element = $(element);
      $element.on('submit', function (e) {
        $element.find('.ng-pristine').removeClass('ng-pristine').addClass('ng-dirty');
        $element.find('.ng-pristine').removeClass('ng-pristine').addClass('ng-dirty');
        // $element.find('.ng-submitted').removeClass('ng-invalid-required').addClass('valid-required');
        // $element.find('.ng-submitted').removeClass('ng-invalid').addClass('ng-valid');
        // $element.find('.invisible ').removeClass('ng-invalid-required').addClass('ng-valid');
        var form = scope[attributes.name];
        angular.forEach(form, function (formElement, fieldName) {
          if (fieldName[0] === '$') return;
          formElement.$pristine = false;
          formElement.$dirty = true;
        }, this);
        form.$setDirty();
        scope.$apply();
      });
    }
  }
});



