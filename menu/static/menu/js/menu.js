var app = angular.module('menu', ['ngResource','ui.bootstrap', 'ngHamburger']);

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
        'https://cdn.imentor.org/**',
        'https://tableau.imentor.org/**'
    ]); 
}]);

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

  var currDomain = $location.host();
  var ch = currDomain.split(".")[0];
  $scope.subdomain = ch;

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
  $scope.logout = function () {
    var logoutUrl = "//" + $window.location.host + "/iuser/logout/";
    $window.location.href = logoutUrl;
  }
  

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
});

// ----------------------------------------------------------------------------------

app.controller('MenuCtrl', function ($scope, $http, $location, $window, $rootScope) {
    $scope.subdomain = $window.location.host;
    $scope.goHref = function ( path ) {
      var newUrl = '//' + $scope.subdomain  + path;
      $window.location.href = newUrl;
    };
});

app.controller('noteController', function ($scope) {
  /*
  $scope.openNote = function () {
    $scope.value = true;
    ngDialog.open({
      template: '/new_platform/static/auth/nghtml/note.html',
      className: 'ngdialog-theme-plain custom-width',
      scope: $scope
    });
  };
  */
});
