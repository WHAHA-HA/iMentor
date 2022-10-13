var forms = angular.module('imForm');


/**
 * QUESTION_MULTI_SELECT_NOPREF_TOGGLE = 22
 */
forms.directive('noprefToggle', ['appFunc','$sce',
  function(appFunc, $sce) {
    return {
      restrict: 'AEC',
      scope: {
        question: '=',
        answers: '=',
        fieldErrMsg: '=',
        updateUserResponse: '&'
      },
      templateUrl: '/new_platform/static/apiforms/drtvhtml/nopref_toggle.html',
      link: function($scope,$element, $attrs, $controller) {

        $scope.htmlText =
        $sce.trustAsHtml($scope.question.question_text);

        var savedUerResponse = $scope.question.user_response.user_response;
        $scope.answers = $scope.question.answers;
        var denyingOrdinal = 0;

        if (savedUerResponse) {



          for (var i=0; i <savedUerResponse.answer_ids.length; i++) {

            var ele = _.find($scope.answers, function(answer) { return answer.id === savedUerResponse.answer_ids[i]; });
            if ( typeof ele !== 'undefined') {
              ele.selected = true;
            }
          }

          denyingOrdinal = $scope.answers[$scope.answers.length-1].ordinal;

        }


        /**
         * Update required field status
         */
        $scope.updateRequired = function() {
          $scope.question.showRequired = false;

          var answer_ids = [];

          _.each($scope.answers, function(ele) {
            if (ele.selected == true) {
              answer_ids.push(ele.id);
            }
          });

          if ($scope.question.is_visible !== true || $scope.question.is_required !== true) {
            $scope.question.required = false;
            return false;
          }

          if (answer_ids.length ==0) {
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

          $scope.question.edited = true;


          if (answer === null ) {
            $scope.error = 'Error';
            return;
          }
          if(answer) {
            answer.selected = !answer.selected;
          }
          /**
           * check : "I would prefer not to indicate my race" selected or not
           */

          var answer_ids = [];
          _.each($scope.answers, function(ele) {
            if(answer) {
              if (answer.ordinal === denyingOrdinal && ele.ordinal !==denyingOrdinal ) {
                ele.selected = false;
              }

              if (answer.ordinal !== denyingOrdinal && ele.ordinal ===denyingOrdinal ) {
                ele.selected = false;
              }
            }
            if (ele.selected == true) {
              answer_ids.push(ele.id);
            }
          });

          if (answer_ids.length == 0 ) {
            // delete
            appFunc.deleteUserResponse($scope.question, $scope)
              .then(function(res) {

                if (res.success != true) {
                  answer.selected = !answer.selected;
                }
                $scope.updateRequired();

              }, function (error) {
                //revert back the selection
                //answer.selected = !answer.selected;
                $scope.updateRequired();
              });
            return;
          }
          else if ($scope.updateRequired() === true) {
            return;
          }

          var obj = {answer_ids: answer_ids};
          var user_response = {'user_response':{'answer_id':0,'question_id':$scope.question.id,'user_response': obj}};

          appFunc.updateUserResponse($scope.question, user_response, $scope, $scope.answers)
            .then(function(res) {

              if (res.success != true) {
                answer.selected = !answer.selected;
              }

              $scope.updateRequired();

            }, function (error) {
              //answer.selected = !answer.selected;
              $scope.updateRequired();
            });

        };

        //update required status
        $scope.updateRequired();
        $scope.question.edited = false;
        $scope.tabIndex = $scope.question.ordinal * 100 + $scope.question.sub_ordinal;
        $scope.question.updateRequired = $scope.updateRequired; // save the function point
      }
    }
  }
]);
