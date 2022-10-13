var app = angular.module('tasks', ['ngDialog','ui.mask']);
// Whitelist cdn 
app.config(['$sceDelegateProvider', function($sceDelegateProvider){
    $sceDelegateProvider.resourceUrlWhitelist([
        // Allow same origin resource loads.
        'self',
        // Allow loading from outer templates domain.
        'https://cdn.imentor.org/**'
    ]); 
}]);

app.directive('multiSelectDate', function($filter) {
  return {
    restrict: 'E',
    require: '?ngModel',
    templateUrl: 'multiSelectDate',
    link: function(scope, element, attrs, ngModel) {
      if (!ngModel) return;

      // GET FROM NG MODEL AND PUT IT IN LOCAL SCOPE
      ngModel.$render = function() {
        if(isNaN(Date.parse(ngModel.$viewValue))){
          scope.date = {
            day: '',
            month: '',
            year: ''
          };
        } else {
          scope.date = {
            day: $filter('date')(ngModel.$viewValue, 'dd'),
            month: $filter('date')(ngModel.$viewValue, 'MM'),
            year: $filter('date')(ngModel.$viewValue, 'yyyy')
          };
        } 
      };

      // ATTRIBUTES (with default values if not set)
      scope.yearOrder = (attrs.yearOrder && attrs.yearOrder === 'asc') ? false : true; // year order: 'asc' or 'desc', default: desc
      var endYear = attrs.endYear || new Date().getFullYear(); // default: this year
      var startYear = attrs.startYear || startYear - 20; // default: this year - 100

      // INIT YEARS, MONTHS AND DAYS NUMBER
      scope.selects = {

        days: function() {

          // Get number of days based on month + year
          // (January = 31, February = 28, April = 30, February 2000 = 29) or 31 if no month selected yet
          var nbDays = new Date(scope.date.year, scope.date.month, 0).getDate() || 31;

          var daysList = [];
          for (var i = 1; i <= nbDays; i++) {
            var iS = i.toString();
            daysList.push((iS.length < 2) ? '0' + iS : iS); // Adds a leading 0 if single digit
          }
          return daysList;
        },
        months: function() {
          var months = [
            'January',
            'February',
            'March',
            'April',
            'May',
            'June',
            'July',
            'August',
            'September',
            'October',
            'November',
            'December'
          ];
          var monthList = [];
          for (var i = 1; i <= 12; i++) {
            var iS = i.toString();
            monthList.push((iS.length < 2) ? '0' + iS : iS); // Adds a leading 0 if single digit
          }
          return monthList;
        },
        years: function() {
          var yearsList = [];
          for (var i = endYear; i >= startYear; i--) {
            yearsList.push(i.toString());
          }
          return yearsList;
        }
      };

      // WATCH FOR scope.date CHANGES
      scope.$watch('date', function(date) {

        // IF REQUIRED
        if (attrs.required) {

          // VALIDATION RULES
          var yearIsValid = !!date.year && parseInt(date.year) <= endYear && parseInt(date.year) >= startYear;
          var monthIsValid = !!date.month;
          var dayIsValid = !!date.day;

          console.log(yearIsValid, monthIsValid, dayIsValid);

          // SET INPUT VALIDITY
          ngModel.$setValidity('required', yearIsValid || monthIsValid || dayIsValid ? true : false);
          ngModel.$setValidity('yearRequired', yearIsValid ? true : false);
          ngModel.$setValidity('monthRequired', monthIsValid ? true : false);
          ngModel.$setValidity('dayRequired', dayIsValid ? true : false);

          // UPDATE NG MODEL
          if (yearIsValid && monthIsValid && dayIsValid) {
            ngModel.$setViewValue(new Date(date.year, date.month - 1, date.day));
          }
        }

        // IF NOT REQUIRED (still need the 3 values filled to update the model)
        else if (date.year && date.month && date.day) {
          ngModel.$setViewValue(new Date(date.year, date.month - 1, date.day));
        }

        // IF NOT REQUIRED (still need the 3 values filled to update the model)
        else if (date.year && date.month && date.day) {
          ngModel.$setViewValue(new Date(date.year, date.month - 1, date.day));
        }

      }, true);
    }
  }
});

app.controller('TasksCtrl', function ($scope, $rootScope, ngDialog, $http, $location, $window, $sce) {

  $scope.init = function(){
    var tasksPartners = ['127', 'nyc', 'bbbstx', 'mentor2','bbbs-cnm','bbbsu', 'bbbswillgrundy', 'bbbsmilwaukee', 'bbbscharlotte', 'bbbspgh', 'bbbsc', 'bbbscil', 'chicago', 'platformtraining'];
    var currDomain = $location.host();
    var ch = currDomain.split(".")[0];

    //if (tasksPartners.indexOf(ch) != -1) {
        $scope.getAllTasks();
    //}
  }
  $scope.getAnnouncementInfo = function() {
    return $http.get('/tasks/announcements/' , {}
    );
  };

  $scope.getRatingInfo = function() {
    return $http.get('/tasks/ratings/' , {}
    );
  };
  $scope.getSurveyInfo = function() {
    return $http.get('/new_surveys/survey_link/' , {}
    );
  };
  $scope.getEventsInfo = function() {
    return $http.post('/tasks/events/' , {}
    );
  };
  $scope.getPersonValidateInfo = function() {
    return $http.get('/tasks/info_update/' , {}
    );
  };
  $scope.getPersonValidateInfo().then(function(data){
    console.log("data.data.length" + data.data);
    $scope.personalInfo = data.data;
    $scope.phoneNum = $scope.personalInfo.cell_phone;
    $scope.emailAdd = $scope.personalInfo.email;
    $scope.infoId = $scope.personalInfo.info_update_id;
    if(isNaN(Date.parse($scope.personalInfo.date_of_birth))) {
      $scope.dateOfBirth = null;
    } else {
      $scope.dateOfBirth = new Date($scope.personalInfo.date_of_birth);  
    }
    
    console.log($scope.dateOfBirth );
    //$scope.dateOfBirth = new Date('1995-12-17T03:24:00');
    $scope.newDataAvail = false;
    for(var i in data.data) {
      if (data.data.hasOwnProperty(i)) {
        console.log(i);
        $scope.newDataAvail = true;
      }
      else{
        $scope.newDataAvail = false;
      }
    }
    console.log("newData" + $scope.newDataAvail);
  });

  $scope.getAllTasks = function() {
    var currDomain = $location.host();
    var ch = currDomain.split(".")[0];


    var surveyPartners = ['127', '192', 'nyc', 'bbbstx', 'mentor2','bbbs-cnm','bbbsu', 'bbbswillgrundy', 'bbbsmilwaukee', 'bbbscharlotte', 'bbbspgh', 'bbbsc', 'bbbscil', 'chicago', 'platformtraining'];
    var ratingPartners = ['127', '192', 'nyc', 'bbbstx', 'mentor2','bbbs-cnm','bbbsu', 'bbbswillgrundy', 'bbbsmilwaukee', 'bbbscharlotte', 'bbbspgh', 'bbbsc', 'bbbscil', 'chicago', 'platformtraining'];
    var eventPartners = ['127', '192', 'nyc', 'bbbstx', 'mentor2','bbbs-cnm','bbbsu', 'bbbswillgrundy', 'bbbsmilwaukee', 'bbbscharlotte', 'bbbspgh', 'bbbsc', 'bbbscil', 'chicago', 'platformtraining'];
    var updateInfoPartners = ['127','platformtraining'];
    
    var showTaskPopup = false;

    return   $scope.getPersonValidateInfo().then(function(data) {
      console.log("data.data.length" + data.data);


      $scope.personalInfo = data.data;
      $scope.phoneNum = $scope.personalInfo.cell_phone;
      //$scope.emailAdd = $scope.personalInfo.email;
      $scope.infoId = $scope.personalInfo.info_update_id;
      if(isNaN(Date.parse($scope.personalInfo.date_of_birth))) {
        $scope.dateOfBirth = null;
      } else {
        $scope.dateOfBirth = new Date($scope.personalInfo.date_of_birth);  
      }
      
      //console.log($scope.dateOfBirth);
      //$scope.dateOfBirth = new Date('1995-12-17T03:24:00');
      $scope.newDataAvail = false;
      for (var i in data.data) {
        if (data.data.hasOwnProperty(i)) {
          console.log(i);
          $scope.newDataAvail = true;
        }
        else {
          $scope.newDataAvail = false;
        }
      }
      $rootScope.showValidateInfo = $scope.newDataAvail == true;
      console.log("$rootScope.showValidateInfo" + $rootScope.showValidateInfo);
      console.log("newData" + $scope.newDataAvail);

      return $scope.getAnnouncementInfo().then(function (data) {
          console.log("ANNOUncement!!" + data.data);
          var newAnnouncement = false;
          for (var i in data.data) {
            if (data.data.hasOwnProperty(i)) {
              console.log(i);
              newAnnouncement = true;
            }
            else {
              newAnnouncement = false;
            }
          }
          if (newAnnouncement == true) {
            $rootScope.showAnnouncement = true; //(data.data.show && ratingPartners.indexOf(ch) != -1);
            $rootScope.announcement_description = data.data.announcement_description;
            $rootScope.announcement_content = data.data.announcement_html;
            var element = angular.element('<div>' + $rootScope.announcement_content + '</div>');
            element.find('iframe').wrap("<div class='announcement-embed'></div>");
            var notLoadedMessage = "<div class='announcement-embed-notloaded' ng-if='notLoaded' style='padding: 0px 10px 0px 10px;'><h2><i class='fa fa-frown-o'></i> We couldn't load this content.</h2>It's likely due to a security restriction on your computer for content from external sources such as Google, Vimeo, and YouTube.<p><p>However, you have several options:<ul><li>First, if you're on a work or school computer, you could ask the technology team there about the possibility of relaxing these restrictions.</li><li>Second, if you have a mobile device with a cellular connection, you could access the Canvas and its content from there.</li><li>Finally, if you have a home computer, you could access the Canvas and its content from there as well.</li></ul></p></p>Please feel free to contact your staff member with any questions.<p></div>";
            element.find('.announcement-embed').append(notLoadedMessage);
            $rootScope.announcement_html = $sce.trustAsHtml(element.html());
            $rootScope.announcement_id = data.data.id;
            console.log("$scope.showAnnouncements" + $rootScope.showAnnouncement);
          }
          return $scope.getRatingInfo();
        })
        .then(function (data) {
          $rootScope.showRating = (data.data.show);
          console.log("$scope.showRating" + $scope.showRating);
          return $scope.getSurveyInfo();
        })
        .then(function (data) {
          //$rootScope.showSurvey = true;
          if (data.data.success == true) {
            console.log("data.data.success " + data.data.success);
            $rootScope.showSurvey = true;
            $rootScope.surveyName = data.data.description;
            $rootScope.surveyLink = data.data.link;
          }

          if ($rootScope.showSurvey == true || $rootScope.showRating == true || $rootScope.showAnnouncement == true || $rootScope.showValidateInfo == true) {
            showTaskPopup = true; //$scope.openSurvey();
          }
          return $scope.getEventsInfo();
        }).then(function (data) {

          $scope.events = data.data;
          console.log("event length: " + $scope.events.length);
          if ($scope.events.length > 0) {
            $rootScope.showEvents = true;
          }
          if ($scope.events.length > 0 && (!$rootScope.showSurvey && !$rootScope.showRating && !$rootScope.showAnnouncement)) {
            showTaskPopup = true; //$scope.openSurvey();
            $rootScope.showEvents = true;
            if ($rootScope.showSurvey == true || $rootScope.showRating == true || $rootScope.showEvents == true || $rootScope.showAnnouncement == true || $rootScope.showValidateInfo == true) {
              showTaskPopup = true; //$scope.openSurvey();
            }
          } else {
            if ($rootScope.showSurvey == true || $rootScope.showRating == true || $rootScope.showEvents == true || $rootScope.showAnnouncement == true || $rootScope.showValidateInfo == true) {
              showTaskPopup = true; //$scope.openSurvey();
            }
          }

          if (showTaskPopup === true) {
            $scope.openSurvey();
          }

          /*if (data.data.success == true){
           $rootScope.showSurvey = true;
           $rootScope.surveyLink = data.data.link;
           }*/
        }).catch(function (error) {
          console.log('Error occurred');
          if (showTaskPopup === true) {
            $scope.openSurvey();
          }
        });
    });
  }
  
  var dialog;
  var announcementNoloadSent = false;

  $scope.openSurvey = function () {
    
    /*if(typeof dialog != 'undefined'){
       return;
    }*/
    dialog = ngDialog.open({
      template: '/new_platform/static/tasks/nghtml/tasksmodal.html',
      controller: ['$scope', '$document', '$timeout', function ($scope, $document, $timeout) {
        $scope.taskCounter = 0;
        var rsvpResponse = [];
        $scope.closeSurvey = function(){
          $rootScope.showSurvey = false;
          console.log("$rootScope.showRating" + $rootScope.showSurvey);
          if($rootScope.showRating == false || !$rootScope.showRating) {
            ngDialog.close();
          }
        }
        $scope.goToSurvey = function(){
          $window.open($rootScope.surveyLink,'_blank');
        }
        $scope.closeRating = function(){
          $rootScope.showSurvey = false;
          console.log("$rootScope.showRating" + $rootScope.showRating);
          if($rootScope.showRating == false) {
            ngDialog.close();
          }
        }
        $http.get('/tasks/ratings/').success(function(data) {
          console.log(data);
          $scope.rating = data.rating;
          //$rootScope.showRating = data.show;
          $scope.ratingName = data.name;
        });
        $http.post('/tasks/events/',{}).success(function(data) {
          console.log(data);
          if(data.length > 0) {
            //$rootScope.showEvents = true;
            $scope.events = data;
            $rootScope.eventsLength = data.length;
            $scope.evtCounter = 0;
          }else{
           // $rootScope.showEvents = false;
          }
        });

        $scope.selectRating= function(rating){
          $scope.newRating = rating;

          $http.post('/tasks/ratings/', {
            rating: rating,
          }).success(function (data, status, headers, config) {
            console.log(data);
            $rootScope.showRating = false;
            if(($rootScope.showSurvey == false || !$rootScope.showSurvey) && ($rootScope.showRating != true && $rootScope.showEvents != true  && $rootScope.showAnnouncement != true && $rootScope.showValidateInfo != true)) {
              ngDialog.close();
            }
          }).error(function (data, status, headers, config) {
            console.log("error updating rating");

          });
        };
        $scope.closeThisTask = function(task){
          if(task == 0){
            $rootScope.showAnnouncement = false;
          }
          if(task == 1){
            $rootScope.showSurvey = false;
          }
          else if(task == 2){
            $rootScope.showRating = false
          }
          else if(task == 3){
            $rootScope.showEvents = false;
          }
          else if(task == 4){
            $rootScope.showValidateInfo = false;
          }
          if(($rootScope.showSurvey == false || !$rootScope.showSurvey) && ($rootScope.showRating != true && $rootScope.showEvents != true && $rootScope.showAnnouncement != true && $rootScope.showValidateInfo != true)){
            ngDialog.close();
          }
        };
        $scope.rsvp = function(rsvp, rsvp_id){

          if(rsvpResponse.indexOf(rsvp_id) < 0 ){
            rsvpResponse.push(rsvp_id);
          }
          //$rootScope.showEvents = false;
          $http.post('/tasks/rsvp/', {
            'rsvp_id': rsvp_id,
            'rsvp_selection': rsvp
          }).success(function (data, status, headers, config) {
            //$rootScope.showEvents = false;
            if($rootScope.eventsLength < 2){
              $rootScope.showEvents = false;
              if(($rootScope.showSurvey != true && $rootScope.showRating != true && $rootScope.showEvents != true && $rootScope.showAnnouncement != true && $rootScope.showValidateInfo != true)) {
                ngDialog.close();
              }
            }else{
              if(rsvpResponse.length === $rootScope.eventsLength ) {
                $rootScope.showEvents = false;
                if(($rootScope.showSurvey != true && $rootScope.showRating != true && $rootScope.showEvents != true && $rootScope.showAnnouncement != true && $rootScope.showValidateInfo != true)) {
                  ngDialog.close();
                }
              }
            }

          }).error(function (data, status, headers, config) {
            console.log("error updating rating");

          });
          //if($rootScope.showSurvey == false || !$rootScope.showSurvey && ($rootScope.showRating != true && $rootScope.showEvents != true) &&  $rootScope.eventsLength <= 1){
          //  ngDialog.close();
          //}
        };
        $scope.updatePersonalInfo = function(phoneNum, email, dateOfBirth, info_id){
          console.log("phoneNum" + phoneNum);
          var emailCorrect = false;
          var phoneCorrect = false;
          var dateCorrect = false;
          if(email == undefined){
            $scope.emailError = 'Ensure you enter a valid email.';
          }
          if(phoneNum == undefined){
            $scope.phoneNumError = 'Ensure your cell phone has 10 digits.';
          }
          if(email != undefined) {
            if (email.indexOf('.')<0 && email.indexOf('@')<0) {
              $scope.emailError =  "Ensure your email contains the @ symbol and at least one period.";
            }
            else if (email.indexOf('.')<0) {
              $scope.emailError = 'Ensure your email contains at least one period.';
            }
            else if (email.indexOf('@')<0) {
              $scope.emailError = 'Ensure your email contains the @ symbol.';
            }
            else if(email.indexOf('.')>=0 && email.indexOf('@')>=0){
              $scope.emailError =  "";
              emailCorrect = true;
            }
          }
          if(phoneNum != undefined) {
            if (phoneNum.startsWith('1')) {
              console.log(phoneNum + 'phone starts with 1');
              $scope.phoneNumError = 'Ensure your cell phone does not begin with 1.';
            }else if(phoneNum.length > 1 && phoneNum.length < 10){
              $scope.phoneNumError = 'Ensure your cell phone has 10 digits.';
            }
            else if (!phoneNum.startsWith('1')) {
              $scope.phoneNumError = '';
              phoneCorrect = true;
            }
          }
          if($rootScope.userrole == 'Mentee') {
            if (dateOfBirth != undefined) {
              var theNewDate = dateOfBirth.getMonth() + 1 + '/' + dateOfBirth.getDate() + '/' + dateOfBirth.getFullYear();
              console.log("thenewdate" + theNewDate);
              $scope.dateError = '';
              dateCorrect = true;
            } else {
              $scope.dateError = 'Ensure you enter a valid date of birth in MM/DD/YYYY format.';
            }
          }
          if(phoneCorrect == true && emailCorrect == true){
            console.log("All GOOD! POST");
           if($rootScope.userrole == 'Mentor'){
              $http.post('/tasks/info_update/', {
                'info_update_id': info_id,
                'cell_phone': phoneNum,
                'email': email,

              }).success(function (data, status, headers, config) {
                console.log(data);
                if(data.existing_email == true){
                  $rootScope.showValidateInfo = true;
                  $scope.emailError =  "This email is already taken. Please enter another email.";
                }
                else{
                  $rootScope.showValidateInfo = false;
                  if(($rootScope.showSurvey != true && $rootScope.showRating != true && $rootScope.showEvents != true && $rootScope.showAnnouncement != true && $rootScope.showValidateInfo != true)) {
                    ngDialog.close();
                  }
                }

              }).error(function (data, status, headers, config) {
                console.log("error updating rating");

              });
            }
            else if(dateCorrect == true){
              $http.post('/tasks/info_update/', {
                'info_update_id': info_id,
                'cell_phone': phoneNum,
                'email': email,
                'date_of_birth': theNewDate

              }).success(function (data, status, headers, config) {
                console.log(data);
                if(data.existing_email == true){
                  $rootScope.showValidateInfo = true;
                  $scope.emailError =  "This email is already taken. Please enter another email.";
                }
                else{
                  $rootScope.showValidateInfo = false;
                  if(($rootScope.showSurvey != true && $rootScope.showRating != true && $rootScope.showEvents != true && $rootScope.showAnnouncement != true && $rootScope.showValidateInfo != true)) {
                    ngDialog.close();
                  }
                }
              }).error(function (data, status, headers, config) {
                console.log("error updating rating");

              });
            }
          }


        };

        $scope.updateAnnouncement= function(announcement_id){
          $http.post('/tasks/announcements/', {
            announcement_id: announcement_id,
          }).success(function (data, status, headers, config) {
            console.log("announcement update success" + data);
          }).error(function (data, status, headers, config) {
            console.log("error updating announcement");
          });
        };

        $scope.postNoload = function (json){
          if(announcementNoloadSent === false) {
            announcementNoloadSent = true;
            $http({ method: 'POST', url: '/generic/noload/',  data: JSON.stringify(json)})
                .then(function(data, status, headers, config) {
                    console.log('postNoload success');
                }, function(error){
                    logger('postNoload Failed - Network Error',error);
                    return error;
                });
          }
        }

        
        //Noload message handling
        var noLoadType = 0;
        var retryCount = 0;

        function handleUrlAccessibleCheck(isAccesible, url) {
            console.log(isAccesible + ' : : ' + url);            
            if(isAccesible === false && retryCount < 2) {
                retryCount++;
                $timeout(function() {
                    urlAccessibleCheck(url, handleUrlAccessibleCheck);
                }, 500);
            } else {
                $scope.notLoaded = !isAccesible;
                if($scope.notLoaded === true){
                    $scope.postNoload({'content_url' : $scope.iframeUrl, 'content_type_id' : noLoadType, 'product_record_id' : $rootScope.announcement_id, 'product_type_id' : 2});
                }
            }
        }

        function handleFileExistsCheck(isAccesible) {
            if(!isAccesible) {
                console.log('fileExistsCheck failed.');
                var queryResult = $document[0].getElementById($rootScope.taskDialogId)
                var $element = angular.element(queryResult);
                var pageIframeElement = $element.find('iframe');
                var url = $scope.iframeUrl;
                pageIframeElement[0].src = url;
            }
        }
        
         if($rootScope.announcement_content) {
            var element = angular.element('<div>' + $rootScope.announcement_content + '</div>');
            var iframeElement = element.find('iframe');
            if (iframeElement.length>0) {   
                $scope.iframeUrl = iframeElement[0].src; 
            }
        }
        if($rootScope.announcement_content && $rootScope.announcement_content.indexOf('Google content')>0) {
            var element = angular.element('<div>' + $rootScope.announcement_content + '</div>');
            var iframeElement = element.find('iframe');
            if (iframeElement.length>0) {
                
                $scope.iframeUrl = iframeElement[0].src; 
                if ($scope.iframeUrl.indexOf('/presentation/')===-1) {
                    noLoadType = 1;
                    fileExistsCheck($scope.iframeUrl, handleFileExistsCheck);
                }

                $timeout(function() {
                    noLoadType = 1;
                    urlAccessibleCheck('https://docs.google.com/uc?authuser=0&id=0B3_AxqV1Xh-PTU1JdmdnLWtBQU0&export=download', handleUrlAccessibleCheck);
                }, 1000);


            }
        } else if($rootScope.announcement_content && $rootScope.announcement_content.indexOf('YouTube content')>0) {
            console.log('https://youtube.com');
            $timeout(function() {
                noLoadType = 3;
                urlAccessibleCheck('https://www.youtube.com/player_api', handleUrlAccessibleCheck);
            }, 1000);
        } else if($rootScope.announcement_content && $rootScope.announcement_content.indexOf('player.vimeo.com')>0) {
            console.log('https://vimeo.com');
            $timeout(function() {
                noLoadType = 2;
                urlAccessibleCheck('https://f.vimeocdn.com/js/froogaloop2.min.js', handleUrlAccessibleCheck);
            }, 1000);
        } else if($rootScope.announcement_content && $rootScope.announcement_content.indexOf('SoundCloud content')>0) {
            console.log('https://SoundCloud.com');
            $timeout(function() {
                noLoadType = 4;
                urlAccessibleCheck('https://connect.soundcloud.com/sdk/sdk-3.0.0.js', handleUrlAccessibleCheck);
            }, 1000);
        }

      }],
      className: 'ngdialog-theme-plain',
      showClose: false,
      keyboard  : false,
      closeByEscape : false,
      //closeByDocument : false
    });

    $rootScope.taskDialogId = dialog.id;
  };
});


app.filter('range', function() {
  return function(input, total) {
    total = parseInt(total);
    for (var i=0; i<=total; i++)
      input.push(i);
    return input;
  };
});

app.directive('bindHtmlCompile', ['$compile', function ($compile) {
        return {
            restrict: 'A',
            link: function (scope, element, attrs) {
                scope.$watch(function () {
                    return scope.$eval(attrs.bindHtmlCompile);
                }, function (value) {
                    // In case value is a TrustedValueHolderType, sometimes it
                    // needs to be explicitly called into a string in order to
                    // get the HTML string.
                    element.html(value && value.toString());
                    // If scope is provided use it, otherwise use parent scope
                    var compileScope = scope;
                    if (attrs.bindHtmlScope) {
                        compileScope = scope.$eval(attrs.bindHtmlScope);
                    }
                    $compile(element.contents())(compileScope);
                });
            }
        };
    }]);