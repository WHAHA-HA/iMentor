(function () {
    'use strict';
    var controllerId = 'ImagesDemoController';

    angular.module('canvas').controller(controllerId, AboutController);

    AboutController.$inject  = ['common', 'datacontext'];

    function AboutController(common, datacontext) {
        var getLogFn = common.logger.getLogFn;
        var log = getLogFn(controllerId);

        var vm = this;
        vm.info = {
            title: 'Image Selector',
            description: 'Image Selector Demo'
        };
        vm.title = 'Image Selector';
        vm.selected ={};
        vm.flickrSelected = {};
        vm.images = [];
        
        vm.photoService = {
            name: 'flickr',
            key: '6d0a7230e7a2b5a2c4bf8f9d125ecae6',
            userId: '84621158@N06'//'131666034@N05'
        };
        
        activate();

        function activate() {
            var promises = [getImages()];

            common.activateController(promises, controllerId)
                .then(function () { log('Activated About View'); });
        }

 		function getImages() {
            return datacontext.getImages().then(function (data) {
                vm.images = data.images;
                console.log(data);
                return vm.images;
            });
        }
    }
})();