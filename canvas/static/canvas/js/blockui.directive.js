(function() {

    'use strict';

    angular.module('imBlockUI', [])

    .directive('imBlockUi', ['$animate', '$compile', '$templateRequest', '$document', 'imBlockUIService', blockUi]);

    function blockUi($animate, $compile, $templateRequest, $document, imBlockUIService) {
        return {
            transclude: true,
            link: link
        };

        function link($scope, $element, $attrs) {
            var container;
            if ($attrs.imBlockUiElement === undefined) {
                container = angular.element($element).parent();
            } else {
                container = angular.element($document).find($attrs.imBlockUiElement);
            }
            if (container.length > 0) {
                container = container[0];
            }

            var blockUIElement = angular.element(container).find('#block-ui');

            if (blockUIElement.length === 0) {
                angular.element(container).append('<div class="im-block-ui" id="block-ui"></div>');
                blockUIElement = angular.element(container).find('#block-ui');
            }

            $attrs.$observe('imBlockUi', function(value) {
                var wrappedID = angular.element(blockUIElement);
                if ($scope.$eval(value) === true) {

                    $animate.addClass(container, 'im-block-ui-open');
                    $animate.addClass(wrappedID, 'im-block-ui-active');

                    $templateRequest(imBlockUIService.getUITemplate(1)).then(function(template) {
                        $compile(wrappedID.html(template).contents())($scope);
                    }, function() {
                        // An error has occurred
                    });

                } else {
                    $animate.removeClass(container, 'im-block-ui-open');
                    $animate.removeClass(wrappedID, 'im-block-ui-active');
                    wrappedID.html('');
                }
            });
        }
    }


    angular.module('imBlockUI')
        .factory('imBlockUIService', ['$http', 'config', 'common', bluckUiService]);

    function bluckUiService($http, config, common) {
        var $q = common.$q;

        var service = {
            getUITemplate: getUITemplate
        };

        return service;

        function getUITemplate(type) {
            var template = '';
            
            var imentor_cdn_prefix =  '';//typeof getCdnUrlPrefix == 'function' ? getCdnUrlPrefix() : '';

            var defaultTemplate = imentor_cdn_prefix + '/new_platform/static/canvas/nghtml/blockui.html';

            switch (type) {
                case 1:
                    template = defaultTemplate;
                    break;
            }

            return template;
        }
    }
})();