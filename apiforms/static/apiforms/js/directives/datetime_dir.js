var forms = angular.module('imForm');


/**
 * QUESTION_DATETIME = 14
 */
forms.directive('datetime',
  ['$compile', 'appFunc','$sce',
    function($compile, appFunc, $sce) {
      return {
        restrict: 'AEC',
        scope: {
          question: '=',
          fieldErrMsg: '=',
          updateUserResponse: '&'
        },
        templateUrl: '/new_platform/static/apiforms/drtvhtml/datetime.html',
        link: function ($scope, $element, $attrs, $controller) {

          $scope.htmlText =
          $sce.trustAsHtml($scope.question.question_text);

          /**
           * returns days for the year & month
           * @param month
           * @param year
           * @returns {number}
           */
          $scope.refreshDays = function() {


            if (!$scope.month || $scope.month.index < 1) {
              $scope.days = [];
              return $scope.days;
            }

            // We get the days In month same as 2016 to show Feb = 29days always
            var daysInMonth = (new Date(2016, $scope.month.index, 0)).getDate();

            var currentEndDay = $scope.days.length;

            for (var i=currentEndDay+1; i<= daysInMonth; i++) {
              $scope.days.push({id: i});
            }

            for (i=daysInMonth+1; i<= currentEndDay; i++) {
              $scope.days.pop();
            }

            $scope.updateRequired();

            return $scope.days;

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

            if (!$scope.month
              || !$scope.year
              || !$scope.day
            ) {
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

            var month = '', day = '', year='';

            if ($scope.month) {
              month = $scope.month.index;
            }

            if ($scope.day) {
              day = $scope.day.id;
            }

            if ($scope.year) {
              year = $scope.year;
            }

            if ($scope.prevValue.month === month && $scope.prevValue.year === $scope.year && $scope.prevValue.day === day && (angular.isDefined($scope.question.hasSaveError)=== false || $scope.question.hasSaveError == false)) {
              return;
            }

            $scope.prevValue.month = month;
            $scope.prevValue.year = $scope.year;
            $scope.prevValue.day = day;

            $scope.question.edited = true;

            if (month === '' && year === '' && day === '') {
              // delete
              appFunc.deleteUserResponse($scope.question, $scope).then(
            function(){ 
              $scope.updateRequired();  
            },function(){ 
              $scope.updateRequired();  
            });
              return;
            }

            if ($scope.updateRequired() === true) {
              return;
            }

            var obj = {
              'month': month,
              'year': $scope.year,
              'day': day
            };

            var user_response = {'user_response':{'answer_id':0,'question_id':$scope.question.id,'user_response': obj}};

            appFunc.updateUserResponse($scope.question, user_response, $scope).then(
            function(){ 
              $scope.updateRequired();  
            },function(){ 
              $scope.updateRequired();  
            });

          };

          /**
           * Initialize months, dates, years
           */

          $scope.months=[
            {index:1, title: 'January'},
            {index:2, title: 'February'},
            {index:3, title: 'March'},
            {index:4, title: 'April'},
            {index:5, title: 'May'},
            {index:6, title: 'June'},
            {index:7, title: 'July'},
            {index:8, title: 'August'},
            {index:9, title: 'September'},
            {index:10, title: 'October'},
            {index:11, title: 'November'},
            {index:12, title: 'December'}
          ];

          $scope.years = [];
          $scope.days = [];

          var yearStart = 1930, yearEnd = 2004;

          for (var i= yearStart; i< yearEnd; i++) {
            $scope.years.push(i);
          }

          /**
           * Load UserResponse Saved value to frontend
           */
          var savedUserResponse = $scope.question.user_response.user_response;
          $scope.prevValue = {month: '', year: '', day: ''};

          if (savedUserResponse) {
            /**
             * we have answered data
             */
            if (savedUserResponse.month) {
              $scope.month = $scope.months[savedUserResponse.month-1];
              $scope.prevValue.month = savedUserResponse.month;
            }

            $scope.refreshDays();

            if (savedUserResponse.day) {
              $scope.day = $scope.days[savedUserResponse.day-1];
              $scope.prevValue.day = savedUserResponse.day;
            }
            if (savedUserResponse.year) {
              $scope.year = $scope.years[savedUserResponse.year-yearStart];
              $scope.prevValue.year = savedUserResponse.year;
            }

          }

          //update required status
          $scope.updateRequired();
          $scope.question.edited = false;
          $scope.tabIndex = $scope.question.ordinal * 100 + $scope.question.sub_ordinal;
          $scope.question.updateRequired = $scope.updateRequired; // save the function point
        }
      }
    }
  ]);
