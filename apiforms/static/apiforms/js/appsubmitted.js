
var app = angular.module('AppSubmitted', ['loggerServices']);

app.config(function($interpolateProvider){


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

app.run(function(){

    //See https://github.com/angular/angular.js/pull/14221 for more information.
    var _DatetoJSON = Date.prototype.toJSON;
    Date.prototype.toJSON = function() {
      try {
        return _DatetoJSON.call(this);
      } catch(e) {
        if (e instanceof RangeError) {
          return null;
        }
        throw e;
      }
    };
});

app.controller('AppSubmittedController',[
  '$scope',
  '$location',
  '$http',
  '$window',
  '$rootScope',
  'jsonLogger',
  function($scope, $location, $http, $window, $rootScope,jsonLogger) {

    /* debug_log */
    var logger = new jsonLogger();
    
    $scope.init = function () {
      var images = ['done.jpg'];
      // TO DO: turn this jquery bit into a directive.
      $('body').css({'background': 'url(/new_platform/static/apiforms/img/done.jpg)' + 'no-repeat center center fixed'});
      $('body').css({'background-size': 'cover'});
      var currDomain = $window.location.host;
      console.log(currDomain);
      var ch = currDomain.split(".")[0];
      //console.log("ch: " + ch);
      // custom message for app submitted mentors in location bbbsc.
      //$scope.message = "welocme!";

      var partnersLinks =
      {
        "127":"//imentor.org",
        "nyc":"//imentor.org",
        "chicago":"//imentor.org",
        'bayarea': "//imentor.org",
        "platformtraining":"//imentor.org",
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
      var url = $location.host();
      console.log(url);

      /* debug_log */
      logger.setMetaData({'caller' : 'AppSubmittedController.init'});
      logger.log({'status' : 'Calling', 'api' : "/forms_data/url_name/", 'api_params' : { 'url' : url } });
      
      $http.post("/forms_data/url_name/", {
        url: url
      }, {
      }).success(function (data) {
        $scope.PartnerName = data;
        
        /* debug_log */
        logger.log({'status' : 'Success', 'response' : data});
	    
        console.log($scope.PartnerName);
      }).error(function (data) {
        var currDomain = $location.host();
        var ch = currDomain.split(".")[0];
        $rootScope.ch = ch;
        //$scope.PartnerName = ch;
        console.log("$scope.PartnerName " + ch);
        $scope.authenticationError = data.error;

        /* debug_log */
        logger.log({'status' : 'Error', 'response' : data});

      });

      var currDomain = $location.host();
      var ch = currDomain.split(".")[0];
      //ch = "bbbsc";
      //console.log("ch: " + ch);
      if (ch in partnersLinks) {
        $scope.partnerSiteLink = partnersLinks[ch];
        console.log($scope.partnerSiteLink);
      }
      

      $scope.continue = function () {
        /* debug_log */
        logger.createNewID();
        logger.setMetaData({'caller' : 'AppSubmittedController.continue'});

        var formUrl = $scope.partnerSiteLink;

        /* debug_log */
        logger.log({'formUrl' : formUrl});
        
        setTimeout(function() {
          $window.location.href = formUrl;   
        }, 500);
       
      }

      $http({method: 'GET', url: '/generic/user_info/'}).then(function (data, status, headers, config) {
        //console.log('user' + data.data);
        $rootScope.firstname = data.data.self.f_name;
        $rootScope.lastname = data.data.self.l_name;
        $rootScope.useridnum = data.data.self.user_id;
        $rootScope.userrole = data.data.self.role;
        $rootScope.persona = data.data.self.persona_id;

        /* debug_log */
        var loggerData = logger.getLoggerData();
        if(typeof loggerData.login_user_id === "undefined" || loggerData.login_user_id.toString().trim() === "" || loggerData.login_user_id.length === 0){
            loggerData.login_user_id = data.data.self.user_id;
            logger.setLoggerData(loggerData);
        }

        console.log($rootScope.userrole);
        return data.data;
      }, function (error) {
        console.log(error);
        return error;
      });
    }
  }
]);






