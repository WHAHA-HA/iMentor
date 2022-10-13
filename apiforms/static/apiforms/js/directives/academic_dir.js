var forms = angular.module('imForm');

/**
 * QUESTION_ACADEMIC_FIELD = 20
 */
forms.directive('academic', ['appFunc','$sce',
  function(appFunc, $sce) {
    return {
      restrict: 'AEC',
      scope: {
        question: '=',
        academics: '=',
        fieldErrMsg: '=',
        updateUserResponse: '&'
      },
      templateUrl: '/new_platform/static/apiforms/drtvhtml/academic.html',
      link: function($scope,$element, $attrs, $controller) {

        $scope.htmlText =
        $sce.trustAsHtml($scope.question.question_text);

        var savedUerResponse = $scope.question.user_response.user_response;
        $scope.academics = angular.copy($scope.academics);

        if (savedUerResponse) {

          for (var i=0; i <savedUerResponse.afields.length; i++) {

            var ele = _.find($scope.academics, function(academic) { return academic.id === savedUerResponse.afields[i]; });

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

          var academic_ids = [];

          _.each($scope.academics, function(ele) {
            if (ele.selected == true) {
              academic_ids.push(ele.id);
            }
          });

          if (academic_ids.length ==0) {
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


        $scope.update=function(academic) {

          $scope.question.edited = true;
          if(academic) {
            academic.selected = !academic.selected;
          }
          var academic_ids = [];

          _.each($scope.academics, function(ele) {
            if (ele.selected == true) {
              academic_ids.push(ele.id);
            }
          });

          if (academic_ids.length == 0 ) {
            // delete
            appFunc.deleteUserResponse($scope.question, $scope)
              .then(function(res) {

                if (res.success != true) {
                  academic.selected = !academic.selected;
                }
                $scope.updateRequired();

              }, function (error) {
                //revert back the selection
                //academic.selected = !academic.selected;
                $scope.updateRequired();
              });
            return;
          }

          if ($scope.updateRequired() === true) {
            return;
          }

          var academic_ids = [];
          _.each($scope.academics, function(ele) {
            if (ele.selected == true) {
              academic_ids.push(ele.id);
            }
          });

          var obj = {afields: academic_ids};
          var user_response = {'user_response':{'answer_id':0,'question_id':$scope.question.id,'user_response': obj}};

          appFunc.updateUserResponse($scope.question, user_response, $scope, $scope.academics)
            .then(function(res) {
              if (res.success != true) {
                academic.selected = !academic.selected;
              }

              $scope.updateRequired();

            }, function(error) {
              //academic.selected = !academic.selected;
              $scope.updateRequired();
            })

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