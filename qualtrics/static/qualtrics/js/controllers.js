var app = angular.module('qualtrics');

app.controller('headerController', function ($scope, $http, $location, $window, $rootScope) {

  // hover state for hamburger menu svg bars...
  $scope.hamburgerHover = function(){
    var result2 = document.getElementsByClassName("material-design-hamburger__layer");
    var wrappedResult2 = angular.element(result2);
    wrappedResult2.css("background", "gray");
  };
  $scope.HamburgerUnhover = function() {
    var result2 = document.getElementsByClassName("material-design-hamburger__layer");
    var wrappedResult2 = angular.element(result2);
    wrappedResult2.css("background", "white");
  };
  $scope.logout = function () {
    var logoutUrl = "//" + $window.location.host + "/iuser/logout/";
    $window.location.href = logoutUrl;
  };
  var currDomain = $location.host();
  var ch = currDomain.split(".")[0];
  $scope.subdomain = ch;
  
  $http({method: 'GET', url: '/generic/user_info/'}).then(function (data, status, headers, config) {
    //console.log('user' + data.data);
    $rootScope.firstname = data.data.self.f_name;
    $rootScope.lastname = data.data.self.l_name;
    $rootScope.useridnum = data.data.self.user_id;
    $rootScope.userrole = data.data.self.role;
    $rootScope.persona = data.data.self.persona_id;

    return data.data;
  }, function (error) {
    console.log(error);
    return error;
  });
  // ----------------------------------------------------------------------------------
  $scope.isOnPartnerListTableau = function(){
    var currDomain = $location.host();
    var ch = currDomain.split(".")[0];
    $scope.subdomain = ch;
    //var ch = 'mentor2';
    console.log("ch: " + ch);

    // link will only show for following partners
    var partners = [
      'nyc',
      'bayarea',
      'platformtraining',
      'chicago',
      'mentor2',
      'bbbscil',
      'bbbs-cnm',
      'bbbscharlotte',
      'bbbsc',
      'bbbspgh',
      'bbbstx',
      'bbbsmilwaukee',
      'bbbsu',
      'bbbswillgrundy',
      'tennesseebig',
      'tucsonbigs',
      'bbbsmb',
      'bbbsmiami',
      '127'];

    var a = partners.indexOf(ch);
    //console.log(a);
    if(a !== -1){
      $scope.isOnPartnerListTableau = true;
    }
    else{
      $scope.isOnPartnerListTableau = false;
    }
  };

  $scope.isOnPartnerListTableau();
  var domainUrls = {
    'bayarea':'/dw_reports/S_T_E_V_E_BAY/ProgramManagerSummary/',
    'nyc': '/dw_reports/S_T_E_V_E_NYC/ProgramManagerSummary/',
    'platformtraining': '/dw_reports/S_T_E_V_E_NYC/ProgramManagerSummary/',
    'chicago': '/dw_reports/S_T_E_V_E__CHI/ProgramManagerSummary/',
    'mentor2': '/dw_reports/ProgramEngagement-BigBend/Summary/',
    'bbbscil': '/dw_reports/ProgramEngagement-CentralIllinois/Summary/',
    'bbbs-cnm': '/dw_reports/ProgramEngagement-CentralNewMexico/Summary/',
    'bbbscharlotte': '/dw_reports/ProgramEngagement-Charlotte/Summary/',
    'bbbsc': '/dw_reports/ProgramEngagement-Colorado/Summary/',
    'bbbspgh': '/dw_reports/ProgramEngagement-GreaterPittsburgh/Summary/',
    'bbbstx': '/dw_reports/ProgramEngagement-LoneStar/Summary/',
    'bbbsmilwaukee': '/dw_reports/ProgramEngagement-Milwaukee/Summary/',
    'bbbsu': '/dw_reports/ProgramEngagement-Utah/Summary/',
    'bbbswillgrundy': '/dw_reports/ProgramEngagement-WillandGrundy/Summary/',
    'tennesseebig': '/dw_reports/ProgramEngagement-Tennessee/Summary?:iid=9',
    'tucsonbigs': '/dw_reports/ProgramEngagement-Tucson/Summary?:iid=10',
    'bbbsmb': '/dw_reports/ProgramEngagement-MassBay/Summary?:iid=11',
    'bbbsmiami':'/dw_reports/ProgramEngagement-Miami/Summary',
    '127': '/dw_reports/ProgramEngagement-BigBend/Summary/'
  };


  $scope.getProgramParticipationUrlAll = function(url) {
    var domainUrlFull = $location.protocol() + "://" + $location.host() + url;
    return $http.get(domainUrlFull, {});
  };

  $scope.getProgramParticipation = function(subdomain){

    console.log(subdomain);
    console.log("subdomain add" + domainUrls[subdomain]);
    var domainUrl = domainUrls[subdomain];

    if(domainUrl) {
      $scope.getProgramParticipationUrlAll(domainUrl).then(function (data) {
        $scope.programUrl = data.data.standard_url;
      });
    }
  };

  $scope.getProgramParticipation($scope.subdomain);

// ----------------------------------------------------------------------------------
});


app.controller('TrackingCtrl',[
  '$scope',
  '$http',
  '$timeout',
  '$window',
  '$interval',
  'ngDialog',
  '$document',
  '$rootScope',
  function($scope,$http,$timeout, $window, $interval, ngDialog, $document, $rootScope){

    /**
     * init variables
     */



    /**
     * Init Function
     */
    $scope.init = function() {

      $scope.summaryVisible = true;
      $scope.selectedPartnerSites = [];
      $scope.selectedSurveys = [];

      $scope.surveyListLang = {
        selectAll: 'Select All',
        selectNone: 'Select None',
        reset: 'Reset',
        search: 'Search...',
        nothingSelected: 'Select survey'
      };

      $scope.partnerSitesLang = {
        selectAll: 'Select All',
        selectNone: 'Select None',
        reset: 'Reset',
        search: 'Search...',
        nothingSelected: 'Select Partner Site'
      };


      $scope.currentPage = 1;
      $scope.maxSize = 100;
      $scope.pageSize = 100 ;
      $scope.option = {
        filter: {
          match_status: [],
          application_status: [],
          user_status: [],
          survey_status: []

        },
        sort: {
          first_name: '',
          last_name: '',
          partner_id: ''
        }
      };

      $scope.appChoices = {
        'True': 'Complete',
        'False': 'Incomplete'
      };

      $scope.mentees = [];

      $scope.refreshObj = null;
      $scope.refreshInterval = 60 * 1000;
       $scope.useFixedHeader = true;
        if(isMobile.phone) {
            $scope.useFixedHeader = false;
        }

      /**
       * load partner sites: into dropdown list
       */
      $scope.loadMatchChoices()
        .then(function(res) {
          $scope.matchChoices = res.data;
          $scope.option.filter['match_status'].push('NA','RTBM','M', 'RS');

          return $scope.loadUserStatusChoices();
        })
        .then(function(res) {
          $scope.userStatusChoices = res.data;
          $scope.option.filter['user_status'].push('A','AI','SI');

          return $scope.loadSurveyStatusChoices();
        })
        .then(function(res) {
          $scope.surveyStatusChoices = res.data;
          return $scope.loadSurveys();

        })
        .then(function(res) {
          $scope.surveys = res.data;
          //_.each(res.data, function(ele) {
          //
          //  var uninvited = angular.copy(ele);
          //  ele.txt = 'Invite all checked users to ' + ele.description;
          //  ele.option = 'checked';
          //
          //  uninvited.txt = 'Invite all uninvited users in the selected partner sites to ' + uninvited.description;
          //  uninvited.option = 'uninvited';
          //
          //  //push
          //  $scope.surveys.push(ele);
          //  $scope.surveys.push(uninvited);
          //});

          //update page info
          //$scope.retrunedRows =


          return $scope.loadPartnerSites();
        })
        .then(function(res) {
          $scope.partnerSites = res.data;


        })
        .catch(function(error) {
          console.log('Error occurred');
        });



      /**
       * Chart Options and data
       */

      $scope.chartOptions = {
        chart: {
          type: 'pieChart',
          tooltipContent : function(key, y, e, graph) {
            //var y1 = y.toFixed(0);
            return '<p>' + key + ': ' + y + '%' + '</p>'
          },
          height: 200,
          width: 200,
          x: function(d){return d.key;},
          y: function(d){return d.y},
          showLabels: false,
          showLegend: false,
          transitionDuration: 500,
          labelThreshold: 0.01,
          legend: {
            margin: {
              top: 5,
              right: 35,
              bottom: 5,
              left: 0
            }
          },
          color: ['#e7effe', '#bed6fd','#6fa2fb','#3a7cfb', '#F5A623'],
        }

      };

    };


    $scope.delayedLoadMentees = function() {
      $timeout(function() {$scope.loadMentees($scope.pageSize,1)}, 1000);
    };


    $scope.sortBy = function(field) {

       //$scope.sortDir= ($scope.sortField === field) ? !$scope.sortDir : 'asc';

      if (($scope.sortField === field)) {
        if ($scope.sortDir === 'asc') {
          $scope.sortDir = 'desc';
        }
        else {
          $scope.sortDir = 'asc';
        }
      }
      else {
        $scope.sortDir = 'asc';
      }
      $scope.sortField = field;

      for (var prop in $scope.option.sort) {
        if (prop !== field) {
          $scope.option.sort[prop] = '';
        }
        else {
          $scope.option.sort[prop] = $scope.sortDir;
        }
      }

      $scope.loadMentees($scope.pageSize,1);

    };

    $scope.setPage = function (pageNo) {
      $scope.currentPage = pageNo;
    };

    $scope.pageChanged = function() {
      $scope.loadMentees($scope.pageSize, $scope.currentPage);
      //console.log('Page changed to: ' + $scope.currentPage);
    };

    /**
     * hide status panel
     */
    $scope.toggleStatusPanel = function() {
      $scope.summaryVisible = !$scope.summaryVisible;
    };

    /**
     * load partner sites and assign them on dropdown list
     */
    $scope.loadPartnerSites = function() {

      //http://127.0.0.1:8000/generic/partner_info/
      return $http.get('/generic/partner_info/' , {});
    };

    $scope.loadSurveys = function() {

      //http://127.0.0.1:8000/generic/partner_info/
      return $http.get('/generic/survey_info/' , {});
    };

    /**
     * load Attendance Choices
     */
    $scope.loadAttendanceChoices = function() {
      // http://127.0.0.1:8000/generic/attendance_choices/
      return $http.get('/generic/attendance_choices/' , {});
    };

     /**
     * load Match Choices
     */
    $scope.loadMatchChoices = function() {
      return $http.get('/generic/match_choices/' , {});
    };

    /**
     *
     * load Survey Status Choices
     */
    $scope.loadSurveyStatusChoices = function() {
      return $http.get('/generic/survey_status_choices/' , {});
    };

    /**
     * load user status choices
     */
    $scope.loadUserStatusChoices = function() {
      return $http.get('/generic/user_status_choices/' , {});
    };





    /**
     * data loads:
     */
    $scope.loadMentees = function(pageSize, pageIndex) {

      var surveyIds = _.pluck($scope.selectedSurveys, 'id');
      if (surveyIds.length == 0) {
        return;
      }

      var partnerIds = _.pluck($scope.selectedPartnerSites, 'id');

      if (partnerIds.length == 0) {
        return;
      }

      if ($scope.refreshObj ==null) {
        $scope.refreshObj = $interval($scope.refreshMentees,  $scope.refreshInterval);
      }

      $http.post( '/new_surveys/user_data/size/'+pageSize+'/page/' + pageIndex + '/', {
        survey_id: surveyIds[0],
        partner_ids: partnerIds,
        filter_fields: $scope.option.filter,
        sort_fields:  $scope.option.sort,
        search_string: $scope.searchString
      })
        .success(function(data, status, headers, config) {
          $scope.updateQualtricsData(data);

        })
        .error(function(data, status, headers, config) {
          console.warn(data);
        });

    };

    $scope.updateQualtricsData = function(data) {
      $scope.mentees = data;

      //console.log($scope.mentees.total);
      var totalrecords = $scope.mentees.survey_totals.total_invited + $scope.mentees.survey_totals.total_completed + $scope.mentees.survey_totals.total_not_invited + $scope.mentees.survey_totals.total_incomplete;
      $scope.s_total_invited = $scope.mentees.survey_totals.total_invited;
      $scope.s_total_completed = $scope.mentees.survey_totals.total_completed ;
      $scope.s_total_not_invited = $scope.mentees.survey_totals.total_not_invited ;
      $scope.s_total_incomplete = $scope.mentees.survey_totals.total_incomplete;
      $scope.s_total_not_started = $scope.mentees.survey_totals.total_invited;

      var intvalue1 = $scope.s_total_completed / totalrecords * 100;
      var intvalue2 = $scope.s_total_not_invited / totalrecords * 100;
      var intvalue3 = $scope.s_total_incomplete / totalrecords * 100;
      var intvalue4 = $scope.s_total_not_started / totalrecords * 100;

      $scope.chartData = [
        {
          key: "Not Invited",
          y: intvalue2,
        },
        {
          key: "Not Started",
          y: intvalue4
        },
        {
          key: "Incomplete",
          y: intvalue3
        },
        {
          key: "Complete",
          y: intvalue1
        }

      ];
    }

    // fired in every minutes
    $scope.refreshMentees = function() {

      var surveyIds = _.pluck($scope.selectedSurveys, 'id');
      if (surveyIds.length == 0) {
        return;
      }

      var userIds = _.pluck($scope.mentees.data, 'user_id');
      if (userIds.length == 0) {
        return;
      }

      $http.post( '/new_surveys/survey_status/', {
        survey_id: surveyIds[0],
        user_ids: userIds
      })
        .success(function(data, status, headers, config) {


          // update survey_status column of $scope.mentees
          _.each($scope.mentees.data, function(mentee) {

            var exist = _.find(data.completed, mentee.user_id);
            if (typeof exist != 'undefined') {
              mentee.survey_status = 4; // static value
            }

            exist = _.find(data.invited, mentee.user_id);
            if (typeof exist != 'undefined') {
              mentee.survey_status = 1; // static value
            }

          });

        })
        .error(function(data, status, headers, config) {
          console.warn(data);
        });
    };

    /**
     * @param partnerId
     */
    $scope.getPartnerById = function(partnerId) {
      return _.findWhere($scope.partnerSites, {id: partnerId});
    };


    $scope.status = {
      isopen: false
    };

    $scope.toggled = function(open) {
      //console.log('Dropdown is now: ', open);
    };

    $scope.toggleDropdown = function($event) {
      $event.preventDefault();
      $event.stopPropagation();
      $scope.status.isopen = !$scope.status.isopen;
    };

    // Set a filter and reload the site
    $scope.setFilter= function(field,value, forceValue){

      var exist = _.find($scope.option.filter[field], function(item) {
        return item === value;
      });

      if (value === "True") {
        value = true;
      }
      if (value === "False") {
        value = false;
      }

      // Check forceValue first
      if (forceValue == true) {
        //remove and add it again
        $scope.option.filter[field] = _.without($scope.option.filter[field],value);
        $scope.option.filter[field].push(value);
      }
      else if (forceValue == false) {
        $scope.option.filter[field] = _.without($scope.option.filter[field],value);
      }
      else {

        if (exist) {
        //remove
          $scope.option.filter[field] = _.without($scope.option.filter[field],value);
        }
        else {
          //push
          $scope.option.filter[field].push(value);
        }

      }


      $scope.loadMentees($scope.pageSize,1);
    };


    // search the value in filter of field
    $scope.isInFilter = function(field, value) {

      var exist = _.find($scope.option.filter[field], function(item) {
        return item === value;
      });

      if (!exist) {
        return false;
      }
      return true;

    };

    // display formated selected values
    $scope.displayFilterValues = function(allValues, selectedValues) {

      if (!allValues || !selectedValues) {
        return 'None';
      }

      var allValuesLength = Object.keys(allValues).length;

      if (allValuesLength === selectedValues.length) {
        return 'All';
      }
      else if (selectedValues.length === 0) {
        return 'None';
      }

      if (selectedValues.length === 1) {
        return allValues[selectedValues[0]];
      }

      return allValues[selectedValues[0]] + ' & ' + (selectedValues.length -1) + 'more';

    };

    //update table selections
    $scope.updateSelections = function() {
      if ($scope.globalSelection === true) {
        $scope.globalSelection = false;
      }
      else {
        $scope.globalSelection = true;
      }
      _.each($scope.mentees.data, function(ele) {
        ele.selected = $scope.globalSelection;
      });
    };

    //adjust All Section Variable
    $scope.updateGlobalSelection = function(selected) {


      var diff = _.find($scope.mentees.data, function(ele){ return ele.selected !== selected; });

      if (diff) {
        $scope.globalSelection = false;
      }
      else if (selected === true) {
        $scope.globalSelection = true;
      }
      else {
        $scope.globalSelection = false;
      }
    };

    //update Individual Selection
    $scope.updateMenteeSelection = function(mentee) {

      if (mentee.selected === true) {
        mentee.selected = false;
      }
      else {
        mentee.selected = true;
      }

      $scope.updateGlobalSelection(mentee.selected);

    };

    //export function
    $scope.exportToCsv = function() {

      var partnerIds = _.pluck($scope.selectedPartnerSites, 'id');
      var surveyIds = _.pluck($scope.selectedSurveys, 'id');
      //console.log(surveyIds);

      $http.post( '/new_surveys/csv_user_data/', {
        partner_ids: partnerIds,
        survey_id: surveyIds[0],
        filter_fields: $scope.option.filter,
        sort_fields: $scope.option.sort,
        csv_download:true
      })
        .success(function(data, status, headers, config) {
          d = new Date();
          thedate = d.getFullYear()+'_'+(d.getMonth()+1)+'_'+d.getDate()+'_'+(d.getHours()+1)+'_'+d.getMinutes()+'_'+d.getSeconds();

          //var anchor = angular.element('<a/>');
          //anchor.attr({
          //  href: 'data:text/csv;charset=utf-8,' + encodeURI(data),
          //  target: '_blank',
          //  download: 'survey_status_' + thedate +'.csv'
          //})[0].click();


          var downloadContainer = angular.element('<div data-tap-disabled="true"><a></a></div>');
          var downloadLink = angular.element(downloadContainer.children()[0]);
          downloadLink.attr('href', 'data:text/csv;charset=utf-8,' + encodeURI(data));
          downloadLink.attr('download', 'survey_status_' + thedate +'.csv');
          downloadLink.attr('target', '_blank');

          $document.find('body').append(downloadContainer);
          $timeout(function () {
            downloadLink[0].click();
            downloadLink.remove();
          }, null);



        })
        .error(function(data, status, headers, config) {

        });
    };


    //invitation: pageSize and pageIndex will be ignored
    $scope.invite = function(pageSize, pageIndex) {

      var partnerIds = _.pluck($scope.selectedPartnerSites, 'id');
      var surveyIds = _.pluck($scope.selectedSurveys, 'id');
      if (surveyIds.length == 0) {
        return;
      }

      var selectedUserIds = [];

      _.each($scope.mentees.data, function(ele) {
        if (ele.selected === true) {
          //console.log("selcted: " + ele.user_id);
          //console.log("selcted arry: " + selectedUserIds);
          selectedUserIds.push(ele.user_id);
        }
      });

      /**
       * {'invite': {'survey_id':selected survey id, 'user_ids':[] or [11,24,33, etc] if they selected checked user option},'partner_ids':[3,4,5,6]}
       */
      $http.post( '/new_surveys/user_data/size/'+pageSize+'/page/' + pageIndex + '/', {
        survey_id: surveyIds[0],
        partner_ids: partnerIds,
        filter_fields: $scope.option.filter,
        sort_fields: $scope.option.sort,
        invite: {
          user_ids: selectedUserIds
        }
      })
        .success(function(data, status, headers, config) {
//          console.log(data);
          $scope.openSurvey(false);
          $rootScope.number_invited = selectedUserIds.length;
//          console.log("invited: " + selectedUserIds.length);
          $scope.updateQualtricsData(data);
         // alert('inivitation sent');
        })
        .error(function(data, status, headers, config) {
            $scope.openSurvey(true);
          //alert('inivitation failed');
        });
    };

    //invitation: pageSize and pageIndex will be ignored
    $scope.uninvite = function(pageSize, pageIndex) {

      var partnerIds = _.pluck($scope.selectedPartnerSites, 'id');
      var surveyIds = _.pluck($scope.selectedSurveys, 'id');
      if (surveyIds.length == 0) {
        return;
      }

      var selectedUserIds = [];

      _.each($scope.mentees.data, function(ele) {
        if (ele.selected === true) {
          selectedUserIds.push(ele.user_id);
        }
      });

      /**
       * {'invite': {'survey_id':selected survey id, 'user_ids':[] or [11,24,33, etc] if they selected checked user option},'partner_ids':[3,4,5,6]}
       */
      $http.post( '/new_surveys/user_data/size/'+pageSize+'/page/' + pageIndex + '/', {
        survey_id: surveyIds[0],
        partner_ids: partnerIds,
        uninvite: {
          user_ids: selectedUserIds
        }
      })
        .success(function(data, status, headers, config) {
//          console.log(data);
          $scope.openSurvey(false);
          //$rootScope.number_uninvited = selectedUserIds.length;
//          console.log("invited: " + selectedUserIds.length);
          $scope.updateQualtricsData(data);
         // alert('inivitation sent');
        })
        .error(function(data, status, headers, config) {
            $scope.openSurvey(true);
          //alert('inivitation failed');
        });
    };

    $scope.openSurvey = function (fail) {
      ngDialog.open({
        template: '/new_platform/static/qualtrics/nghtml/alert.html',
        closeByEscape: true,
        showClose: true,
        controller: ['$scope', function ($scope) {
          $scope.fail = fail;

          $scope.closeSurvey = function(){
            ngDialog.close();
          }
        }],
        className: 'ngdialog-theme-plain'
      });
    };

    // ---- send email to selected ids ----
    $scope.sendEmail = function(pageSize, pageIndex) {
      var selectedUserIds = [];
      var emailRecipients = [];

      _.each($scope.mentees.data, function(ele) {
        if (ele.selected === true) {
          selectedUserIds.push(ele.user_id);
        }
      });
      // send all user_ids to backend to get email addresses.
      $http.post( '/new_surveys/user_data/size/'+pageSize+'/page/'+pageIndex+'/', {
        external_email: {
          user_ids: selectedUserIds
        }
      })
        .success(function(data, status, headers, config) {
          _.each(data, function(ele) {
              emailRecipients.push(ele);
          });
          $scope.recipients = emailRecipients.join(";").toString();
          $window.location = "mailto:?bcc=" + $scope.recipients;
        })
        .error(function(data, status, headers, config) {
          console.log('email failed');
        });
    };

    //set all selected filter
    $scope.setFilterAll = function(field, fieldCollection) {

      var value = $scope.getFilterAll(field, fieldCollection);

      if (value === true) {
        value = false;
      }
      else {
        value = true;
      }

      for (key in fieldCollection) {
        if ('survey_status' === field) {
          $scope.setFilter(field,1 * key, value);
        }
        else {
          $scope.setFilter(field,key, value);
        }

      }


    };

    /**
     * return true/false in the dropdown selection
     */
    $scope.getFilterAll = function(field, fieldCollection) {

      if ($scope.option.filter[field].length === _.allKeys(fieldCollection).length) {
        return true;
      }
      return false;

    };
  }
]);
