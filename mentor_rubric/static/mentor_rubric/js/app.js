(function () {
    'use strict';

    //var app = angular.module('flipbook', ['ngResource','ui.bootstrap', 'ngHamburger','isteven-multi-select','ngDialog']);
 
    var app = angular.module('mentor_rubric', [
        // Angular modules
        'ngAnimate',        // animations
        'ui.router',          // routing

        // Custom modules

        // 3rd Party Modules
        'ui.bootstrap',      // ui-bootstrap (ex: carousel, pagination, dialog)
        'ngHamburger',
        'ngDialog',
        'ngCookies',
        'ngResource',
        'bootstrap-toggle',
        'irontec.simpleChat',
        'isteven-multi-select',
        'ChatModuleAdmin',
        'fsm'

    ]);
    // Collect the routes
    app.constant('routes', getRoutes());

    // Configure the routes and route resolvers
    app.config(['$stateProvider', '$urlRouterProvider', 'routes', routeConfigurator]);

    // Whitelist cdn 
    app.config(['$sceDelegateProvider', function($sceDelegateProvider){
        $sceDelegateProvider.resourceUrlWhitelist([
            // Allow same origin resource loads.
            'self',
            // Allow loading from outer templates domain.
            'https://cdn.imentor.org/**'
        ]); 
    }]);

    // Set the routes
    function routeConfigurator($stateProvider, $urlRouterProvider, routes) {
        
        $urlRouterProvider.otherwise('/');
        
        routes.forEach(function (r) {
            $stateProvider.state(r.name, r.config);
        });
    }

    // Define the routes
    function getRoutes() {
        return [
            {
                name: 'mentor_rubric',
                config: {
                    url:'/',
                    templateUrl: '/new_platform/static/mentor_rubric/nghtml/mentor_rubric.html',
                    controller: 'MentorRubricController',
                    controllerAs: 'vm'
                }
            }
        ];
    }
    
})();



