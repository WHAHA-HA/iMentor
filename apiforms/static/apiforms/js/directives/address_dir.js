var forms = angular.module('imForm');


/**
 * QUESTION_ADDRESS = 4
 */

forms.directive('address',
  ['$compile', 'appFunc',"$sce",
    function($compile, appFunc, $sce){

      return {
        restrict: 'AEC',
        scope: {
          question: '=',
          fieldErrMsg: '=',
          updateUserResponse: '&',
          states: '='
        },
        templateUrl: '/new_platform/static/apiforms/drtvhtml/address.html',
        link: function($scope,$element,$attrs,$controller) {

          $scope.htmlText =
          $sce.trustAsHtml($scope.question.question_text);
          $scope.prevValue = {};

          if ($scope.question.user_response.user_response && $scope.question.user_response.user_response.state_id) {
            /**
             * we have answered data
             */
            $scope.state = _.findWhere($scope.states, {id: $scope.question.user_response.user_response.state_id}) || null;

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

            if (!$scope.question.user_response || !$scope.question.user_response.user_response
              || !$scope.question.user_response.user_response.address || !$scope.question.user_response.user_response.city
              || !$scope.question.user_response.user_response.zipcode || !$scope.state || !$scope.state.id) {
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


          $scope.update = function() {

            var stateId = '';

            if (!$scope.state) {
              stateId = '';
            }
            else {
              stateId = $scope.state.id;
            }

            if ($scope.prevValue.address === $scope.question.user_response.user_response.address
            && $scope.prevValue.city === $scope.question.user_response.user_response.city
            && $scope.prevValue.zipcode === $scope.question.user_response.user_response.zipcode
            && $scope.prevValue.stateId === stateId && (angular.isDefined($scope.question.hasSaveError)=== false || $scope.question.hasSaveError == false)) {
              return;
            }

            $scope.prevValue.address = $scope.question.user_response.user_response.address;
            $scope.prevValue.city = $scope.question.user_response.user_response.city;
            $scope.prevValue.zipcode = $scope.question.user_response.user_response.zipcode;
            $scope.prevValue.stateId = stateId;

            //should delete?
            if ($scope.question.user_response.hasOwnProperty('user_response') && !$scope.question.user_response.user_response.address && !$scope.question.user_response.user_response.city
            && !$scope.question.user_response.user_response.zipcode && !$scope.state ) {
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

              var obj = {
                'address': $scope.question.user_response.user_response.address,
                'city': $scope.question.user_response.user_response.city,
                'state_id': $scope.state.id,
                'zipcode': $scope.question.user_response.user_response.zipcode
              };

              var user_response = {'user_response':{'answer_id':0,'question_id':$scope.question.id,'user_response': obj}};

              appFunc.updateUserResponse($scope.question, user_response, $scope).then(
              function(){ 
                $scope.updateRequired();  
              },function(){ 
                $scope.updateRequired();  
              });

            }

          };

          //keep original value
          if ($scope.question.user_response.user_response) {
            $scope.prevValue.address = $scope.question.user_response.user_response.address;
            $scope.prevValue.city = $scope.question.user_response.user_response.city;
            $scope.prevValue.zipcode = $scope.question.user_response.user_response.zipcode;
            $scope.prevValue.stateId = $scope.question.user_response.user_response.state_id;
          }
          else {
            $scope.question.user_response.user_response = {};
            $scope.prevValue.stateId = '';
          }

          //update required status
          $scope.updateRequired();
          $scope.question.edited = false; // initialize edited = false
          $scope.tabIndex = $scope.question.ordinal * 100 + $scope.question.sub_ordinal;
          $scope.question.updateRequired = $scope.updateRequired; // save the function point
        }
      }
    }
  ]);
