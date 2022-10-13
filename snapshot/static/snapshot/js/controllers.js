var app = angular.module('classroom_mgmt');

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
  }

  $http({method: 'GET', url: '/generic/user_info/'}).then(function (data, status, headers, config) {
    //console.log('user' + data.data);
    $rootScope.firstname = data.data.self.f_name;
    $rootScope.lastname = data.data.self.l_name;
    $rootScope.useridnum = data.data.self.user_id;
    $rootScope.userrole = data.data.self.role;
    $rootScope.persona = data.data.self.persona_id;

    return data.data;
  }, function (error) {

    if(error.status == 403) {
        $window.location.href = '/';
    }
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
    'tennesseebig': '/dw_reports/ProgramEngagement-Tennessee/Summary/?:iid=9',
    'tucsonbigs': '/dw_reports/ProgramEngagement-Tucson/Summary/?:iid=10',
    'bbbsmb': '/dw_reports/ProgramEngagement-MassBay/Summary/?:iid=11',
    'bbbsmiami':'/dw_reports/ProgramEngagement-Miami/Summary/',
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

app.controller('ClassroomMgmtCtrl',[
  '$scope',
  '$http',
  '$location',
  '$q',
  '$rootScope',
  '$window',
  function($scope,$http,$location, $q, $rootScope, $window) {

    var currDomain = $location.host();
    var ch = currDomain.split(".")[0];
    $scope.subdomain = ch;

    var clsMgmt = this;

    $('body').css({'background-size': 'cover'});
    /**
     * init variables
     */

    $scope.selectedGrade = "";
    $scope.selectedUnit = "";
    $scope.selectedLesson = "";
    $scope.selectedPartner = "";
    $scope.showFailedMessage = false;
    $scope.lesson= new Date();
    console.log($scope.lesson);

    $scope.useFixedHeader = true;
    if(isMobile.phone) {
        $scope.useFixedHeader = false;
    }

    // init function
    clsMgmt.init = function() {
      $rootScope.loadingPage = true;
      clsMgmt.selectedPartnerSites = [];
      clsMgmt.partnerSitesLang = {
        selectAll: 'Choose all',
        selectNone: 'Choose none',
        reset: 'Reset choice',
        search: 'Search...',
        nothingSelected: 'Choose a class'
      };

      clsMgmt.loadPartnerSites()
      .then(function (res) {
        clsMgmt.partnerSites = res.data;
        console.log(clsMgmt.partnerSites.length);
        $rootScope.loadingPage = false;
      })
      .catch(function (error) {
        $rootScope.loadingPage = false;
        $rootScope.inaccessiblePage = true;
        console.log('Error occurred');

        if(error.status == 403) {
            $window.location.href = '/';
        }
      });

      /**
       * indicates number of backend api call which is in the progress now.
       * should be less than 4
       */
      clsMgmt.callsOnApi = 0;

    };

    /**
     * data loads:
     */
    clsMgmt.updatePage = function() {

      //clear past data

      var partnerIds = _.pluck(clsMgmt.selectedPartnerSites, 'id');

      if (partnerIds.length == 0) {
        return;
      }

      if (clsMgmt.callsOnApi > 0) {
        return;
      }

      clsMgmt.roster = null;
      clsMgmt.lessons = [{}, {}, {}];

      $rootScope.loadingPage = true;
      $rootScope.inaccessiblePage = false;
      $scope.showFailedMessage = false;
      //reset lesson info
      clsMgmt.loadLessonDetail(partnerIds, 'current', 0);
      clsMgmt.loadLessonDetail(partnerIds, 'current_minus_1', 1);
      clsMgmt.loadLessonDetail(partnerIds, 'current_minus_2', 2);
      clsMgmt.loadRoster(partnerIds);
    };

    // --- API Calls ---
    clsMgmt.loadPartnerSites = function () {
      return $http.get('/generic/partner_info/', {});
    };

    // load lesson detail
    clsMgmt.loadLessonDetail = function(partnerIds, period, index) {
     
      clsMgmt.callsOnApi++;
      console.log(clsMgmt.callsOnApi);

      $http.post( '/snapshot/lesson/', {
        partner_id: partnerIds[0],
        period: period
      })
      .then(function(res) {

        if(res.status == 403) {
            $window.location.href = '/';
        }

        clsMgmt.lessons[index].description = res.data.lesson_description;
        clsMgmt.lessons[index].lesson_start = res.data.lesson_start;
        clsMgmt.lessons[index].lesson_end = res.data.lesson_end;
        clsMgmt.lessons[index].curriculum_id = res.data.curriculum_id;

        clsMgmt.lessons[index].overall_pair_participation = '--';
        clsMgmt.lessons[index].overall_mentor_participation = '--';
        clsMgmt.lessons[index].overall_mentee_participation = '--';

        clsMgmt.lessons[index].canvas_pair_participation = '--';
        clsMgmt.lessons[index].canvas_mentee_participation = '--';
        clsMgmt.lessons[index].canvas_mentor_participation = '--';

        clsMgmt.lessons[index].conversations_pair_participation = '--';
        clsMgmt.lessons[index].conversations_mentee_participation = '--';
        clsMgmt.lessons[index].conversations_mentor_participation = '--';

        if (null !== res.data.curriculum_id && 'NA' !== res.data.curriculum_id) {
          // call to get statistics
          return $http.post ('/snapshot/lesson_engagement_statistics/', {
            partner_id: partnerIds[0],
            curriculum_id: clsMgmt.lessons[index].curriculum_id
          });
        }
        else {

          throw new Error('Curriculum id is null or NA');
        }

      })
      .then(function(res) {
        // get the statistics

        clsMgmt.lessons[index].overall_pair_participation = res.data.overall_pair_participation;
        clsMgmt.lessons[index].overall_mentor_participation = res.data.overall_mentor_participation;
        clsMgmt.lessons[index].overall_mentee_participation = res.data.overall_mentee_participation;

        clsMgmt.lessons[index].canvas_pair_participation = res.data.canvas_pair_participation;
        clsMgmt.lessons[index].canvas_mentor_participation = res.data.canvas_mentor_participation;
        clsMgmt.lessons[index].canvas_mentee_participation = res.data.canvas_mentee_participation;

        clsMgmt.lessons[index].conversations_pair_participation = res.data.conversations_pair_participation;
        clsMgmt.lessons[index].conversations_mentor_participation = res.data.conversations_mentor_participation;
        clsMgmt.lessons[index].conversations_mentee_participation = res.data.conversations_mentee_participation;

        return $http.post ('/snapshot/lesson_engagement/', {
          partner_id: partnerIds[0],
          curriculum_id: clsMgmt.lessons[index].curriculum_id
        });

      })
      .then(function(res) {
        
        clsMgmt.lessons[index].engagement = res.data;
        clsMgmt.callsOnApi--; // decrease the api call number
        toggleLoading();
      })
      .catch(function(error) {
        
        if(error.status == 403) {
            $window.location.href = '/';
        }
        if(error.message != "Curriculum id is null or NA") {
          $scope.showFailedMessage = true;
        }
        
        clsMgmt.callsOnApi--; // decrease the api call number
        console.warn(error);
        toggleLoading();
      });
    };

    function toggleLoading(argument) {
      if(clsMgmt.callsOnApi == 0){
        $rootScope.loadingPage = false;
        if($scope.showFailedMessage == true) {
          $rootScope.inaccessiblePage = true;
        }
      }
    }
    //load list of table
    clsMgmt.loadRoster = function (partnerIds) {
      // increase the api call number
      $rootScope.loadingPage = true;
      clsMgmt.callsOnApi++;
      console.log(clsMgmt.callsOnApi);

      $http.post( '/snapshot/class_roster/', {
        partner_id: partnerIds[0]
      })
      .then(function(res) {
        clsMgmt.roster= res.data;
        clsMgmt.callsOnApi--;
        toggleLoading();
      }).catch(function(error) {

        if(error.status == 403) {
          $window.location.href = '/';
        }
        clsMgmt.callsOnApi--;
        $scope.showFailedMessage = true;
        console.warn(error);
        toggleLoading();
      });
    };

    clsMgmt.refresh = function() {
      clsMgmt.updatePage();
    };


    //update Individual Selection
    clsMgmt.updateRosterSelection = function(ele) {

      if (ele.selected === true) {
        ele.selected = false;
      }
      else {
        ele.selected = true;
      }

      clsMgmt.updateGlobalSelection(ele.selected);
      clsMgmt.updateAnySelection();
    };

    //update table selections
    clsMgmt.updateSelections = function() {
      if (clsMgmt.globalSelection === true) {
        clsMgmt.globalSelection = false;
      }
      else {
        clsMgmt.globalSelection = true;
      }
      _.each(clsMgmt.roster, function(ele) {
        ele.selected = clsMgmt.globalSelection;
      });

      clsMgmt.updateAnySelection();

    };

    // global selection
    clsMgmt.updateGlobalSelection = function(selected) {

      var diff = _.find(clsMgmt.roster, function(ele){ return ele.selected !== selected; });

      if (diff) {
        clsMgmt.globalSelection = false;
      }
      else if (selected === true) {
        clsMgmt.globalSelection = true;
      }
      else {
        clsMgmt.globalSelection = false;
      }
    };

    //any selection
    clsMgmt.updateAnySelection = function() {

      var trueItem= _.find(clsMgmt.roster, function(ele){ return ele.selected === true; });

      if (trueItem) {
        clsMgmt.anySelection = true;
      }
      else {
        clsMgmt.anySelection = false;
      }
    };

    //show email client window
    clsMgmt.sendEmails = function(option) {
      //<a href="mailto:name1@rapidtables.com?cc=name2@rapidtables.com&amp;bcc=name3@rapidtables.com,name3@rapidtables.com,name3@rapidtables.com&amp;subject=The%20subject%20of%20the%20email&amp;body=The%20body%20of%20the%20email">Send mail with cc, bcc, subject and body</a>

      var selectedItems = _.where(clsMgmt.roster, {selected: true});
      var bcc = '';

      if (!selectedItems || 0 == selectedItems.length) {
        alert('Please select the row');
      }
      else {
        _.each(selectedItems, function(ele) {
          if ('both' === option) {
            bcc += ele.mentee_email + ';' + ele.mentor_email + ';';
          }
          else if ('mentees' === option) {
            bcc += ele.mentee_email + ';';
          }
          else if ('mentors' === option) {
            bcc += ele.mentor_email + ';';
          }
        });

        //show email client
        //window.open('mailto:?bcc='+bcc);
        window.location.href = 'mailto:?bcc='+bcc;
        console.log('mailto:?bcc='+bcc);
      }

    };

    //show email client window
    clsMgmt.sendTexts = function(option) {
      //<a href="mailto:name1@rapidtables.com?cc=name2@rapidtables.com&amp;bcc=name3@rapidtables.com,name3@rapidtables.com,name3@rapidtables.com&amp;subject=The%20subject%20of%20the%20email&amp;body=The%20body%20of%20the%20email">Send mail with cc, bcc, subject and body</a>

      // Below we create a multi-dimensional array to pass to Joey for text message reminders.
      var selectedItems = _.where(clsMgmt.roster, {selected: true});
      var user_lesson_tuples = new Array ();
      var i;
      i = 0;

      if (!selectedItems || 0 == selectedItems.length) {
        alert('Please select the row');
      }
      else {
        _.each(selectedItems, function(ele) {
          if ('both' === option) {
            user_lesson_tuples[i] = new Array();
            user_lesson_tuples[i][0] = ele.mentor_user_id;
            user_lesson_tuples[i][1] = ele.mentor_current_lesson_id;
            user_lesson_tuples[i][2] = ele.mentee_first_name;
            user_lesson_tuples[i][3] = ele.staff_email;
            
            i++;
            
            user_lesson_tuples[i] = new Array();
            user_lesson_tuples[i][0] = ele.mentee_user_id;
            user_lesson_tuples[i][1] = ele.mentee_current_lesson_id;
            user_lesson_tuples[i][2] = ele.mentor_first_name;
            user_lesson_tuples[i][3] = ele.staff_email;
            
            i++;
          }
          else if ('mentees' === option) {
            user_lesson_tuples[i] = new Array();
            user_lesson_tuples[i][0] = ele.mentee_user_id;
            user_lesson_tuples[i][1] = ele.mentee_current_lesson_id;
            user_lesson_tuples[i][2] = ele.mentor_first_name;
            user_lesson_tuples[i][3] = ele.staff_email;
            
            i++;
          }
          else if ('mentors' === option) {
            user_lesson_tuples[i] = new Array();
            user_lesson_tuples[i][0] = ele.mentor_user_id;
            user_lesson_tuples[i][1] = ele.mentor_current_lesson_id;
            user_lesson_tuples[i][2] = ele.mentee_first_name;
            user_lesson_tuples[i][3] = ele.staff_email;
            
            i++;
          }
        });
      	  $http.post( '/snapshot/texts/', {
              user_lesson_tuples: user_lesson_tuples
      	  }).then(function(data) {
            if(data.status == 403) {
                $window.location.href = '/';
            }

          }).catch(function(error){
            if(error.status == 403) {
                $window.location.href = '/';
            }
          });
      }
    };

    // call initialization function
    clsMgmt.init();
  }
]);

