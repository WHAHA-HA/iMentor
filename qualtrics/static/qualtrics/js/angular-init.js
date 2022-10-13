var app = angular.module('qualtrics', ['ngResource','ui.bootstrap','nvd3', 'ngHamburger','isteven-multi-select','ngDialog','fsm']);

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