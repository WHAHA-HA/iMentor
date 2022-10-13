var forms = angular.module('imForm');


/**
 * FreeFormTextArea = 2
 */
forms.directive('freeFormTextBox', ['appFunc', "$sce",
  function(appFunc, $sce) {
    return {
      restrict: 'AEC',
      scope: {
        question: '=',
        fieldErrMsg: '=',
        updateUserResponse: '&'
      },
      templateUrl: '/new_platform/static/apiforms/drtvhtml/textbox.html',
      link: function($scope,$element, $attrs, $controller) {

        $scope.htmlText =
        $sce.trustAsHtml($scope.question.question_text);
        /**
         * Update required field status
         */
        $scope.updateRequired = function() {
          $scope.question.showRequired = false;
          
          console.log('Call to update required triggered.');
//          console.log('Question Data : ' + JSON.stringify($scope.question));
          $scope.question.edited = true;

          if ($scope.question.is_visible !== true || $scope.question.is_required !== true) {
            console.log('question.is_visible or question.is_required is not True.');
            $scope.question.required = false;
            return false;
          }

          if (!$scope.question.user_response || !$scope.question.user_response.user_response) {
            $scope.question.required = true;
          }
          else {
            console.log('question.user_response or question.user_response.user_response is undefined or false.');
            $scope.question.required = false;
          }

          
          if($scope.error && $scope.error!='') {
            console.log('Question has error.');
            $scope.question.required = true;
            return false;
          } else{
            return $scope.question.required;
          }

        };


        $scope.update=function() {
          console.log('Call to update triggered.');

          if ($scope.prevValue === $scope.question.user_response.user_response && (angular.isDefined($scope.question.hasSaveError)=== false || $scope.question.hasSaveError == false)) {
            //do not update value
            console.log('Exiting update. Previous value is current value.');
            return;
          }

          $scope.prevValue = $scope.question.user_response.user_response;

          if (typeof $scope.question.user_response.user_response == 'undefined' || $scope.question.user_response.user_response == '') {

            console.log('Deleting response. Value is undefined or null.');
            //delete response
            appFunc.deleteUserResponse($scope.question, $scope).then(
            function(){ 
              $scope.updateRequired();  
            },function(){ 
              $scope.updateRequired();  
            });
          }
          else {
            console.log('Checking if update is required.');

            if ($scope.updateRequired() === true) {
              console.log('Exiting update. Update required check returned true.');
              return;
            }

            var user_response = {'user_response':{'answer_id':0,'question_id':$scope.question.id,'user_response': $scope.question.user_response.user_response}};
            console.log('Updating response. Making POST call with Data : ' + JSON.stringify(user_response));
            appFunc.updateUserResponse($scope.question, user_response, $scope).then(
            function(){ 
              $scope.updateRequired();  
            },function(){ 
              $scope.updateRequired();  
            });

          }

        };

        //keep original value
        if (typeof $scope.question.user_response.user_response == 'undefined') {
          $scope.question.user_response.user_response = '';
          $scope.prevValue = '';
        }
        else {
          $scope.prevValue = $scope.question.user_response.user_response;
        }

        //update required status
        $scope.updateRequired();
        $scope.question.edited = false; // initialize edited = false
        $scope.tabIndex = $scope.question.ordinal * 100 + $scope.question.sub_ordinal;
        $scope.question.updateRequired = $scope.updateRequired; // save the function point
      }
    }
  }
]);