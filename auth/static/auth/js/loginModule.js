var LoginModule = angular.module('LoginModule', ['ngRoute','ngCookies']);
//LoginModule.config(['$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
//  $routeProvider
//    .when('/', {
//      templateUrl : '/new_platform/static/auth/nghtml/welcome.html',
//      title: 'Welcome'
//    })
//    .when('/signin', {
//      templateUrl: '/new_platform/static/auth/nghtml/signin-box.html',
//      controller: 'LoginController',
//      title: 'Sign In' 
//    })
//    .when('/pswforgot', {
//      templateUrl: '/new_platform/static/auth/nghtml/password-forgot.html',
//      controller: 'ResetPasswordController',
//      title: 'Forgot Password'
//    })
//    .when('/pswsent', {
//      templateUrl: '/new_platform/static/auth/nghtml/password-sent.html',
//      title: 'Sent Link'
//    })
//    .when('/signupmentor', {
//      templateUrl: '/new_platform/static/auth/nghtml/signup-mentor.html',
//      title: 'Sign Up'
//    })
//    .when('/signupmentee', {
//      templateUrl: '/new_platform/static/auth/nghtml/signup-mentee.html',
//      title: 'Sign Up'
//    })
//    .when('/appinfo', {
//      templateUrl: '/new_platform/static/auth/nghtml/application-info.html',
//      title: 'Info'
//    })
//    .when('/appinfom', {
//      templateUrl: '/new_platform/static/auth/nghtml/application-info-mentor.html',
//      title: 'Info'
//    })
//    .when('/appsubmitted', {
//      templateUrl: '/new_platform/static/apiforms/nghtml/application-submitted.html',
//      title: 'appsubmitted - Congrats'
//    })
//    .when('/appsubmittedm', {
//      templateUrl: '/new_platform/static/apiforms/nghtml/application-submitted-mentee.html',
//      title: 'appsubmitted - Congrats'
//
//    });
//  $locationProvider.html5Mode(true);
//}
//]);

LoginModule.controller('LoginController',[
  '$scope',
  '$location',
  '$http',
  '$window',
  '$rootScope',
  '$cookies',
  function($scope, $location, $http, $window, $rootScope, $cookies) {
    $scope.showWelcome= function(){
      $rootScope.showSignbox = false;
    }
    $scope.goHref = function ( path ) {
      var newUrl = '//' + $scope.subdomain  + path;
      $window.location.href = newUrl;
    };
    $scope.go = function ( path, description ) {
      $location.path( path );
    };
    $scope.buttonText = "Sign in";
    $scope.busy = false;


    $scope.loginUser = function (email, password) {
      $scope.buttonText = "Signing in...";
      $scope.busy = true;
      // --- login call ---
      var req = {
        method: 'POST',
        url: '/iuser/ajax_login/',
        data: {email: email, password: password},
        withCredentials: true
      };
      // --- form lookup call ---
      var req2 = {
        method: 'GET',
        url: '/forms_data/form_lookup/'
      };
      var userrole = '';
      $http(req).success(function (response) {
        //var data = response;
        console.log("login success: " + response['success'] + ' ' + response['error']);
        $http({method: 'GET', url: '/generic/user_info/'}).then(function (data, status, headers, config) {
          $rootScope.userrole = data.data.self.role;
          userrole = data.data.self.role;
          $rootScope.status = data.data.self.USER_STATUS_APPLICATION_INCOMPLETE;
          console.log('user role: ' + $rootScope.userrole);
          return data.data;
        }, function (error) {
          console.log(error);
          $scope.busy = false;
          $scope.buttonText = "Sign in";
          return error;
        });
        if ((response['success'] == false) && (typeof response.error.prefix != 'undefined')) {
          var newHost = response.error.prefix;
          var currDomain = $location.host();
          console.log("1.no prefix found ");
          var ch = currDomain.split(".")[0];
          var nh = newHost.split(".")[0];
          var re = (nh, 'g');
          var newUrl = currDomain.replace(ch, nh);
          $window.location.href = "https://" + newUrl + '/';
        }
        else if (response['success'] == false) {
console.log("1.prefix not found: " + response.error);
          if(typeof response.error.persona != 'undefined'){
            $scope.authenticationError = "Your account has been closed. If you would like to re-open your account please email support@imentor.org";
          }
          else{
            $scope.authenticationError = response.error;
          }
          $scope.busy = false;
          $scope.buttonText = "Sign in";

        }
        else {
          $http({method: 'GET', url: '/generic/user_info/'}).then(function (data, status, headers, config) {
            $rootScope.userrole = data.data.self.role;
            userrole = data.data.self.role;
            $rootScope.status = data.data.self.USER_STATUS_APPLICATION_INCOMPLETE;
            console.log('user role: ' + $rootScope.userrole);
            //return data.data;

          $http(req2).success(function (response) {
            var newUrl = $location.host();
            if ((typeof response === 'undefined') || (response === null)) {
              var currDomain = $location.host();
              var ch = currDomain.split(".")[0];
              var returnUrl = $location.search().next;
              if (returnUrl) {
                console.log('Redirect to:' + returnUrl);
                //$location.path(returnUrl);
                $window.location.href = "https://" + newUrl + returnUrl;
              }
              else if( ($rootScope.userrole === 'Mentor' || $rootScope.userrole === 'Mentee') && ($rootScope.status !== 'AI')){
                //console.log("1: " + $rootScope.userrole);
                $window.location.href = "https://" + newUrl + "/canvas/#/";
              }else if($rootScope.userrole !== 'Mentor' && $rootScope.userrole !== 'Mentee'){
                //console.log("3: " + $rootScope.userrole);
                $window.location.href = "https://" + newUrl + "/menu";
              }else{
                //console.log("4: " + $rootScope.userrole);
                $window.location.href = "https://" + newUrl + "/menu";
              }
            } else {
              // if user already has a form, go to /forms/.
              // with /forms/ it always misses route on my computer...
              $window.location.href = "https://" + newUrl + "/forms/two/";
            }
          }).error(function (response) {
            $scope.authenticationError = "Your email address or password is invalid.";
            console.log("form lookup fail: " + response.error);
            $scope.busy = false;
            $scope.buttonText = "Sign in";

          }); // --- end of form lookup call ---
          }, function (error) {
            console.log(error);
            return error;
          });
        }
      }).error(function (response) {
        // --- error login user ---
        if ((response['success'] == false) && (typeof response.error.prefix != 'undefined')) {
          var newHost = response.error.prefix;
          var currDomain = $location.host();
          console.log("2.no prefix found ");
          var ch = currDomain.split(".")[0];
          var nh = newHost.split(".")[0];
          var re = (nh, 'g');
          var newUrl = currDomain.replace(ch, nh);
          $window.location.href = "https://" + newUrl + '/';
        }
        else {
          console.log("2.prefix not found: " + response.error);
          $scope.authenticationError = "Your email address or password is invalid.";
          $scope.busy = false;
          $scope.buttonText = "Sign in";
        }
        // end of login error response
      }); // --- end of login call ---

    };  // --- end of $scope.loginUser ---



    // TEST API LOGIN CODE - YET TO GO LIVE  
    $scope.loginUserAPI = function (email, password) {
      $scope.buttonText = "Signing in...";
      $scope.busy = true;
      // --- login call ---
      var req = {
        method: 'POST',
        url: '/login/',
        data: {email: email, password: password},
        withCredentials: true
      };
      // --- form lookup call ---
      var req2 = {
        method: 'GET',
        url: '/forms_data/form_lookup/'
      };
      var userrole = '';
      $http(req).success(function (response) {
        //var data = response;
        //{"app_status": true, "success": true}
        console.log("login success: " + response['success'] + ' ' + response['error']);
        if(response && response.access_token){
            $http.defaults.headers.common['Authorization'] = 'JWT ' + response.access_token;
            $cookies.put('token', 'JWT ' + response.access_token, {'path':'/'});
        } else {
            $http.defaults.headers.common['Authorization'] = '';
            $cookies.put('token', undefined, {'path':'/'});
            loginError(response);
            return;
        }

        $http({method: 'GET', url: '/generic/user_info/'}).then(function (data, status, headers, config) {
          $rootScope.userrole = data.data.self.role;
          userrole = data.data.self.role;
          $rootScope.status = data.data.self.USER_STATUS_APPLICATION_INCOMPLETE;
          console.log('user role: ' + $rootScope.userrole);
          return data.data;
        }, function (error) {
          console.log(error);
          $scope.busy = false;
          $scope.buttonText = "Sign in";
          return error;
        });
        if ((response['success'] == false) && (typeof response.error.prefix != 'undefined')) {
          var newHost = response.error.prefix;
          var currDomain = $location.host();
          console.log("1.no prefix found ");
          var ch = currDomain.split(".")[0];
          var nh = newHost.split(".")[0];
          var re = (nh, 'g');
          var newUrl = currDomain.replace(ch, nh);
          $window.location.href = "https://" + newUrl + '/';
        }
        else if (response['success'] == false) {
          console.log("1.prefix not found: " + response.error);
          $scope.authenticationError = response.error;
          $scope.busy = false;
          $scope.buttonText = "Sign in";
        }
        else {
          $http({method: 'GET', url: '/generic/user_info/'}).then(function (data, status, headers, config) {
            $rootScope.userrole = data.data.self.role;
            userrole = data.data.self.role;
            $rootScope.status = data.data.self.USER_STATUS_APPLICATION_INCOMPLETE;
            console.log('user role: ' + $rootScope.userrole);
            //return data.data;

          $http(req2).success(function (response) {
            var newUrl = $location.host();
            if ((typeof response === 'undefined') || (response === null)) {
              var currDomain = $location.host();
              var ch = currDomain.split(".")[0];
              var returnUrl = $location.search().next;
              if (returnUrl) {
                console.log('Redirect to:' + returnUrl);
                //$location.path(returnUrl);
                $window.location.href = "https://" + newUrl + returnUrl;
              }
              else if( ($rootScope.userrole === 'Mentor' || $rootScope.userrole === 'Mentee') && ($rootScope.status !== 'AI')){
                //console.log("1: " + $rootScope.userrole);
                $window.location.href = "https://" + newUrl + "/canvas/#/";
              }else if($rootScope.userrole !== 'Mentor' && $rootScope.userrole !== 'Mentee'){
                //console.log("3: " + $rootScope.userrole);
                $window.location.href = "https://" + newUrl + "/menu";
              }else{
                //console.log("4: " + $rootScope.userrole);
                $window.location.href = "https://" + newUrl + "/menu";
              }
            } else {
              // if user already has a form, go to /forms/.
              // with /forms/ it always misses route on my computer...
              $window.location.href = "https://" + newUrl + "/forms/two/";
            }
          }).error(function (response) {
            $scope.authenticationError = "Your email address or password is invalid.";
            console.log("form lookup fail: " + response.error);
            $scope.busy = false;
            $scope.buttonText = "Sign in";

          }); // --- end of form lookup call ---
          }, function (error) {
            console.log(error);
            return error;
          });
        }
      }).error(function (response) {
        // --- error login user ---
        loginError(response);
        // end of login error response
      }); // --- end of login call ---

      var loginError = function(){
        if ((response['success'] == false) && (typeof response.error.prefix != 'undefined')) {
          var newHost = response.error.prefix;
          var currDomain = $location.host();
          console.log("2.no prefix found ");
          var ch = currDomain.split(".")[0];
          var nh = newHost.split(".")[0];
          var re = (nh, 'g');
          var newUrl = currDomain.replace(ch, nh);
          $window.location.href = "https://" + newUrl + '/';
        }
        else {
          console.log("2.prefix not found: " + response.error);
          $scope.authenticationError = "Your email address or password is invalid.";
          $scope.busy = false;
          $scope.buttonText = "Sign in";
        }
      };
    };  // --- end of $scope.loginUser ---
  }
]);
