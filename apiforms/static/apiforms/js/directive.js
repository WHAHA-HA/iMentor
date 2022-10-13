var forms = angular.module('imForm');



/**
 * QUESTION_SINGLE_SELECT_RADIO = 6
 */
forms.directive('singleSelectRadio',  ['appFunc',"$sce",
  function(appFunc, $sce) {
    return {
      restrict: 'AEC',
      scope: {
        question: '=',
        fieldErrMsg: '=',
        updateUserResponse: '&'
      },
      templateUrl: '/new_platform/static/apiforms/drtvhtml/single_select_radio.html',
      link: function($scope,$element,$attrs,$controller) {

        $scope.htmlText =
        $sce.trustAsHtml($scope.question.question_text);
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

          if (!$scope.question.user_response || !$scope.question.user_response.answer_id) {
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

          /**
           * Deselect this if user click same item again
           */
          var user_response = null;
          if (answer.id === $scope.question.user_response.answer_id) {
            // should delete the row
            //user_response = {'user_response':{'answer_id':0,'question_id':$scope.question.id,'user_response': null}};
            appFunc.deleteUserResponse($scope.question, $scope)
              .then(function(res) {

                if (res.success == true) {
                  $scope.question.user_response.answer_id = 0;
                }

                $scope.updateRequired();

              }, function (error) {
                $scope.updateRequired();
              });
          }
          else {
            user_response = {'user_response':{'answer_id':answer.id,'question_id':$scope.question.id,'user_response': null}};
            appFunc.updateUserResponse($scope.question, user_response, $scope)
              .then(function(res) {

                if (res.success == true) {
                  $scope.question.user_response.answer_id = answer.id;
                }

                $scope.updateRequired();

              }, function (error) {
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


/**
 * QUESTION_Dropdown = 8
 */
forms.directive('dropdown', ['appFunc',"$sce",
  function(appFunc, $sce) {
    return {
      restrict: 'AEC',
      scope: {
        question: '=',
        fieldErrMsg: '=',
        updateUserResponse: '&'
      },
      templateUrl: '/new_platform/static/apiforms/drtvhtml/dropdown.html',
      link: function($scope,$element,$attrs,$controller) {

        $scope.htmlText =
        $sce.trustAsHtml($scope.question.question_text);
        $scope.answers = $scope.question.answers;

        if ($scope.question.user_response.answer_id) {
          /**
           * we have answered data
           */
          $scope.answer = _.findWhere($scope.answers, {id: $scope.question.user_response.answer_id}) || null;
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

          if (!$scope.answer || !$scope.answer.id) {
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

        $scope.update=function() {

          $scope.question.edited = true;
          if ($scope.updateRequired() === true) {
            return;
          }

          var user_response = {'user_response':{'answer_id':$scope.answer.id,'question_id':$scope.question.id,'user_response': null}};
          appFunc.updateUserResponse($scope.question, user_response, $scope).then(
            function(){ 
              $scope.updateRequired();  
            },function(){ 
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


/**
 * QUESTION_DROPDOWN_COUNTRIES = 9
 */
forms.directive('dropdownCountry',
  ['$compile', 'appFunc',"$sce",
    function($compile, appFunc, $sce) {
      return {
        restrict: 'AEC',
        scope: {
          question: '=',
          countries: '=',
          fieldErrMsg: '=',
          updateUserResponse: '&'
        },
        templateUrl: '/new_platform/static/apiforms/drtvhtml/dropdown_country.html',
        link: function ($scope, $element, $attrs, $controller) {

          $scope.htmlText =
          $sce.trustAsHtml($scope.question.question_text);
          if ($scope.question.user_response.selected_id) {
            /**
             * we have answered data
             */
            $scope.country = _.findWhere($scope.countries, {id: $scope.question.user_response.selected_id}) || null;
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

            if (!$scope.country || !$scope.country.id) {
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

          $scope.update=function() {

            if ($scope.updateRequired() === true) {
              return;
            }

            var user_response = {'user_response':{'answer_id':$scope.country.id,'question_id':$scope.question.id,'user_response': null}};
            appFunc.updateUserResponse($scope.question, user_response, $scope).then(
            function(){ 
              $scope.updateRequired();  
            },function(){ 
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

/**
 * QUESTION_DROPDOWN_STATES = 10 # US states.
 */
forms.directive('dropdownState',
  ['$compile', 'appFunc','$sce',
    function($compile, appFunc, $sce) {
      return {
        restrict: 'AEC',
        scope: {
          question: '=',
          states: '=',
          fieldErrMsg: '=',
          updateUserResponse: '&'
        },
        templateUrl: '/new_platform/static/apiforms/drtvhtml/dropdown_state.html',
        link: function ($scope, $element, $attrs, $controller) {

          $scope.htmlText =
          $sce.trustAsHtml($scope.question.question_text);

          if ($scope.question.user_response.answer_id) {
            /**
             * we have answered data
             */
            $scope.state = _.findWhere($scope.states, {id: $scope.question.user_response.answer_id}) || null;
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

            if (!$scope.state || !$scope.state.id) {
              $scope.question.required = true;
            }
            else {
              $scope.question.required = false;
            }

            if($scope.error && $scope.error!='') {
              $scope.question.required = true;
              console.log('Question has error.');
              return false;
            } else{
              return $scope.question.required;
            }
          };

          $scope.update=function() {

            $scope.question.edited = true;

            if ($scope.updateRequired() === true) {
              return;
            }

            var user_response = {'user_response':{'answer_id':$scope.state.id,'question_id':$scope.question.id,'user_response': null}};
            appFunc.updateUserResponse($scope.question, user_response, $scope).then(
            function(){ 
              $scope.updateRequired();  
            },function(){ 
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


/**
 * QUESTION_DROPDOWN_COLLEGES = 12
 */
forms.directive('dropdownCollege',
  ['$compile', 'College', 'appFunc',"$sce",
    function($compile, College, appFunc, $sce) {
      return {
        restrict: 'AEC',
        scope: {
          question: '=',
          fieldErrMsg: '=',
          updateUserResponse: '&'
        },
        templateUrl: '/new_platform/static/apiforms/drtvhtml/dropdown_college.html',
        link: function ($scope, $element, $attrs, $controller) {

          $scope.htmlText =
          $sce.trustAsHtml($scope.question.question_text);
          //Initialize colleges
          $scope.colleges = [];

          var savedUserResponse = $scope.question.user_response.user_response;

          if (savedUserResponse && savedUserResponse.colleges) {

            /**
             * we have answered data
             */
            _.each(savedUserResponse.colleges, function(ele) {
              $scope.colleges.push (ele);
            });
          }


          $scope.updateValidState = function() {
            if (($scope.college || null) === null && $scope.colleges.length === 0) {
              $scope.question.isValidState = false;
            }
            else {
              $scope.question.isValidState = true;
            }

          };


          /**
           * getColleges for filtering out the typeahead search
           * @param value
           */
          $scope.getColleges = function (value) {

            return College.query({filter: value})
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

          /**
           * Update required field status
           */
          $scope.updateRequired = function() {
            $scope.question.showRequired = false;
          
            if ($scope.question.is_visible !== true || $scope.question.is_required !== true) {
              $scope.question.required = false;
              return false;
            }

            if ($scope.colleges.length === 0) {
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
           * add colleges
           */
          $scope.onSelect = function ($item, $model, $label) {

            $scope.college = '';
            $scope.question.edited = true;

            if ($item.id === 0) {

              if ($scope.colleges.length === 0) {
                $scope.colleges.push($item);
                $scope.update();
              }

            }
            else {

              /**
               * Check whether it is already included in the list or not
               */
              var ele = _.findWhere($scope.colleges, {id: $item.id});

              if ( typeof ele === 'undefined') {
                $scope.colleges.push($item);
                $scope.update();
              }

            }

            $scope.updateValidState();

          };

          /**
           * Remove college from added College
           */

          $scope.removeCollege = function (college) {

            $scope.question.edited = true;
            /**
             * Check whether it is already included in the list or not
             */
            var ele = _.findWhere($scope.colleges, {id: college.id});

            if ( typeof ele !== 'undefined') {
              $scope.colleges = _.without($scope.colleges, ele);
              $scope.update();
            }

          };

          /**
           * Update
           */
          $scope.update=function() {

            if ($scope.updateRequired() === true) {
              return;
            }

            var obj = {colleges: $scope.colleges};
            var user_response = {'user_response':{'answer_id':0, 'question_id':$scope.question.id,'user_response': obj}};

            appFunc.updateUserResponse($scope.question, user_response, $scope).then(
            function(){ 
              $scope.updateRequired();  
            },function(){ 
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


/**
 * QUESTION_HEADING = 15
 */
forms.directive('heading',
  ['$compile', 'appFunc', '$sce',
    function($compile, appFunc, $sce) {
      return {
        restrict: 'AEC',
        scope: {
          question: '=',
          fieldErrMsg: '='
        },
        templateUrl: '/new_platform/static/apiforms/drtvhtml/heading.html',

        link: function ($scope, $element, $attrs, $controller) {
          $scope.tabIndex = $scope.question.ordinal * 100 + $scope.question.sub_ordinal;
          $scope.htmlText =
          $sce.trustAsHtml($scope.question.question_text);
        }
      }
    }
  ]);


/**
 * QUESTION_HEADING = 16
 */
forms.directive('instruction',
  ['$compile', '$sce', 'appFunc',
    function($compile, $sce, appFunc) {
      return {
        restrict: 'AEC',
        scope: {
          question: '=',
          fieldErrMsg: '='
        },
        templateUrl: '/new_platform/static/apiforms/drtvhtml/instruction.html',
        link: function ($scope, $element, $attrs, $controller) {

          $scope.htmlText =
            $sce.trustAsHtml($scope.question.question_text);

          $scope.tabIndex = $scope.question.ordinal * 100 + $scope.question.sub_ordinal;

        }
      }
    }
  ]);



/**
 * QUESTION_PARTNER_PROGRAM = 21
 */
forms.directive('program', ['appFunc','$sce',
  function(appFunc, $sce) {
    return {
      restrict: 'AEC',
      scope: {
        
        question: '=',
        programs: '=',
        fieldErrMsg: '=',
        updateUserResponse: '&'
      },
      templateUrl: '/new_platform/static/apiforms/drtvhtml/program.html',
      link: function($scope,$element, $attrs, $controller) {

        $scope.htmlText =
        $sce.trustAsHtml($scope.question.question_text);

        var savedUerResponse = $scope.question.user_response.user_response;
        $scope.programs = angular.copy($scope.programs);

        if (savedUerResponse) {

          for (var i=0; i <savedUerResponse.mprograms.length; i++) {
            var ele = _.find($scope.programs, function(program) { return program.id === savedUerResponse.mprograms[i]; });
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

          var program_ids = [];

          _.each($scope.programs, function(ele) {
            if (ele.selected == true) {
              program_ids.push(ele.id);
            }
          });

          if (program_ids.length ==0) {
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


        $scope.update=function(program) {

          $scope.question.edited = true;
          if(program) {
            program.selected = !program.selected;
          }

          var program_ids = [];

          _.each($scope.programs, function(ele) {
            if (ele.selected == true) {
              program_ids.push(ele.id);
            }
          });

          if (program_ids.length == 0 ) {
            // delete
            appFunc.deleteUserResponse($scope.question, $scope)
              .then(function(res) {

                if (res.success != true) {
                  //revert selection
                  program.selected = !program.selected;
                }
                $scope.updateRequired();
              }, function (error) {
                //revert back the selection
                //program.selected = !program.selected
                $scope.updateRequired();
              });
            return;
          }

           if ($scope.updateRequired() === true) {
            return;
          }

          var obj = {mprograms: program_ids};
          var user_response = {'user_response':{'answer_id':0,'question_id':$scope.question.id,'user_response': obj}};

          appFunc.updateUserResponse($scope.question, user_response, $scope, $scope.programs)
            .then(function(res) {

              if (res.success != true) {
                program.selected = !program.selected;
              }
              $scope.updateRequired();

            }, function (error) {
              //program.selected = !program.selected;
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

forms.directive('ngEnter', function() {
  return function(scope, element, attrs) {

    element.bind("keydown keypress", function(event) {
      var keyCode = event.which || event.keyCode;

      // If enter key is pressed
      if (keyCode === 13) {
        scope.$apply(function() {
          // Evaluate the expression
          scope.$eval(attrs.ngEnter);
        });

        event.preventDefault();
      }
    });
  };
});
