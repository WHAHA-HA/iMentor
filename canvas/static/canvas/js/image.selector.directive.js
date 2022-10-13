(function() {

    'use strict';

    angular.module('imImageSelector', [])

    .factory('imImageSelectorFlickrService', ['$http', '$q', imImageSelectorFlickrService])

    .controller('imImageSelectorModelController', ['$scope', '$modalInstance', 'imImageSelectorFlickrService', 'items', 'service', 'categories', imImageSelectorModelController])

    .controller('imImageSelectorController', ['$scope', '$modal', 'imImageSelectorFlickrService', imImageSelectorController])

    .directive('imImageSelector', ['$animate', '$compile', '$templateRequest', 'imBlockUIService', imImageSelector])
    .service('imImages', ['$modal', 'imImageSelectorFlickrService', function imImageSelectorController($modal, imImageSelectorFlickrService) {

        //$scope.imImageSelectorImages = [];
        //$scope.imImageSelectorSelected = {};
        var vm = this;
        vm.categories = [];

        vm.open = function(size, imImageSelectorService, imImageSelectorImages) {

            vm.activate();
        
            vm.imImageSelectorImages =  imImageSelectorImages;
            vm.imImageSelectorService = imImageSelectorService;

            var imentor_cdn_prefix =  '';//typeof getCdnUrlPrefix == 'function' ? getCdnUrlPrefix() : '';

            return $modal.open({
                animation: true,
                templateUrl: imentor_cdn_prefix + '/new_platform/static/canvas/nghtml/image.selector.html',
                controller: 'imImageSelectorModelController',
                size: size,
                resolve: {
                    items: function() {
                        console.log(vm.imImageSelectorImages);
                        return vm.imImageSelectorImages;
                    },
                    service: function() {
                        console.log(vm.imImageSelectorService);
                        return angular.copy(vm.imImageSelectorService);
                    },
                    categories: function() {
                        console.log(vm.categories);
                        return angular.copy(vm.categories);
                    }
                }
            }).result;
            /*
            modalInstance.result.then(function(selectedItem) {
                vm.imImageSelectorSelected = selectedItem;
            }, function() {});*/
        };

        vm.activate = function() {
            if (typeof vm.imImageSelectorImages === 'undefined') {
                vm.imImageSelectorImages = [];
                if (vm.imImageSelectorService) {
                    imImageSelectorFlickrService.getCategories(vm.imImageSelectorService).then(function(data) {
                        vm.categories = vm.categories.concat(data);
                        imImageSelectorFlickrService.getAlbumImages(vm.imImageSelectorService,vm.categories[0]).then(function(data) {
                           if (typeof vm.imImageSelectorImages !== 'undefined') { vm.imImageSelectorImages = vm.imImageSelectorImages.concat(data);
                            vm.categories[0].currentImages = data.length;
                        }
                        });
                    });
                }
            }
        };

        

    }
]);


    function imImageSelectorFlickrService($http, $q) {
        var service = {};
        //var getLogFn = common.logger.getLogFn;
        //var log = getLogFn('imImageSelectorFlickrService');

        service.getImages = function(param) {
            var flickrPhotosetsUrl = 'https://api.flickr.com/services/rest/?method=flickr.photosets.getList&api_key=' +
                param.key + '&user_id=' +
                param.userId + '&format=json&nojsoncallback=1';

            var promeses = [];
            var images = [];

            return $http({
                    method: 'GET',
                    url: flickrPhotosetsUrl
                })
                .then(function(result, status, headers, config) {

                    var data = result.data;
                    for (var i = 0; i < data.photosets.photoset.length; i++) {
                        var flickrPhotosUrl = 'https://api.flickr.com/services/rest/?method=flickr.photosets.getPhotos&api_key=' +
                            param.key + '&photoset_id=' +
                            data.photosets.photoset[i].id +
                            '&user_id=' + param.userId +
                            '&format=json&nojsoncallback=1';
                        var getImages = $http.get(flickrPhotosUrl);
                        promeses.push(getImages);
                    }

                    return $q.all(promeses).then(function(results) {
                        var data = results;

                        for (var i = 0; i < data.length; i++) {
                            for (var j = 0; j < data[i].data.photoset.photo.length; j++) {

                                var photo = data[i].data.photoset.photo[j];
                                var image = {};
                                image.url = 'https://farm' + photo.farm +
                                    '.staticflickr.com/' + photo.server +
                                    '/' + photo.id + '_' + photo.secret + '_m.jpg';
                                image.thumbnail = 'https://farm' + photo.farm +
                                    '.staticflickr.com/' + photo.server +
                                    '/' + photo.id + '_' + photo.secret + '_s.jpg';
                                image.page = 'https://www.flickr.com/photos/' + param.userId +
                                    '/' + photo.id + '';
                                image.category = data[i].data.photoset.title;
                                image.id = photo.id;
                                image.type = 1;
                                image.order = j;
                                images.push(image);
                            }
                        }

                        return images;

                    });

                }, function(error) {
                    return [];
                });


        };

        service.getCategories = function(param) {
            console.log(param);
            var flickrPhotosetsUrl = 'https://api.flickr.com/services/rest/?method=flickr.photosets.getList&api_key=' +
                param.key + '&user_id=' +
                param.userId + '&format=json&nojsoncallback=1';

            var albums = [];

                return $http({
                    method: 'GET',
                    url: flickrPhotosetsUrl
                })
                .then(function(result, status, headers, config) {

                    var data = result.data;
                    for (var i = 0; i < data.photosets.photoset.length; i++) {
                        albums.push({
                            id: data.photosets.photoset[i].id,
                            title: data.photosets.photoset[i].title._content,
                            images: data.photosets.photoset[i].photos,
                            currentImages: 0
                        });
                    }

                    console.log(albums);

                    return albums;
                }, function(error) {
                    return [];
                });


        };

        service.getAlbumImages = function(param, photoset) {
            console.log(param);
            console.log(photoset);
            var promeses = [];
            var images = [];
           


            var flickrPhotosUrl = 'https://api.flickr.com/services/rest/?method=flickr.photosets.getPhotos&api_key=' + param.key +
                '&photoset_id=' + photoset.id +
                '&user_id=' + param.userId +
                '&format=json&nojsoncallback=1';
            var getImages = $http.get(flickrPhotosUrl);
            promeses.push(getImages);

            return $q.all(promeses).then(function(results) {
                var data = results;

                for (var i = 0; i < data.length; i++) {
                    for (var j = 0; j < data[i].data.photoset.photo.length; j++) {
                        var photo = data[i].data.photoset.photo[j];
                        var image = {};
                        image.url = 'https://farm' + photo.farm +
                            '.staticflickr.com/' + photo.server +
                            '/' + photo.id + '_' + photo.secret + '_m.jpg';
                        image.thumbnail = 'https://farm' + photo.farm +
                            '.staticflickr.com/' + photo.server +
                            '/' + photo.id + '_' + photo.secret + '_s.jpg';
                        image.page = 'https://www.flickr.com/photos/' + param.userId + '/' + photo.id + '';
                        image.category = data[i].data.photoset.title;
                        image.id = photo.id;
                        image.type = 1;
                        image.order = j;
                        images.push(image);
                    }
                }

                return images;

            });


        };

        return service;
    }

    function imImageSelectorModelController($scope, $modalInstance, imImageSelectorFlickrService, items, service, categories) {
        console.log(items);
        $scope.items = items;
        $scope.service = service;
        $scope.selected = {};
        $scope.categories = categories || [];
        $scope.selectedCategory = 'All';
        $scope.filter = '';
        $scope.categoryFilter = '';

        if (typeof $scope.service === 'undefined') {
            $scope.$watch('items', function(values) {
                $scope.categories = [];

                $scope.categories.push({
                    id: _.now(),
                    title: 'All'
                });
                var unique = {};

                for (var i = 0; i < values.length; i++) {
                    if (values[i].category !== 'undefined' && typeof(unique[values[i].category]) === 'undefined') {
                        $scope.categories.push({
                            id: _.now(),
                            title: values[i].category
                        });
                    }
                    unique[values[i].category] = 0;
                }

            }, true);
        }

        $scope.changeCategory = function(item) {
            $scope.filter = item.title === 'All' ? '' : item.title;
            $scope.selectedCategory = item;
            if (typeof $scope.service !== 'undefined') {
                getMoreImages(item);
            }
        };

        function getMoreImages(id) {
            if ($scope.selectedCategory.images !== $scope.selectedCategory.currentImages) {
                imImageSelectorFlickrService.getAlbumImages($scope.service, id).then(function(data) {
                    $scope.items = $scope.items.concat(data);
                    $scope.selectedCategory.currentImages = data.length;
                });
            }
        }

        $scope.ok = function() {
            $modalInstance.close($scope.selected.item);
        };

        $scope.cancel = function() {
            $modalInstance.dismiss('cancel');
        };

       function activate() {
            if (typeof $scope.items === 'undefined') {
                $scope.items = [];
                if ($scope.service) {
                    imImageSelectorFlickrService.getCategories($scope.service).then(function(data) {
                        $scope.categories = $scope.categories.concat(data);
                        imImageSelectorFlickrService.getAlbumImages($scope.service, $scope.categories[0]).then(function(data) {
                            $scope.items = $scope.items.concat(data);
                            $scope.categories[0].currentImages = data.length;
                        });
                    });
                }
            }
        }

        activate();

    }


    function imImageSelectorController($scope, $modal, imImageSelectorFlickrService) {

        //$scope.imImageSelectorImages = [];
        //$scope.imImageSelectorSelected = {};

        $scope.categories = [];

        $scope.open = function(size) {

            var imentor_cdn_prefix = typeof getCdnUrlPrefix == 'function' ? getCdnUrlPrefix() : '';

            var modalInstance = $modal.open({
                animation: true,
                templateUrl: imentor_cdn_prefix + '/new_platform/static/canvas/nghtml/image.selector.html',
                controller: 'imImageSelectorModelController',
                size: size,
                resolve: {
                    items: function() {
                        console.log($scope.imImageSelectorImages);
                        return $scope.imImageSelectorImages;
                    },
                    service: function() {
                        console.log($scope.imImageSelectorService);
                        return angular.copy($scope.imImageSelectorService);
                    },
                    categories: function() {
                        console.log($scope.imImageSelectorService);
                        return angular.copy($scope.categories);
                    }
                }
            });

            modalInstance.result.then(function(selectedItem) {
                $scope.imImageSelectorSelected = selectedItem;
            }, function() {});
        };

        function activate() {
            if (typeof $scope.imImageSelectorImages === 'undefined') {
                $scope.imImageSelectorImages = [];
                if ($scope.imImageSelectorService) {
                    imImageSelectorFlickrService.getCategories($scope.imImageSelectorService).then(function(data) {
                        $scope.categories = $scope.categories.concat(data);
                        imImageSelectorFlickrService.getAlbumImages($scope.imImageSelectorService, $scope.categories[0]).then(function(data) {
                            $scope.imImageSelectorImages = $scope.imImageSelectorImages.concat(data);
                            $scope.categories[0].currentImages = data.length;
                        });
                    });
                }
            }
        }

        activate();

    }

     function imImageSelector($animate, $compile, $templateRequest, imBlockUIService) {

        return {
            transclude: true,
            link: link,
            controller: 'imImageSelectorController',
            scope: {
                imImageSelectorImages: '=?',
                imImageSelectorSelected: '=',
                imImageSelectorService: '=?'
            },
            template: '<span ng-transclude></span>'

        };

        function link($scope, $element, $attrs) {
            angular.element($element).on('click', function(argument) {
                $scope.open('lg');
            });
        }
    }

})();
