var app = angular.module('partners', ['ngResource']);
app.config(function($interpolateProvider, $resourceProvider){

  $resourceProvider.defaults.stripTrailingSlashes = false;
  $interpolateProvider.startSymbol('[[');
  $interpolateProvider.endSymbol(']]');
});


app.controller('partnersCtlr', ['$scope', '$http','$location', '$window', '$element',
  function ($scope, $http, $location, $window, $element) {

    var url = $location.host();
    console.log(url);
    $http.post("/forms_data/url_name/", {
      url: url
    }, {
    }).success(function (data) {
      $scope.name = data;
    }).error(function (data) {
      $scope.name = "dev";
      console.log(data.error);

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
      "bbbsmb": "https://www.bbbsmb.org/about/programs/mentor-2-0/",
      "tennesseebig": "http://www.tennesseebig.org/portfolio/mentor-2-0/",
      "tucsonbigs": "//tucsonbigs.org/imentor/"
    };

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
  }
]);
