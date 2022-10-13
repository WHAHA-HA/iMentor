var app = angular.module(
  'classroom_mgmt',
  [
    'ngResource',
    'ui.bootstrap',
    'ngHamburger',
    'ngDialog',
    '720kb.datepicker',
    'ngRoute',
    
    'textAngular', 
    'colorpicker.module', 
    'ui.bootstrap.dropdownToggle', 
    'imBlockUI',
    'imImageSelector',
    'imEmbed',
    'mentio',
    'ngFileUpload',

    'isteven-multi-select',
    'irontec.simpleChat',
    'angular-notification-icons',
    'ChatModuleAdmin',
    'fsm'
  ]
);

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
