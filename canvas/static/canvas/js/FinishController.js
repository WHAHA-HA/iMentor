(function () {
  'use strict';
  var controllerId = 'FinishController';

  angular.module('canvas').controller(controllerId, FinishController);

  FinishController.$inject = ['common', 'datacontext','toastr', '$scope', '$location','$window', '$timeout'];

  function FinishController(common, datacontext, toastr, $scope,$location,$window, $timeout) {
    //$('body').css({'background': 'url(//cdn.imentor.org/new_platform/static/canvas/images/finish-sm.jpg)' + 'no-repeat center center fixed'});
    //$('body').css({'background-size': 'cover'});
    
    var imentor_cdn_prefix = typeof getCdnUrlPrefix == 'function' ? getCdnUrlPrefix() : '';

    $('body').css({'background-image': 'url(' + imentor_cdn_prefix + '/new_platform/static/canvas/images/finish-sm.jpg)'});
    $('#saveNotification').css({'display': 'none'});

    $scope.subdomain = $window.location.host;

    $scope.reviewWork = function () {
      $('body').css({'background': 'url(' + imentor_cdn_prefix + '/new_platform/static/canvas/images/canvas_blurry_bg-sm.jpg)' + 'no-repeat center center fixed'});
      $('body').css({'background-size': 'cover'});
      $('#saveNotification').css({'display': 'inline'});
      $location.path( "/" );
    };
    $scope.goHref = function ( path ) {
      var newUrl = '//' + $scope.subdomain  + path;
      $window.location.href = newUrl;
    };
    $scope.logout = function () {
      var logoutUrl = "//" + $window.location.host + "/iuser/logout/";
      $window.location.href = logoutUrl;
    };

    //Workaround for some background size issue - not used 
    /*$scope.$on('$viewContentLoaded', function(event) {
      $timeout(function() {
         $window.triggerHandler('resize');
      },0);
    });*/
  }
})();
