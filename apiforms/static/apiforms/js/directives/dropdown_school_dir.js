var forms = angular.module('imForm');

/**
 * QUESTION_DROPDOWN_SCHOOLS = 13
 */
forms.directive('dropdownSchool',
  ['$compile', 'School', 'appFunc','$sce',
    function($compile, School, appFunc, $sce) {
      return {
        restrict: 'AEC',
        scope: {
          question: '=',
          schools: '=',
          fieldErrMsg: '=',
          updateUserResponse: '&'
        },
        templateUrl: '/new_platform/static/apiforms/drtvhtml/dropdown_school.html',
        link: function ($scope, $element, $attrs, $controller) {

          $scope.htmlText =
          $sce.trustAsHtml($scope.question.question_text);

          var savedUserResponse = $scope.question.user_response.user_response;
          $scope.schools = angular.copy($scope.schools);

          if (savedUserResponse) {
            /**
             * we have answered data
             */
            $scope.schoolName = savedUserResponse.school;
            $scope.class = _.find($scope.schools[$scope.schoolName], function(school) { return school.id === $scope.question.user_response.selected_id; });
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

            if (!$scope.schoolName || !$scope.class ) {
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
          $scope.update=function() {
            if (!$scope.schoolName && !$scope.class ) {
              appFunc.deleteUserResponse($scope.question, $scope);
            }
            else {
              if ($scope.updateRequired() === true) {
                return;
              }

              var obj = {school: $scope.schoolName};
              var user_response = {'user_response':{'answer_id':$scope.class.id,'question_id':$scope.question.id,'user_response': obj}};

              appFunc.updateUserResponse($scope.question, user_response, $scope).then(
            function(){ 
              $scope.updateRequired();  
            },function(){ 
              $scope.updateRequired();  
            });
            }
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
