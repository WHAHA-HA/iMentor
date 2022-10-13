var app = angular.module('qualtrics');

app.directive('ngEnter', function() {
  return function(scope, element, attrs) {

    element.bind("keydown keypress", function(event) {
      var keyCode = event.which || event.keyCode;

      // If enter key is pressed
      if (keyCode === 13) {
        scope.$apply(function() {
          // Evaluate the expression
          scope.$eval(attrs.ngEnter);
        });

        event.preventDefault();
      }
    });
  };
});
