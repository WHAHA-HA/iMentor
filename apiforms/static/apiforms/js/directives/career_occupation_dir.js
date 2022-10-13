var forms = angular.module('imForm');


/**
 * QUESTION_CAREERS_INSTRUCTIONS = 17
 */
forms.directive('careerOccupation',
  ['$compile', 'appFunc','$sce', '$q',
    function($compile, appFunc, $sce, $q) {
      return {
        restrict: 'AEC',
        scope: {
          question: '=',
          careers: '=',
          fieldErrMsg: '=',
          updateUserResponse: '&'
        },
        templateUrl: '/new_platform/static/apiforms/drtvhtml/career_occupation.html',
        link: function ($scope, $element, $attrs, $controller) {

          $scope.htmlText = $sce.trustAsHtml($scope.question.question_text);

          var savedUerResponse = $scope.question.user_response.user_response;
          $scope.careers = angular.copy($scope.careers);

          if (savedUerResponse) {

            $scope.career = _.find($scope.careers, function(career) { return career.id === savedUerResponse.career_id; });

            if ($scope.career) {
              $scope.career.selected = true;
            }

            for (var i=0; i <savedUerResponse.occupations.length; i++) {

              var ele = _.find($scope.career.occupations, function(occupation) { return occupation.id === savedUerResponse.occupations[i]; });
              if ( typeof ele !== 'undefined') {
                ele.selected = true;
              }

            }

          }


          /**
           * Select Career Scope variable
           */
          $scope.selectCareer = function(career) {

            $scope.update(career)
              .then(function(res) {
                if (res.success == true) {
                  //update only success
                  $scope.career = career;
                }
              });
          };

          /**
           * Select Occupation Scope variable
           */
          $scope.selectOccupation = function(occupation) {
            occupation.selected = !occupation.selected;

            $scope.update($scope.career)
              .then(function(res) {

                if (res.success != true) {
                  occupation.selected = !occupation.selected;
                }

              }, function (error) {
                //revert back the selection
                occupation.selected = !occupation.selected;
              });
          };

          /**
           * Update required field status
           */
          $scope.updateRequired = function(career) {
            $scope.question.showRequired = false;
          
            if ($scope.question.is_visible !== true || $scope.question.is_required !== true) {
              $scope.question.required = false;
              return false;
            }

            if (!career) {
              $scope.question.required = true;
              return true;
            }

            var occupation_ids = [];

            _.each(career.occupations, function(ele) {
              if (ele.selected == true) {
                occupation_ids.push(ele.id);
              }
            });

            if (occupation_ids.length ==0) {
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

          /**
           * Update
           */
          $scope.update=function(career) {

            $scope.question.edited = true;
            var occupation_ids = [];
            var deferred =$q.defer();

            _.each(career.occupations, function(ele) {
              if (ele.selected == true) {
                occupation_ids.push(ele.id);
              }
            });


            if (!career && occupation_ids.length == 0 ) {
              // delete
              return appFunc.deleteUserResponse($scope.question, $scope);
            }

            if ($scope.updateRequired(career) === true) {
              deferred.resolve({success: true});
              return deferred.promise;
            }

            var obj = {career_id: career.id, occupations: occupation_ids};
            var user_response = {'user_response':{'answer_id':0,'question_id':$scope.question.id,'user_response': obj}};

            return appFunc.updateUserResponse($scope.question, user_response, career.occupations);

          };

          //update required status
          $scope.updateRequired($scope.career);
          $scope.question.edited = false;
          $scope.tabIndex = $scope.question.ordinal * 100 + $scope.question.sub_ordinal;
          $scope.question.updateRequired = $scope.updateRequired; // save the function point
        }
      }
    }
  ]);