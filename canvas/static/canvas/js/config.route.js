(function () {
    'use strict';

    var app = angular.module('canvas');

    // Collect the routes
    app.constant('routes', getRoutes());

    // Configure the routes and route resolvers
    app.config(['$stateProvider', '$urlRouterProvider', 'routes', routeConfigurator]);


    // Set the routes
    function routeConfigurator($stateProvider, $urlRouterProvider, routes) {
        
        $urlRouterProvider.otherwise('/');
        
        routes.forEach(function (r) {
            $stateProvider.state(r.name, r.config);
        });
    }

    // Define the routes
    function getRoutes() {
        var imentor_cdn_prefix = '';//typeof getCdnUrlPrefix == 'function' ? getCdnUrlPrefix() : '';

        
        return [
            {
                name: 'presentation',
                config: {
                    url:'/',
                    templateUrl:  imentor_cdn_prefix + '/new_platform/static/canvas/nghtml/presentation.html',
                    controller: 'PresentationController',
                    controllerAs: 'vm'
                }
            }, {
                name: 'demo',
                config: {
                    url:'/demo',
                    templateUrl:  imentor_cdn_prefix + '/new_platform/static/canvas/nghtml/home.html',
                    controller: 'HomeController',
                    controllerAs: 'vm'
                }
            }, {
                name: 'images',
                config: {
                    url:'/images',
                    templateUrl:  imentor_cdn_prefix + '/new_platform/static/canvas/nghtml/images.demo.html',
                    controller: 'ImagesDemoController',
                    controllerAs: 'vm'
                }
            }, {
                name: 'finish',
                config: {
                    url:'/finish',
                    templateUrl:  imentor_cdn_prefix + '/new_platform/static/canvas/nghtml/finished.html',
                    controller: 'FinishController',
                    controllerAs: 'vm'
                }
            }
        ];
    }
})();
