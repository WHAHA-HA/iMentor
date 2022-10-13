var forms = angular.module('imForm');


/**
 * QUESTION_CAREERS = 18
 */
forms.directive('career', ['appFunc','$sce',
  function(appFunc, $sce) {
    return {
      restrict: 'AEC',
      scope: {
        question: '=',
        careersOnly: '=',
        fieldErrMsg: '=',
        updateUserResponse: '&'
      },
      templateUrl: '/new_platform/static/apiforms/drtvhtml/career.html',
      link: function($scope,$element,$attrs,$controller) {

        $scope.htmlText =
        $sce.trustAsHtml($scope.question.question_text);

        var savedUerResponse = $scope.question.user_response.user_response;
        $scope.careersOnly = angular.copy($scope.careersOnly);

        if (savedUerResponse) {


          for (var i=0; i <savedUerResponse.career_ids.length; i++) {

            var ele = _.find($scope.careersOnly, function(career) { return career.id === savedUerResponse.career_ids[i]; });
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
          
          if ($scope.question.is_visible !== true || $scope.question.is_required !== true) {
            $scope.question.required = false;
            return false;
          }

          var career_ids = [];

          _.each($scope.careersOnly, function(ele) {
            if (ele.selected == true) {
              career_ids.push(ele.id);
            }
          });

          if (career_ids.length ==0) {
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


        $scope.update=function(career_only) {

          $scope.question.edited = true;
          if(career_only) {
            career_only.selected = !career_only.selected;
          }
          var career_ids = [];

          _.each($scope.careersOnly, function(ele) {
            if (ele.selected == true) {
              career_ids.push(ele.id);
            }
          });

          if (career_ids.length == 0 ) {
            // delete
            appFunc.deleteUserResponse($scope.question, $scope)
              .then(function(res) {

                if (res.success != true) {
                  career_only.selected = !career_only.selected;
                }
                $scope.updateRequired();

              }, function (error) {
                //revert back the selection
                //career_only.selected = !career_only.selected;
                $scope.updateRequired();
              });
            return;
          }

          if ($scope.updateRequired() === true) {
            return;
          }

          var career_ids = [];

          _.each($scope.careersOnly, function(ele) {
            if (ele.selected == true) {
              career_ids.push(ele.id);
            }
          });

          var obj = {career_ids: career_ids};
          var user_response = {'user_response':{'answer_id':0,'question_id':$scope.question.id,'user_response': obj}};

          appFunc.updateUserResponse($scope.question, user_response, $scope, $scope.careers_only)
            .then(function(res) {
              if (res.success != true) {
                career_only.selected = !career_only.selected;
              }
              $scope.updateRequired();
            }, function(error) {
              //career_only.selected = !career_only.selected;
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
