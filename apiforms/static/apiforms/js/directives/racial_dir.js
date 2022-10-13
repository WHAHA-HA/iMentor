var forms = angular.module('imForm');


/**
 * QUESTION_RACIAL_GROUP = 19
 */
forms.directive('racial', ['appFunc','$sce',
  function(appFunc, $sce) {
    return {
      restrict: 'AEC',
      scope: {
        question: '=',
        racials: '=',
        fieldErrMsg: '=',
        updateUserResponse: '&'
      },
      templateUrl: '/new_platform/static/apiforms/drtvhtml/racial.html',
      link: function($scope,$element, $attrs, $controller) {

        $scope.htmlText =
        $sce.trustAsHtml($scope.question.question_text);

        var savedUerResponse = $scope.question.user_response.user_response;
        $scope.racials = angular.copy($scope.racials);
        var anonymousRaceOrdinal = 700;

        if (savedUerResponse) {

          for (var i=0; i <savedUerResponse.rgroups.length; i++) {

            var ele = _.find($scope.racials, function(race) { return race.id === savedUerResponse.rgroups[i]; });
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
          
          var racial_ids = [];

          _.each($scope.racials, function(ele) {
            if (ele.selected == true) {
              racial_ids.push(ele.id);
            }
          });

          if ($scope.question.is_visible !== true || $scope.question.is_required !== true) {
            $scope.question.required = false;
            return false;
          }

          if (racial_ids.length ==0) {
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


        $scope.update=function(racial) {

          $scope.question.edited = true;


          if (racial === null ) {
            $scope.error = 'Error';
            return;
          }
          if(racial) {  // this could be undefined if update called from gotonext function
            racial.selected = !racial.selected;
          }
          /**
           * check : "I would prefer not to indicate my race" selected or not
           */

          var racial_ids = [];
          _.each($scope.racials, function(ele) {
            if(racial) { // this could be undefined if update called from gotonext function
              if (racial.ordinal === anonymousRaceOrdinal && ele.ordinal !==anonymousRaceOrdinal ) {
                ele.selected = false;
              }

              if (racial.ordinal !== anonymousRaceOrdinal && ele.ordinal ===anonymousRaceOrdinal ) {
                ele.selected = false;
              }
            }
            if (ele.selected == true) {
              racial_ids.push(ele.id);
            }
          });

          if (racial_ids.length == 0 ) {
            // delete
            appFunc.deleteUserResponse($scope.question, $scope)
              .then(function(res) {

                if (res.success != true) {
                  racial.selected = !racial.selected;
                }
                $scope.updateRequired();

              }, function (error) {
                //revert back the selection
                //racial.selected = !racial.selected;
                $scope.updateRequired();
              });
            return;
          }
          else if ($scope.updateRequired() === true) {
            return;
          }

          var obj = {rgroups: racial_ids};
          var user_response = {'user_response':{'answer_id':0,'question_id':$scope.question.id,'user_response': obj}};

          appFunc.updateUserResponse($scope.question, user_response, $scope, $scope.racials)
            .then(function(res) {

              if (res.success != true) {
                racial.selected = !racial.selected;
              }
              $scope.updateRequired();
            }, function (error) {
              //racial.selected = !racial.selected;
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
