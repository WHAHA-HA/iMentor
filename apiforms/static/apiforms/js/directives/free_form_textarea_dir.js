var forms = angular.module('imForm');


/**
 * FreeFormTextArea = 1
 */
forms.directive('freeFormTextArea', ['appFunc', '$sce',
  function(appFunc, $sce) {
    return {
      restrict: 'AEC',
      scope: {
        question: '=',
        fieldErrMsg: '=',
        updateUserResponse: '&'
      },
      templateUrl: '/new_platform/static/apiforms/drtvhtml/textarea.html',
      link: function($scope,$element,$attrs,$controller) {

        $scope.htmlText =
        $sce.trustAsHtml($scope.question.question_text);
        /**
         * Update required field status
         */
        $scope.updateRequired = function() {
          $scope.question.showRequired = false;
          
          $scope.question.edited = true;

          if ($scope.question.is_visible !== true || $scope.question.is_required !== true) {
            $scope.question.required = false;
            return false;
          }

          if (!$scope.question.user_response || !$scope.question.user_response.user_response) {
            $scope.question.required = true;
          }
          else {
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

          if ($scope.prevValue === $scope.question.user_response.user_response && (angular.isDefined($scope.question.hasSaveError)=== false || $scope.question.hasSaveError == false)) {
            //do not update value
            return;
          }

          $scope.prevValue = $scope.question.user_response.user_response;

          if (typeof $scope.question.user_response.user_response == 'undefined' || $scope.question.user_response.user_response == '') {

            //delete response
            appFunc.deleteUserResponse($scope.question, $scope).then(
            function(){ 
              $scope.updateRequired();  
            },function(){ 
              $scope.updateRequired();  
            });
          }
          else {
            if ($scope.updateRequired() === true) {
            return;
          }

          var user_response = {'user_response':{'answer_id':0,'question_id':$scope.question.id,'user_response': $scope.question.user_response.user_response}};
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
        $scope.question.edited = false;
        $scope.tabIndex = $scope.question.ordinal * 100 + $scope.question.sub_ordinal;
        $scope.question.updateRequired = $scope.updateRequired; // save the function point
      }
    }
  }
]);

