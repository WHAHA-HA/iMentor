
var ccList = angular.module('ChecklistOne', ['ngResource','ui.router',  'ui.bootstrap', 'ccControllers', '720kb.datepicker','ngHamburger','ngFileUpload', 'irontec.simpleChat', 'angular-notification-icons','textAngular']);

//Change default template tags to avoid conflict with Jinja's similar {{ tags}}
ccList.config(function($interpolateProvider, $stateProvider, $urlRouterProvider){
  $interpolateProvider.startSymbol('[[');
  $interpolateProvider.endSymbol(']]');
  
  $urlRouterProvider.otherwise('/');
  
  //Define state-based routing for the app here
  $stateProvider
    .state('search', {
      url: '/',
      views: {

        '': {

          templateUrl: '/new_platform/static/cchklist/nghtml/pick.html',
          //template: "<im-collegesearch></im-collegesearch>",
          controller: 'CollegePickController'
          }

          /*
          'selectedColleges@search': {
      templateUrl: '/new_platform/static/cchklist/nghtml/selected_colleges.html',
      controller: 'SelectedCollegesController'
          }
        */
      }
	  }
		
	); //End of /edit view
	
  
  });

ccList.run(function($rootScope) {
	angular.element(document).on("click", function(e) {
		$rootScope.$broadcast("documentClicked", angular.element(e.target));
	});
});


