//var ccList = angular.module('ChecklistApp', ['ui.router', 'ui.utils', 'ui.bootstrap', 'ccControllers', 'ccServices','ccDirectives']);
var ccList = angular.module('ChecklistApp', ['ngResource','ui.router',  'ui.bootstrap', 'ccControllers', '720kb.datepicker','ngHamburger','ngFileUpload', 'irontec.simpleChat', 'angular-notification-icons','textAngular']);

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
	      
	      templateUrl: '/new_platform/static/cchklist/nghtml/search.html',
	      //template: "<im-collegesearch></im-collegesearch>",
	      controller: 'CollegeSearchController'
	      }
	      
	      /*
	      'selectedColleges@search': {
		templateUrl: '/new_platform/static/cchklist/nghtml/selected_colleges.html',
		controller: 'SelectedCollegesController'
	      }
	    */
	    }  
	
	
	})

	.state('progress', {
		url: '/progress',
		template: "<ul> <li ng-repeat='school in schools'> [[school]] </li></ul>",
		controller: function($scope){
			$scope.schools = ['CUNY BCC', 'CUNY CSI', 'CUNY City College'];

			}// controller ends 

		} // views end


	) // end of 'progress' state


	.state('grouping', 
		 //Placeholder route
		{
		url: '/applications',
		template: "<h1> School Applicatons </h1><ul> <li ng-repeat='group in groupings'>[[group]]</li></ul>",
		controller: function($scope) {
			$scope.groupings = ["Target Schools","Safety Schools", "Reach Schools"];
			}
		
		}

	)  //End of 'grouping' state

	.state('edit',
		 //Placeholder route
		{ 
		   url: '/edit/:collegeId',
		   template: "<h1> [[ college.college.name]] </h1><p> [[ user_id ]] </p><p>[[ college.college.name]] - [[ collegeId ]]</p>",
		   controller: function($scope, $stateParams){
			   $scope.collegeId = $stateParams.collegeId;
			   $scope.college = {};
			$scope.user_id = $scope.college["user_id"];
			} //End of controller

		}
		
	); //End of /edit view
	
  
  });
// Whitelist cdn 
    ccList.config(['$sceDelegateProvider', function($sceDelegateProvider){
        $sceDelegateProvider.resourceUrlWhitelist([
            // Allow same origin resource loads.
            'self',
            // Allow loading from outer templates domain.
            'https://cdn.imentor.org/**'
        ]); 
    }]);

ccList.run(function($rootScope) {
	angular.element(document).on("click", function(e) {
		$rootScope.$broadcast("documentClicked", angular.element(e.target));
	});
});


