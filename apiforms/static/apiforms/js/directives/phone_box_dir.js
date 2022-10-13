var forms = angular.module('imForm');


/**
 * QUESTION_PHONE = 3
 */
forms.directive('phoneBox',
  ['$compile', 'appFunc', "$sce",
  function($compile, appFunc, $sce){

    return {
      restrict: 'AEC',
      scope: {
        question: '=',
        fieldErrMsg: '=',
        updateUserResponse: '&'

      },
      templateUrl: '/new_platform/static/apiforms/drtvhtml/phonebox.html',
      link: function($scope,$element,$attrs, $controller) {

        $scope.htmlText =
        $sce.trustAsHtml($scope.question.question_text);
        $scope.phoneNumbers =['','',''];
        $scope.prevValues =['','',''];


        if ($scope.question.user_response.user_response) {
          $scope.phoneNumbers[0] = $scope.question.user_response.user_response.substring(0,3);
          $scope.phoneNumbers[1] = $scope.question.user_response.user_response.substring(3,6);
          $scope.phoneNumbers[2] = $scope.question.user_response.user_response.substring(6,10);

          //keep original value
          $scope.prevValues[0] = $scope.phoneNumbers[0];
          $scope.prevValues[1] = $scope.phoneNumbers[1];
          $scope.prevValues[2] = $scope.phoneNumbers[2];
        }

        /**
         * Move Control Focus
         */
        $scope.moveFocus = function(index) {

          var elements = angular.element('#q'+$scope.question.id+' .phone-box .phone-number');


          if (index===0 || index===1) {
            if ($scope.phoneNumbers[index] && $scope.phoneNumbers[index].length >= 3){
              elements[index + 1].focus();
            }
          }

          $scope.updateRequired();
        };

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

          for (var i=0; i< $scope.phoneNumbers.length; i++ ) {
            if ( typeof $scope.phoneNumbers[i] === "undefined" || $scope.phoneNumbers[i] === '' ) {
              $scope.question.required = true;
              return true;
            }
          }

          if($scope.error && $scope.error!='') {
            console.log('Question has error.');
            $scope.question.required = true;
            return false;
          } else{
            $scope.question.required = false;
            return false;
          }
          
        };

        $scope.update = function() {

          if ($scope.prevValues[0] === $scope.phoneNumbers[0] && $scope.prevValues[1] === $scope.phoneNumbers[1] && $scope.prevValues[2] === $scope.phoneNumbers[2]) {

            if(angular.isDefined($scope.question.hasSaveError)=== false || (angular.isDefined($scope.question.hasSaveError)=== true && $scope.question.hasSaveError === false)) {
              return;
            }
          }

          $scope.prevValues[0] = $scope.phoneNumbers[0];
          $scope.prevValues[1] = $scope.phoneNumbers[1];
          $scope.prevValues[2] = $scope.phoneNumbers[2];

          // should delete
          if (!$scope.phoneNumbers[0] && !$scope.phoneNumbers[1] && !$scope.phoneNumbers[2] ) {
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

            //it will post only if 3 phone numbers are provided
            if ($scope.question.is_visible !== true || $scope.question.is_required !== true) {
              for (var i=0; i< $scope.phoneNumbers.length; i++ ) {
                if (typeof $scope.phoneNumbers[i] === "undefined" || $scope.phoneNumbers[i] === '' ) {
                  return true;
                }
              }
            }

            $scope.question.user_response.user_response = $scope.phoneNumbers[0]+$scope.phoneNumbers[1]+$scope.phoneNumbers[2];
            var user_response = {'user_response':{'answer_id':0,'question_id':$scope.question.id,'user_response': $scope.question.user_response.user_response}};

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
