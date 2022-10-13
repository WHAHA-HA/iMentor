var app = angular.module('bootstrap-toggle', []);

app.directive('toggleCheckbox', [
     function toggleCheckbox() {
        /**
         * Directive
         */
        return {
            restrict: 'A',
            transclude: true,
            replace: false,
            require: 'ngModel',
            link: function ($scope, $element, $attr, ngModel) {

                // update model from Element
                var updateModelFromElement = function() {
                    // If modified
                    var checked = $element.prop('checked');
                    if (checked != ngModel.$viewValue) {
                        // Update ngModel
                        ngModel.$setViewValue(checked);
                        $scope.$apply();
                    }
                };

                // Update input from Model
                var updateElementFromModel = function(newValue) {
                    $element.trigger('change');
                };

                // Observe: Element changes affect Model
                $element.on('change', function() {
                    updateModelFromElement();
                });

                $scope.$watch(function() {
                  return ngModel.$viewValue;
                }, function(newValue) { 
                  updateElementFromModel(newValue);
                }, true);

                // Initialise BootstrapToggle
                $element.bootstrapToggle({ on: $attr.on, off: $attr.off, size:$attr.size, onstyle: $attr.onstyle, offstyle: $attr.offstyle, style: $attr.style, width: $attr.width, height: $attr.height });
            }
        };
    }]);