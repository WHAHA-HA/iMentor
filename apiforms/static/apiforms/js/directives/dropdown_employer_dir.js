var forms = angular.module('imForm');

/**
 * QUESTION_DROPDOWN_EMPLOYERS = 11
 */
forms.directive('dropdownEmployer',
  ['$compile', 'Employer', 'appFunc',"$sce",
    function($compile, Employer, appFunc, $sce) {
      return {
        restrict: 'AEC',
        scope: {
          question: '=',
          fieldErrMsg: '=',
          updateUserResponse: '&'
        },
        templateUrl: '/new_platform/static/apiforms/drtvhtml/dropdown_employer.html',
        link: function ($scope, $element, $attrs, $controller) {

          $scope.htmlText =
          $sce.trustAsHtml($scope.question.question_text);

          if ($scope.question.user_response && $scope.question.user_response.user_response) {
            $scope.employer = {
              id: $scope.question.user_response.selected_id, // we use selected_id for employer
              name: $scope.question.user_response.user_response
            };
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

            if (!$scope.question.user_response.user_response) {
              $scope.question.required = true;
            }
            if(!$scope.employer){
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
           * getEmployers for filtering out the typeahead search
           * @param value
           */
          $scope.getEmployers = function (value) {

            return Employer.query({filter: value})
              .$promise.then(function(response){

                if (response.length == 0) {
                 return [{
                   id: 0,
                   name: 'Not Listed'
                 }];
                }

                return response;
              });

          };

          $scope.onSelect = function ($item, $model, $label) {
            $scope.employer = $item;
            $scope.question.edited = true;
            if ($scope.updateRequired() === true) {
              return;
            }
          };

          /**
           * Update
           */
          $scope.update=function() {

            if ($scope.updateRequired() === true) {
              return;
            }

            var employerId=0;

            if ($scope.employer) {
              employerId = $scope.employer.id;
            }else{
              $scope.updateRequired();
            }


            var user_response = {
              'user_response':{
                'answer_id':employerId,
                'question_id':$scope.question.id,
                'user_response': $scope.employer.name
              }
            };
            console.log(user_response);
            appFunc.updateUserResponse($scope.question, user_response, $scope).then(
            function(){ 
              $scope.updateRequired();  
            },function(){ 
              $scope.updateRequired();  
            });
          };

          $scope.clearEmployer = function() {
            $scope.employer = null;
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
