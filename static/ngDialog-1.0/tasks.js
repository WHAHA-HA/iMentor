var app = angular.module('tasks', ['ngDialog']);

// default values for all dialogs
app.config(['ngDialogProvider', function (ngDialogProvider) {
  ngDialogProvider.setDefaults({
    className: 'ngdialog-theme-default',
    plain: false,
    showClose: true,
    closeByDocument: true,
    closeByEscape: true,
    appendTo: false,
    preCloseCallback: function () {
      console.log('default pre-close callback');
    }
  });
}]);

app.controller('TasksCtrl', function ($scope, $rootScope, ngDialog, $timeout) {
  $rootScope.jsonData = '{"foo": "bar"}';
  $rootScope.theme = 'Feb 26 2015 (Thursday)';

  $scope.directivePreCloseCallback = function (value) {
    if(confirm('Close it? MainCtrl.Directive. (Value = ' + value + ')')) {
      return true;
    }
    return false;
  };

  $scope.preCloseCallbackOnScope = function (value) {
    if(confirm('Close it? MainCtrl.OnScope (Value = ' + value + ')')) {
      return true;
    }
    return false;
  };


  $scope.openTasks = function () {
    $rootScope.theme = 'Feb 26 2015 (Thursday) at 6-8 PM';

    ngDialog.open({
      template: 'tasksTemplate',
      controller: ['$scope','tasktest', function ($scope, tasktest) {

        // to hide and show rsvp, rating and survey.
        $scope.hidersvp = false;
        $scope.hiderating = false;
        $scope.hidesurvey = false;

        $scope.closeRSVP = function() {
          $scope.hidersvp = true;
          if($scope.hidersvp === true && $scope.hiderating === true && $scope.hidesurvey === true){
            $scope.closeThisDialog();
          }
        }
        $scope.closeRating = function() {
          $scope.hiderating = true;
          if($scope.hidersvp === true && $scope.hiderating === true && $scope.hidesurvey === true){
            $scope.closeThisDialog();
          }
        }
        $scope.closeSurvey = function() {
          $scope.hidesurvey = true;
          if($scope.hidersvp === true && $scope.hiderating === true && $scope.hidesurvey === true){
            $scope.closeThisDialog();
          }
        }
        tasktest.fetch().then(function(data) {
        $scope.data = data;
        //$scope.taskName = data.
  })
      }],
      className: 'ngdialog-theme-plain'
    });
  };
/*
  $rootScope.$on('ngDialog.opened', function (e, $dialog) {
    console.log('ngDialog opened: ' + $dialog.attr('id'));
  });

  $rootScope.$on('ngDialog.closed', function (e, $dialog) {
    console.log('ngDialog closed: ' + $dialog.attr('id'));
  });

  $rootScope.$on('ngDialog.closing', function (e, $dialog) {
    console.log('ngDialog closing: ' + $dialog.attr('id'));
  });

  $rootScope.$on('ngDialog.templateLoading', function (e, template) {
    console.log('ngDialog template is loading: ' + template);
  });

  $rootScope.$on('ngDialog.templateLoaded', function (e, template) {
    console.log('ngDialog template loaded: ' + template);
  });*/
});

app.controller('InsideCtrl', function ($scope, ngDialog) {
  $scope.dialogModel = {
    message : 'message from passed scope'
  };
  $scope.openSecond = function () {
    ngDialog.open({
      template: '<h3><a href="" ng-click="closeSecond()">Close all by click here!</a></h3>',
      plain: true,
      closeByEscape: false,
      controller: 'SecondModalCtrl'
    });
  };
});

app.controller('InsideCtrlAs', function () {
  this.value = 'value from controller';
});

app.controller('SecondModalCtrl', function ($scope, ngDialog) {
  $scope.closeSecond = function () {
    ngDialog.close();
  };
});




app.factory('tasktest', function($q, $timeout, $http) {
  var Tasktest = {
    fetch: function(callback) {

      var deferred = $q.defer();

      $timeout(function() {
        $http.get('//cdn.imentor.org/new_platform/static/ngDialog/taskdata.json').success(function(data) {
          deferred.resolve(data);
        });
      }, 30);

      return deferred.promise;
    }
  };

  return Tasktest;
});

app.filter('range', function() {
  return function(input, total) {
    total = parseInt(total);
    for (var i=1; i<=total; i++)
      input.push(i);
    return input;
  };
});
