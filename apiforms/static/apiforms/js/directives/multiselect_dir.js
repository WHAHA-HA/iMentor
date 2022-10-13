var forms = angular.module('imForm');

/**
 * QUESTION_MULTI_SELECT = 7
 */
forms.directive('multiSelect', ['appFunc',"$sce",
  function(appFunc, $sce) {
    return {
      restrict: 'AEC',
      scope: {
        question: '=',
        fieldErrMsg: '=',
        updateUserResponse: '&'
      },
      templateUrl: '/new_platform/static/apiforms/drtvhtml/multi_select.html',
      link: function($scope,$element,$attrs,$controller) {

        $scope.htmlText =
        $sce.trustAsHtml($scope.question.question_text);

        $scope.answers = $scope.question.answers;
        var savedUerResponse = $scope.question.user_response.user_response;
        var notSeenOrdinal = 500;

        if ( savedUerResponse && savedUerResponse.answer_ids) {

          for (var i=0; i <savedUerResponse.answer_ids.length; i++) {

            var ele = _.findWhere($scope.answers, {id: savedUerResponse.answer_ids[i]});

            if ( typeof ele !== 'undefined') {
              ele.selected = true;
            }
          }

        }

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

          var answer_ids = [];

          _.each($scope.answers, function(ele) {
            if (ele.selected == true) {
              answer_ids.push(ele.id);
            }
          });

          if (answer_ids.length === 0 ) {
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

          var answer_ids = [];
          if(answer) {
            answer.selected = !answer.selected;
          }
          _.each($scope.answers, function(ele) {

            //if (answer.ordinal === notSeenOrdinal && ele.ordinal !==notSeenOrdinal) {
            //  ele.selected = false;
            //}
            //
            //if (answer.ordinal !== notSeenOrdinal && ele.ordinal ===notSeenOrdinal) {
            //  ele.selected = false;
            //}

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

          if ($scope.updateRequired() === true) {
            return;
          }

          var obj = {answer_ids: answer_ids};
          var user_response = {'user_response':{'answer_id':0,'question_id':$scope.question.id,'user_response': obj}};

          appFunc.updateUserResponse($scope.question, user_response, $scope, $scope.answers)
            .then(function(res) {

              if (res.success != true) {
                //revert back
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
        $scope.question.edited = false; // initialize edited = false
        $scope.tabIndex = $scope.question.ordinal * 100 + $scope.question.sub_ordinal;
        $scope.question.updateRequired = $scope.updateRequired; // save the function point
      }
    }
  }
]);