var forms = angular.module('imForm', ['formsServices', 'ui.bootstrap', 'ngCookies', 'duScroll', 'ngHamburger','loggerServices']);

forms.config(function($interpolateProvider, $resourceProvider) {

    $resourceProvider.defaults.stripTrailingSlashes = false;
    $interpolateProvider.startSymbol('[[');
    $interpolateProvider.endSymbol(']]');
});

// Whitelist cdn 
forms.config(['$sceDelegateProvider', function($sceDelegateProvider){
    $sceDelegateProvider.resourceUrlWhitelist([
        // Allow same origin resource loads.
        'self',
        // Allow loading from outer templates domain.
        'https://cdn.imentor.org/**'
    ]); 
}]);

forms.run(function($rootScope) {
    $rootScope.globalUser = ''; //global variable
});

forms.controller('componentsCtrl', [
    '$scope',
    '$q',
    '$http',
    '$location',
    '$window',
    '$document',
    '$timeout',
    '$rootScope',
    '$document',
    'Form',
    'School',
    'Career',
    'CareerOnly',
    'Country',
    'State',
    'Racial',
    'Academic',
    'Program',
    'appFunc',
    'Lookup',
    'jsonLogger',
    function($scope, $q, $http, $location, $window, $document, $timeout, $rootScope, $document,
        Form, School, Career, CareerOnly, Country, State, Racial, Academic, Program, appFunc, Lookup, jsonLogger) {

        /* debug_log */
        var logger = new jsonLogger();

        /**
         * Init Function
         */


        $scope.init = function(user_id) {
            $scope.buttonText = "Submit";
            $scope.nextButtonText = "Next";
            $scope.busySubmit = false;
            console.log("the var: " + user_id);
            $rootScope.globalUser = user_id;
            $scope.fieldErrMsg = 'Required';
            $rootScope.busy = true;
            // will have to get this from backend, to use as added param for
            // admins editing user forms.
            //$scope.user_id = '';
            //console.log('userid: ' + $scope.as_user_id);
            /**
             * Return collection of countries in array of json object format
             */
            console.log("user_id: " + $scope.user_id);


            /* debug_log */
            var loggerData = logger.getLoggerData();
            loggerData.form_user_id = $scope.user_id || user_id || '';
            logger.setLoggerData(loggerData);

            //var elvisLives = Math.PI > 4 ? "Yep" : "Nope";
            

            function getUserInfo() {
                return $http({
                    method: 'GET',
                    url: '/generic/user_info/'
                }).then(function(data) {
                   
                    /* debug_log */
                    var loggerData = logger.getLoggerData();
                    if(typeof loggerData.login_user_id === "undefined" || loggerData.login_user_id.toString().trim() === "" || loggerData.login_user_id.length === 0){
                        loggerData.login_user_id = data.data.self.user_id;
                        logger.setLoggerData(loggerData);
                    }

                    return data.data;
                });
            }
            function getlookup() {
                /* debug_log */
                logger.log({'status' : 'Getting form for user'});

                var lookupCall = null;
                if (typeof user_id != "undefined") {
                    /* debug_log */
                    logger.setMetaData({'caller' : 'componentsCtrl.getlookup'});
                    logger.log({'status' : 'Calling','api' : "/forms_data/form_lookup/" + user_id + '/'});

                    lookupCall = $http.get("/forms_data/form_lookup/" + user_id + '/', {})
                } else {
                    /* debug_log */
                    logger.setMetaData({'caller' : 'componentsCtrl.getlookup'});
                    logger.log({'status' : 'Calling','api' : "/forms_data/form_lookup/"});

                    lookupCall = $http.get("/forms_data/form_lookup/", {})
                }

                return lookupCall.then(function(response) {
                    $scope.formId = response.data;

                    /* debug_log */
                    logger.setMetaData({'caller' : 'componentsCtrl.getlookup'});
                    logger.log({'status' : 'Success','response' : response});

                    /* debug_log */
                    var loggerData = logger.getLoggerData();
                    loggerData.form_id = $scope.formId;
                    logger.setLoggerData(loggerData);

                });
            }
            function  getCountry() {
              return Country.query({}).$promise.then(function(response) {
                   $scope.countries = response;
              });
            }

            function  getState() {
              return State.query({}).$promise.then(function(response) {
                   $scope.states = response;
              });
            }

            function  getSchool() {
              return School.query({userId: user_id}).$promise.then(function(response) {
                   $scope.schools = response;
              });
            }

            function  getCareer() {
              return Career.query({}).$promise.then(function(response) {
                   $scope.careers = response;
              });
            }

            function  getCareerOnly() {
              return CareerOnly.query({}).$promise.then(function(response) {
                   $scope.careers_only = response;
              });
            }

            function  getRacial() {
              return Racial.query({}).$promise.then(function(response) {
                   $scope.racials = response;
              });
            }

            function  getAcademic() {
              return Academic.query({}).$promise.then(function(response) {
                   $scope.academics = response;
              });
            }

            function  getProgram() {
              return Program.query({userId: user_id}).$promise.then(function(response) {
                   $scope.programs = response;
              });
            }

            getUserInfo().then(function(){
                return $q.all([getlookup(),getCountry(), getState(), getSchool(), getCareer(), getCareerOnly(),getRacial(),getAcademic(),getProgram()]);
            })
            .then(function(response) {

                /**
                 * get Form object which includes questions
                 */

                /* debug_log */
                logger.setMetaData({'caller' : 'componentsCtrl.init'});
                logger.log({'status' : 'Calling','api' : 'Form.list', 'api_data' : {'form_id' : $scope.formId, 'user_id' : user_id}});

                return Form.list($scope.formId, user_id);
            })
            /*.then(function(res) {
               return Form.list($scope.formId, user_id);
            })*/
            .then(function(res) {

                /* debug_log */
                logger.log({'status' : 'Success','response' : res});

                $scope.form = res.data.form;
                $scope.section = null;
                $rootScope.busy = false;
                //console.log(res);
                //console.log(res.data.form.description);
                //console.log(res.data.form.sections[0].ordinal);

                angular.forEach(res.data.form.sections, function(value, key) {
                    //console.log(key);
                    //console.log(value.ordinal);
                    if (value.ordinal == 1) {
                        $scope.section = value;

                        appFunc.setSection($scope.section); //register section to Service Variable
                        //console.log("true" + value.form_id);
                    }
                });

                if ($scope.section === null && res.data.form.sections.length > 0) {
                    $scope.section = res.data.form.sections[0];
                    appFunc.setSection($scope.section);
                }

                $scope.sectionId = $scope.section.id;
                $scope.description = res.data.form.description;
                $scope.sections = $scope.form.sections;
                //$scope.selectedSection = 3;
                $scope.isNext = true;
                $rootScope.formSaving = "Just saved.";
                $scope.reportClick = function() {
                    $rootScope.formSaving = 'Saving...';
                    $timeout(function() {
                        $rootScope.formSaving = "Just saved.";
                    }, 1000);
                }



                $scope.goToNextSectionCounter = 0;
                // Go to section!
                $scope.goToNextSection = function(sect, count) {
                    if(angular.isDefined(count)) {
                        $scope.goToNextSectionCounter = $scope.goToNextSectionCounter + 1;
                    } else {
                        $scope.goToNextSectionCounter = 0;
                    }


                    /* debug_log */
                    logger.createNewID();
                    var metadata = logger.getMetaData();
                    metadata.caller = 'AppSubmittedController.goToNextSection';
                    logger.setMetaData(metadata);
                    logger.log({'status' : 'Checking for unanswered questions', 'section' : $scope.section});

                    var sectionNum = $scope.form.sections.length;
                    var sectionIndex = $scope.form.sections.indexOf(sect) + 1;
                    //$scope.isNext = true;

                    //console.log("section index: " + sectionIndex);
                    //$scope.section = $scope.form.sections[]
                    //var sectionIndex = 1;
                    //console.log(sectionNum);

                    //console.log($scope.section);
                    //$scope.isNext = true;
                    var offset = 30;
                    var duration = 2000;
                    $scope.nextButtonText = "Next";
                    for (var i = 0; i < $scope.section.questions.length; i++) {
                        var question = $scope.section.questions[i];

                        var ele = null;
                        if (question.question_type == 17) {
                            ele = angular.element(document.querySelector('#q' + question.id + ' .occupation')); // question id pattern
                        } else {
                            ele = angular.element(document.querySelector('#q' + question.id)); // question id pattern
                        }
                        var eleScope;
                        if (ele || ele.length >= 0) {
                            var elementDir = angular.element($($(ele.find('div')[0]).find('div')[0]).find('div')[0]);                            
                            eleScope = angular.element(elementDir).scope();

                        }


                        /**
                         * if this question needs answer and api is still on backend update call, reject
                         */
                        if (true === question.is_visible && (true === question.required || true === question.onBackendCall || ( angular.isDefined(question.hasSaveError) && question.hasSaveError === true))) {

                            if (true === question.onBackendCall) {
                                //alert('One of question is updating now, Please try a few seconds later.');
                                //$rootScope.formSaving = 'Saving... Please wait.';
                                $timeout(function() {
                                    /* debug_log */
                                    logger.log({'status' : 'One of question is updating now. Will retry in one second', 'question' : question});

                                    if( $scope.goToNextSectionCounter < 3) {
                                        $scope.goToNextSection(sect, $scope.goToNextSectionCounter);
                                    }
                                }, 1000);
                                
                            } else if (angular.isDefined(question.hasSaveError) && question.hasSaveError === true) {

                                /* debug_log */
                                logger.log({'status' : 'One of question had error. Saving it. Cancelling move to next section.', 'question' : question});

                                eleScope.update();

                                $timeout(function() {
                                    /* debug_log */
                                    logger.log({'status' : 'One of question is updating now. Will retry in one second', 'question' : question});
                                    if( $scope.goToNextSectionCounter < 3) {
                                        $scope.goToNextSection(sect, $scope.goToNextSectionCounter);
                                    }
                                    
                                }, 1000);
                                
                            } else {
                                question.edited = true;
                                  
                                if (ele || ele.length >= 0) {
                                    question.showRequired = true;
                                    $document.scrollToElement(ele, offset, duration);
                                }
                                
                                /* debug_log */
                                logger.log({'status' : 'One of question is unanswered. Cancelling move to next section.', 'question' : question});
                            }

                            return false;
                        }
                    }


                    //console.log("no more errors");

                    if (sectionIndex < sectionNum) {
                        /* debug_log */
                        logger.log({'status' : 'Checking if previous section has completed all answers.'});

                        /**
                         * check if previous section has completed all answers
                         */
                        var toPrevSection = false;
                        if (sectionIndex > 1) {

                            var prevSection = $scope.form.sections[sectionIndex - 2];

                            for (var i = 0; i < prevSection.questions.length; i++) {

                                var question = prevSection.questions[i];

                                /**
                                 * if this question needs answer and api is still on backend update call, reject
                                 */
                                if (true === question.is_visible && (true === question.required || true === question.onBackendCall)) {
                                    /* debug_log */
                                    logger.log({'status' : 'One of question in section is unanswered. Moving to that section.', 'question' : question, 'prevSection' : prevSection});

                                    toPrevSection = true;
                                    break;

                                }
                            }

                        }

                        console.log("isNext: " + $scope.isNext);
                        //$scope.isNext = true;
                        var currTab = sectionIndex;

                        var nextTab = sectionIndex + 1;

                        if (toPrevSection === true) {
                            nextTab = sectionIndex - 1;
                        } else {
                            /* debug_log */
                            logger.log({'status' : 'No question in section is unanswered. Moving to that section.',  'section' : $scope.form.sections[nextTab-1]});
                        }


                        angular.element('#' + nextTab).removeClass('disabled').addClass('active');
                        angular.element('#' + currTab).removeClass('active').addClass('past');
                        $scope.section = $scope.form.sections[nextTab-1];
                        appFunc.setSection($scope.section); //register section to Service Variable

                        //update the header tab variable
                        var headerCtrlScope = angular.element(document.querySelector('#headerCtrl')).scope();
                        headerCtrlScope.theTab = nextTab;

                        // the element you wish to scroll to.
                        var header = angular.element(document.querySelector('#header')); // question id pattern

                        $document.scrollToElement(header);

                        // Set the html focus
                        var mainFrm = angular.element('#default');
                        mainFrm.focus();

                        //$timeout(function () {
                        //  //var mainFrm= angular.element('#q' + $scope.section.questions[0].id);
                        //  var mainFrm= angular.element('#default');
                        //  mainFrm.focus();
                        //},1000);


                    }
                    if (sectionNum - 1 <= sectionIndex) {
                        $scope.isNext = false;
                    }
                    return $scope.isNext;

                };

            })
            .catch(function(error) {
                console.log('Error occured: ' + error);

                /* debug_log */
                logger.log({'status' : 'Error','response' : error});
            });
        };

        $scope.logout = function() {

            /* debug_log */
            logger.createNewID();
            var metadata = logger.getMetaData();
            metadata.caller = 'AppSubmittedController.logout';
            logger.setMetaData(metadata);

            var url = $location.host();
            var landingUrl = "//" + url + "/iuser/logout/";
            
            /* debug_log */
            logger.log({'url' : landingUrl});

            setTimeout(function() {
               $window.location.href = landingUrl;
            }, 500);
        }
        
        $scope.exportApplication = function(user_id) {
            /* debug_log */
            logger.createNewID();
            var metadata = logger.getMetaData();
            metadata.caller = 'AppSubmittedController.exportApplication';
            logger.setMetaData(metadata);
            logger.log({'status' : 'Calling','api' : '/forms_data/export/' + user_id + '/'});

            $http({method: 'GET', url: '/forms_data/export/' + user_id + '/'})
            .success(function(data, status, headers, config) {
                //var anchor = angular.element('<a/>');
                //anchor.attr({href: 'data:text/csv;charset=utf-8,' + encodeURI(data), target: '_blank', download: 'application_export.csv'})[0].click();

                /* debug_log */
                logger.log({'status' : 'Success','response' : data});

               var downloadContainer = angular.element('<div data-tap-disabled="true"><a></a></div>');
               var downloadLink = angular.element(downloadContainer.children()[0]);
               downloadLink.attr('href', 'data:text/csv;charset=utf-8,' + encodeURI(data));
               downloadLink.attr('download', 'application_export.csv');
               downloadLink.attr('target', '_blank');

               $document.find('body').append(downloadContainer);
               $timeout(function () {
                 downloadLink[0].click();
                 downloadLink.remove();
               }, null);
            })
            .error(function(data, status, headers, config) {
                /* debug_log */
                logger.log({'status' : 'Error','response' : data});

            });
        };

        $scope.getQuestionView = function(question) {
            var type = question.question_type;

            var template = '';




            switch (type) {
                case 1:
                    template = '<div class="freeFormTextArea" id="freeTextA_[[::question.ordinal]]_[[::question.sub_ordinal]]" ng-if="question.question_type == 1" question="question"  field-err-msg="fieldErrMsg"> </div>';
                    break;
                case 2:

                    template = '<div class="freeFormTextBox" id="freeTextB_[[::question.ordinal]]_[[::question.sub_ordinal]]" ng-if="question.question_type == 2" question="question" field-err-msg="fieldErrMsg"> </div>';

                    break;
                case 3:
                    template = '<div class="phone-box" id="phone_[[::question.ordinal]]_[[::question.sub_ordinal]]" ng-if="question.question_type == 3" question="question"  field-err-msg="fieldErrMsg"> </div>';

                    break;
                case 4:
                    template = '<div class="address" id="address_[[::question.ordinal]]_[[::question.sub_ordinal]]" ng-if="question.question_type == 4" question="question" states="states" field-err-msg="fieldErrMsg"> </div>';

                    break;
                case 5:
                    template = '<div class="select-toggle" id="toggle_[[::question.ordinal]]_[[::question.sub_ordinal]]" ng-if="question.question_type == 5" question="question" field-err-msg="fieldErrMsg"></div>';

                    break;
                case 6:
                    template = '<div class="single-select-radio" id="radio_[[::question.ordinal]]_[[::question.sub_ordinal]]" ng-if="question.question_type == 6" question="question" field-err-msg="fieldErrMsg"></div>';

                    break;
                case 7:
                    template = '<div class="multi-select" id="multi_[[::question.ordinal]]_[[::question.sub_ordinal]]" ng-if="question.question_type == 7" question="question" field-err-msg="fieldErrMsg"></div>';

                    break;
                case 8:
                    template = '<div class="dropdown" id="dropdown_[[::question.ordinal]]_[[::question.sub_ordinal]]" ng-if="question.question_type == 8" question="question" field-err-msg="fieldErrMsg"></div>';

                    break;
                case 9:
                    template = '<div class="dropdown-country" id="country_[[::question.ordinal]]_[[::question.sub_ordinal]]" ng-if="question.question_type == 9" question="question" countries="countries" field-err-msg="fieldErrMsg"></div>';

                    break;
                case 10:
                    template = '<div class="dropdown-state" id="state_[[::question.ordinal]]_[[::question.sub_ordinal]]" ng-if="question.question_type == 10" question="question" states="states" field-err-msg="fieldErrMsg"></div>';

                    break;
                case 11:
                    template = '<div class="dropdown-employer" id="employer_[[::question.ordinal]]_[[::question.sub_ordinal]]" ng-if="question.question_type == 11" question="question" field-err-msg="fieldErrMsg"></div>';

                    break;
                case 12:
                    template = '<div class="dropdown-college" id="college_[[::question.ordinal]]_[[::question.sub_ordinal]]" ng-if="question.question_type == 12" question="question" field-err-msg="fieldErrMsg"></div>';

                    break;
                case 13:
                    template = '<div class="dropdown-school" id="school_[[::question.ordinal]]_[[::question.sub_ordinal]]" ng-if="question.question_type == 13" question="question" schools="schools" field-err-msg="fieldErrMsg"></div>';

                    break;
                case 14:
                    template = '<div class="datetime" id="datetime_[[::question.ordinal]]_[[::question.sub_ordinal]]" ng-if="question.question_type == 14 " question="question" field-err-msg="fieldErrMsg"></div>';

                    break;
                case 15:
                    template = '<div class="heading" id="heading_[[::question.ordinal]]_[[::question.sub_ordinal]]" ng-if="question.question_type == 15 " question="question" field-err-msg="fieldErrMsg"></div>';

                    break;
                case 16:
                    template = '<div class="instruction" id="instruction_[[::question.ordinal]]_[[::question.sub_ordinal]]" ng-if="question.question_type == 16 " question="question" field-err-msg="fieldErrMsg"></div>';

                    break;
                case 17:
                    template = '<div class="career_occupation" id="careerO-_[[::question.ordinal]]_[[::question.sub_ordinal]]" ng-if="question.question_type == 17 " question="question" careers="careers" field-err-msg="fieldErrMsg"></div>';

                    break;
                case 18:
                    template = '<div class="career" id="career_[[::question.ordinal]]_[[::question.sub_ordinal]]" ng-if="question.question_type == 18 " question="question" careers-only="careers_only" field-err-msg="fieldErrMsg"></div>';

                    break;
                case 19:
                    template = '<div class="racial" id="race_[[::question.ordinal]]_[[::question.sub_ordinal]]" ng-if="question.question_type == 19 " question="question" racials="racials" field-err-msg="fieldErrMsg"></div>';

                    break;
                case 20:
                    template = '<div class="academic" id="academic_[[::question.ordinal]]_[[::question.sub_ordinal]]" ng-if="question.question_type == 20 " question="question" academics="academics" field-err-msg="fieldErrMsg"></div>';

                    break;
                case 21:
                    template = '<div class="program" id="program_[[::question.ordinal]]_[[::question.sub_ordinal]]" ng-if="question.question_type == 21 " question="question" programs="programs" field-err-msg="fieldErrMsg"></div>';

                    break;
                case 22:
                    template = '<div class="noprefToggle" id="nopref_[[::question.ordinal]]_[[::question.sub_ordinal]]" ng-if="question.question_type == 22 " question="question" field-err-msg="fieldErrMsg"></div>';

                    break;
                case 23:
                    template = '<div class="dropdown-dependence" id="employer_[[::question.ordinal]]_[[::question.sub_ordinal]]" ng-if="question.question_type == 23" question="question" field-err-msg="fieldErrMsg"></div>';
            }

            return template;
        }

    }
]);
// Save Form Message Controller - timeout function so message disappears after a few seconds...
forms.controller('saveBtnController', [
    '$scope',
    '$timeout',
    '$http',
    '$window',
    'Form',
    'appFunc',
    '$document',
    'jsonLogger',
    function($scope, $timeout, $http, $window, Form, appFunc, $document, jsonLogger) {
        /* debug_log */
        var logger = new jsonLogger();

        $scope.showMsg = false;
        $scope.showSaveMsg = function() {
            var msgTimer = false;
            var msgDuration = 2000;
            $scope.theMsg = "Your progress has been saved!";
            if (msgTimer) {
                $timeout.cancel(msgTimer);
            }
            $scope.showMsg = true;
            $scope.msgTimer = $timeout(function() {
                $scope.showMsg = false;
            }, msgDuration);
        };

        $scope.submitApplicationCounter = 0;
        // --------- TO DO! Clean up this and create a directive to handle DOM manipulation. --------------
        $scope.submitApplication = function(person, user_id, count) {
            if(angular.isDefined(count)){
            $scope.submitApplicationCounter = $scope.submitApplicationCounter + 1;
        } else {
            $scope.submitApplicationCounter = 0;
        }

            // we are going to check that there are no undefined invalid fields....if there are
            // take user to question, if there are none, submit request;
            var offset = 30;
            var duration = 2000;
            $scope.busySubmit = true;
            $scope.buttonText = "Submitting...";
            //console.log(user_id);

            /* debug_log */
            logger.createNewID();
            var metadata = logger.getMetaData();
            metadata.caller = 'saveBtnController.submitApplication';
            logger.setMetaData(metadata);
            var current_section = appFunc.getSection();
            logger.log({'status' : 'Submit called', 'from_section' : current_section});
            logger.log({'status' : 'Checking for unanswered questions', 'section' : $scope.section});
/*
            var pass = $scope.section.questions.every(function(question) {
                if (question.required === true) {
                    
                    question.edited = true;
                    var ele = null;

                    if (question.question_type == 17) {
                        ele = angular.element(document.querySelector('#q' + question.id + ' .occupation')); // question id pattern
                    } else {
                        ele = angular.element(document.querySelector('#q' + question.id)); // question id pattern
                    }

                    if (ele || ele.length >= 0) {
                        question.showRequired = true;
                        $document.scrollToElement(ele, offset, duration);
                    }
                    $scope.busySubmit = false;
                    $scope.buttonText = "Submit";
*/
                    /* debug_log */
/*                    logger.log({'status' : 'One of question is unanswered. Cancelling submit.', 'question' : question});

                    return false;
                }
                return true;
            });
*/
            for (var i = 0; i < $scope.section.questions.length; i++) {
                var question = $scope.section.questions[i];

                var ele = null;
                if (question.question_type == 17) {
                    ele = angular.element(document.querySelector('#q' + question.id + ' .occupation')); // question id pattern
                } else {
                    ele = angular.element(document.querySelector('#q' + question.id)); // question id pattern
                }
                var eleScope;
                if (ele || ele.length >= 0) {
                     var elementDir = angular.element($($(ele.find('div')[0]).find('div')[0]).find('div')[0]);                            
                            eleScope = angular.element(elementDir).scope();
                }


                /**
                 * if this question needs answer and api is still on backend update call, reject
                 */
                if (true === question.is_visible && (true === question.required || true === question.onBackendCall || ( angular.isDefined(question.hasSaveError) && question.hasSaveError === true))) {

                    if (true === question.onBackendCall) {
                        //alert('One of question is updating now, Please try a few seconds later.');
                        //$rootScope.formSaving = 'Saving... Please wait.';
                        $timeout(function() {
                            /* debug_log */
                            logger.log({'status' : 'One of question is updating now. Will retry in one second', 'question' : question});

                            if( $scope.submitApplicationCounter < 3) {
                                $scope.submitApplication(person, user_id,$scope.submitApplicationCounter);
                            }
                        }, 1000);
                        
                    } else if (angular.isDefined(question.hasSaveError) && question.hasSaveError === true) {

                        /* debug_log */
                        logger.log({'status' : 'One of question had error. Saving it. Cancelling move to next section.', 'question' : question});

                        eleScope.update();

                        $timeout(function() {
                            /* debug_log */
                            logger.log({'status' : 'One of question is updating now. Will retry in one second', 'question' : question});
                            if( $scope.submitApplicationCounter < 3) {
                                $scope.submitApplication(person, user_id,$scope.submitApplicationCounter);
                            }
                            
                        }, 1000);
                        
                    } else {
                        question.edited = true;
                          
                        if (ele || ele.length >= 0) {
                            question.showRequired = true;
                            $document.scrollToElement(ele, offset, duration);
                        }
                        
                        $scope.busySubmit = false;
                        $scope.buttonText = "Submit";
                        
                        /* debug_log */
                        logger.log({'status' : 'One of question is unanswered. Cancelling move to next section.', 'question' : question});
                    }

                    return false;
                }
            }

/*            if (pass === false) {
                return false;
            }
*/

            var el1 = angular.element(document.querySelector('.question-section:not(.ng-hide) .ng-valid-parse.ng-invalid.ng-invalid-required.ng-touched'));
            var el2 = angular.element(document.querySelector('.question-section:not(.ng-hide) .question-ptext.ng-pristine.ng-untouched.ng-invalid.ng-invalid-required'));
            //console.log(el1[0]);
            if (typeof el1[0] !== "undefined") {
                $document.scrollToElement(el1[0], offset, duration);
                //console.log("el1:: " + el1[0]);
                $scope.busySubmit = false;
                $scope.buttonText = "Submit";
            } else if (typeof el2[0] !== "undefined") {
                $document.scrollToElement(el2[0], offset, duration);
                $scope.busySubmit = false;
                $scope.buttonText = "Submit";
            } else {

                /* debug_log */
                logger.log({'status' : 'Checking if previous sections has completed all answers.', 'sections' : $scope.form.sections});

                //check if previous section has completed all answers

                if ($scope.form.sections.length > 1) {

                    var sectionIndex = $scope.form.sections.length;

                    var prevSection = $scope.form.sections[sectionIndex - 2];

                    for (var i = 0; i < prevSection.questions.length; i++) {

                        /* debug_log */
                        logger.log({'status' : 'Checking if previous section has completed all answers.', 'section' : prevSection});

                        var question = prevSection.questions[i];

                        /**
                         * if this question needs answer and api is still on backend update call, reject
                         */
                        if (true === question.is_visible && (true === question.required || true === question.onBackendCall)) {

                            // move to previous section and return false
                            var currTab = sectionIndex;

                            var nextTab = sectionIndex - 1;

                            angular.element('#' + nextTab).removeClass('disabled').addClass('active');
                            angular.element('#' + currTab).removeClass('active').addClass('past');
                            $scope.$parent.section = $scope.$parent.form.sections[nextTab-1];
                            appFunc.setSection($scope.$parent.section); //register section to Service Variable

                            $scope.$parent.isNext = true;

                            $scope.busySubmit = false;
                            $scope.buttonText = "Submit";

                            //update the header tab variable
                            var headerCtrlScope = angular.element(document.querySelector('#headerCtrl')).scope();
                            headerCtrlScope.theTab = nextTab;

                            // the element you wish to scroll to.
                            var header = angular.element(document.querySelector('#header')); // question id pattern

                            $document.scrollToElement(header);

                            // Set the html focus
                            var mainFrm = angular.element('#default');
                            mainFrm.focus();

                            /* debug_log */
                            logger.log({'status' : 'One question is unanswered. Moving to previous section.', 'question' : question, 'section' : prevSection});

                            return false;
                        }
                    }

                }


                /* debug_log */
                logger.log({'status' : 'No question is unanswered. Submiting form.'});
                
                //console.log("no more errors");
                if (typeof user_id != "undefined") {
                    /* debug_log */
                    logger.log({'status' : 'Calling','api' : '/forms_complete/form/' + $scope.formId + '/' + user_id + '/'});

                    $http.post('/forms_complete/form/' + $scope.formId + '/' + user_id + '/').success(function() {
                        console.log("app submitted successfully");
                        $scope.busySubmit = false;

                        /* debug_log */
                        logger.log({'status' : 'Success'});
                        
                        setTimeout(function() {
                            var logoutUrl = "//" + $window.location.host + '/forms_complete/done/';
                            $window.location.href = logoutUrl;
                        }, 500)
                        
                    }).
                    error(function(error) {
                        $scope.busySubmit = false;
                        $scope.buttonText = "Submit";
                        $scope.error = "Application could not be submitted, please retry";

                        /* debug_log */
                        logger.log({'status' : 'Error', 'response' : error});

                        //console.log(error);
                    });
                } else {
                    /* debug_log */
                    logger.log({'status' : 'Calling','api' : '/forms_complete/form/' + $scope.formId + '/'});

                    $http.post('/forms_complete/form/' + $scope.formId + '/').success(function() {
                        console.log("app submitted successfully");
                        $scope.busySubmit = true;

                        /* debug_log */
                        logger.log({'status' : 'Success'});
                        
                        setTimeout(function() {
                            var logoutUrl = "//" + $window.location.host + '/forms_complete/done/';
                            $window.location.href = logoutUrl;
                        }, 500)

                    }).
                    error(function(error) {
                        $scope.error = "Application could not be submitted, please retry";

                        /* debug_log */
                        logger.log({'status' : 'Error', 'response' : error});

                        //console.log(error);
                    });
                }
            }
        };

    }
]);

forms.controller('headerController', [
    '$scope',
    '$rootScope',
    'Form',
    'appFunc',
    '$document',
    '$timeout',
    'jsonLogger',
    function($scope, $rootScope, Form, appFunc, $document, $timeout, jsonLogger) {
        /* debug_log */
        var logger = new jsonLogger();

        $scope.init = function() {
            // angular.element('ul > li:first-child').trigger('click');
            //$scope.ordinal =1;
            // To start where user left off, we could set this init tab...
            $scope.theTab = 1;
        };

        $scope.selectedSect = function(sect) {
            $scope.theTab = sect.index;
            //console.log($scope.theTab);
        };

        $scope.isDisabledSection = function(index) {

            if ($rootScope.globalUser && $rootScope.globalUser !== '') {
                return false;
            }

            if (index + 1 !== $scope.theTab) {
                return true;
            }

        };

        $scope.moveToSection = function(index) {
            if ($scope.isDisabledSection(index) == true) {
                return;
            }

            if ($rootScope.globalUser && $rootScope.globalUser !== '') {
                //Not needed as navigation based on header click is not used any more.
                    
                var mainScope = angular.element(document.querySelector('#body-container')).scope();
                mainScope.section = mainScope.form.sections[index];
                $scope.theTab = index + 1;
                
                /* debug_log */
                
                var metadata = logger.getMetaData();
                metadata.caller = 'headerController.moveToSection';
                logger.setMetaData(metadata);
                logger.log({'status' : 'Moving to section.', 'section' : mainScope.section, 'isDisabledSection' : $scope.isDisabledSection(index)});


                appFunc.setSection(mainScope.section); //register section to Service Variable
            }
        };
    }
]);


forms.controller('header', [
    '$http', '$scope', '$rootScope','jsonLogger',
    function($http, $scope, $rootScope, jsonLogger) {
        /* debug_log */
        var logger = new jsonLogger();
        
        $http({
            method: 'GET',
            url: '/generic/user_info/'
        }).then(function(data, status, headers, config) {
            //console.log('user' + data.data);
            $rootScope.firstname = data.data.self.f_name;
            $rootScope.lastname = data.data.self.l_name;
            $rootScope.useridnum = data.data.self.user_id;
            $rootScope.userrole = data.data.self.role;
            $rootScope.persona = data.data.self.persona_id;

            /* debug_log */
            var loggerData = logger.getLoggerData();
            if(typeof loggerData.login_user_id === "undefined" || loggerData.login_user_id.toString().trim() === "" || loggerData.login_user_id.length === 0){
                loggerData.login_user_id = data.data.self.user_id;
                logger.setLoggerData(loggerData);
            }

            return data.data;
        }, function(error) {
            console.log(error);
            return error;
        });

    }
]);

forms.directive('compile', ['$compile',
    function($compile) {
        return function(scope, element, attrs, ctrl, transclude) {
            scope.$watch(
                function(scope) {
                    return scope.$eval(attrs.compile);
                },
                function(value) {

                    var contents, insertPoint, wrapper;
                    wrapper = angular.element(document.createElement('div'));
                    wrapper.html(value);
                    var elementContent = element.contents();
                    insertPoint = angular.element(wrapper[0].querySelector("[ng-transclude]"));

                    if (insertPoint.length) {
                        insertPoint.replaceWith(elementContent.clone());
                    }
                    contents = wrapper.contents();
                    element.html(contents);
                    $compile(element.contents())(scope);

                    //element.html(value);
                    //$compile(element.contents())(scope);

                }
            );
        };

    }
])