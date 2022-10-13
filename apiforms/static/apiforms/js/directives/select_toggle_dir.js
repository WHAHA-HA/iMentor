var forms = angular.module('imForm');


/**
 * QUESTION_SINGLE_SELECT_TOGGLE = 5 # Boolean: yes/no, t/f
 */
forms.directive('selectToggle', ['appFunc', '$sce',
  function(appFunc, $sce) {
    return {
      restrict: 'AEC',
      scope: {
        question: '=',
        fieldErrMsg: '=',
        updateUserResponse: '&'
      },
      templateUrl: '/new_platform/static/apiforms/drtvhtml/select_toggle.html',
      link: function($scope,$element,$attrs,$controller) {


        $scope.yesAnswer = $scope.question.answers[0];
        $scope.noAnswer = $scope.question.answers[1];
        $scope.htmlText = $sce.trustAsHtml($scope.question.question_text);
        /**
         * Update required field status
         */
        $scope.updateRequired = function() {
          $scope.question.showRequired = false;
          
          if ($scope.question.is_visible !== true || $scope.question.is_required !== true) {
            $scope.question.required = false;
            return false;
          }

          if (!$scope.question.user_response || !$scope.question.user_response.answer_id) {
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

        $scope.update=function(answer) {

          if (typeof $scope.question.user_response !== 'undefined' && $scope.question.user_response.answer_id === answer.id) {
            return;
          }

          //$scope.prevValue === answer.id;

          $scope.question.edited = true;

          var user_response = {'user_response':{'answer_id':answer.id,'question_id':$scope.question.id,'user_response': null}};

          appFunc.updateUserResponse($scope.question, user_response, $scope)
            .then(function(res) {

              if (res.success == true) {
                $scope.question.user_response.answer_id = answer.id;
              }

              $scope.updateRequired();

            }, function (error) {
              $scope.updateRequired();
            });

        };

        //keep original value
        //if (typeof $scope.question.user_response.answer_id == 'undefined') {
        //  $scope.prevValue = '';
        //}
        //else {
        //  $scope.prevValue = $scope.question.user_response.answer_id;
        //}

        //update required status
        $scope.updateRequired();
        $scope.question.edited = false; // initialize edited = false
        $scope.tabIndex = $scope.question.ordinal * 100 + $scope.question.sub_ordinal;
        $scope.question.updateRequired = $scope.updateRequired; // save the function point
      }
    }
  }
]);
