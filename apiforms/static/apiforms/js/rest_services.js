var services = angular.module('formsServices', ['ngResource','loggerServices']);

services
.factory('Form',
  ['$http','$rootScope',
    function($http, $rootScope) {

      var apiEndPoint = '/forms/form/';
      var apiListEndPoint = '/forms/form_gen/';

      return {
        list: function(formId, user_id) {
          if(typeof user_id == "undefined"){
            return $http.get(apiListEndPoint + formId + '/', {
              //params:{user_id: user_id}
            });
          }else {
            return $http.get(apiListEndPoint + formId + '/'+ user_id +'/', {
              //params:{user_id: user_id}
            });
          }

        },
        save: function(formId, sectionId, questionId, data) {
          if(typeof $rootScope.globalUser !== "undefined") {
            return $http.post(apiEndPoint + formId + '/section/' + sectionId + '/question/' + questionId + '/user_response/' + $rootScope.globalUser + '/', data);
          }
          else{
            return $http.post(apiEndPoint + formId + '/section/' + sectionId + '/question/' + questionId + '/user_response/', data);
          }
        },
        delete: function(formId, sectionId, questionId) {
          if (typeof $rootScope.globalUser !== "undefined") {
            return $http.delete(apiEndPoint + formId + '/section/' + sectionId + '/question/' + questionId + '/user_response/' + $rootScope.globalUser + '/');
          }
          else{
            return $http.delete(apiEndPoint + formId + '/section/' + sectionId + '/question/' + questionId + '/user_response/');
          }
        }
      };

      //return $resource('/forms/form/:formId/', {}, {
      //  query: {
      //    method: 'GET', params:{formId:'@form_id'}, isArray: true
      //  },
      //  save: {
      //    method: 'POST',
      //    params:{formId:'@form_id',sectionId:'@section_id',questionId:'@question_id'}
      //  }
      //});
    }
  ]
)

.factory('Lookup', function($resource){

  return $resource('/forms_data/form_lookup/', {}, {
    query: {method: 'GET', params:{}}
  });

})

/**
 * General Question Factory
 */

.factory('Question', function($resource){
  return $resource('/forms/form/:formId/section/:sectionId/question/:questionId/user_response/', {}, {
    save: {method: 'POST',
      params:{formId:'@form_id',sectionId:'@section_id',questionId:'@question_id'}
    }
  });
})

/**
 * Question Type of DropdownCollege Factory
 * http://127.0.0.1:8000/forms_data/colleges/emp/
 */
.factory('College', function($resource){
  return $resource('/forms_data/colleges/:filter/', {filter: '@filter'}, {

  });
})

/**
 * Question Type of DropdownCollege Factory
 * http://127.0.0.1:8000/forms_data/employers/emp/
 */
.factory('Employer', function($resource){
  return $resource('/forms_data/employers/:filter/', {filter: '@filter'}, {

  });
})


/**
 * Question Type of DropdownCollege Factory
 * http://127.0.0.1:8000/forms_data/schools/
 */

.factory('School', function($resource){
  return $resource('/forms_data/schools/:userId' + '/', {}, {
    query: {method: 'GET', params:{},  userId:'@user_id'}
  });

})

.factory('Career', function($resource){

  return $resource('/forms_data/careers/', {}, {
    query: {method: 'GET', params:{}, isArray: true}
  });

})

.factory('CareerOnly', function($resource){

  return $resource('/forms_data/careers_only/', {}, {
    query: {method: 'GET', params:{}, isArray: true}
  });

})

/**
 * All Countries
 */
.factory('Country', function($resource){

  return $resource('/forms_data/countries/', {}, {
    query: {method: 'GET', params:{}, isArray: true}
  });

})

/**
 * All States
 */
.factory('State', function($resource){

  return $resource('/forms_data/states/', {}, {
    query: {method: 'GET', params:{}, isArray: true}
  });

})

/**
 * Racial Groups
 */
.factory('Racial', function($resource){
  return $resource('/forms_data/rgroups/', {}, {
    query: {method: 'GET', params:{}, isArray: true}
  });
})

/**
 * Academic Fields
 */
.factory('Academic', function($resource){
  return $resource('/forms_data/afields/', {}, {
    query: {method: 'GET', params:{}, isArray: true}
  });
})

/**
 * Partner Program Fields
 */
.factory('Program', function($resource){


  return $resource('/forms_data/mprograms/:userId' + '/', {}, {
    query: {method: 'GET', params:{}, isArray: true, userId:'@user_id'}

  });
})

.factory('Login', ['$http', function($http){
	var apiEndpoint = "/iuser/ajax_login/";

	var LoginAPI = Object;
	LoginAPI.login = function(login_creds){
		return $http.post(apiEndpoint, login_creds);

	};

	return LoginAPI;

}])
.factory('ResetPassword', ['$http', function($http){
	var apiEndpoint = "/password/ajax_reset_request/";

	var ResetAPI = Object;
	ResetAPI.reset = function(user_email){
		return $http.post(apiEndpoint, {'email':user_email});
	};

	return ResetAPI;
}])
.factory('Signup', ['$http', function($http){
	var apiEndpoint ="/iuser/ajax_createuser/";

	var CreateUserAPI = Object;
	CreateUserAPI.signup = function(registration_creds){
		return $http.post(apiEndpoint, registration_creds);
	}
	return CreateUserAPI;

}])

.service('appFunc', ['$q','Form','jsonLogger', function($q, Form, jsonLogger){
  var func = {};
  
  return {
    hideQuestions: function(hiddenIds) {

      angular.forEach(func.section.questions, function(question, key) {

        if (hiddenIds.indexOf(question.id) !== -1) {
          question.is_visible = false;
          question.required = false;
        }
        else {
          if (false === question.is_visible ) {
            question.is_visible = true;
            if (question.updateRequired) {
              question.updateRequired();
            }
          }
        }

      });
    },
    setSection: function(value) {
      func.section = value;
    },
    getSection: function() {
      return func.section;
    },
    updateUserResponse: function(question, userResponse, scope, collection) {

      /* debug_log */
      var logger = new jsonLogger();
      logger.setMetaData({'caller' : 'appFunc.updateUserResponse'});
      logger.log({'status' : 'Update user response initiated','params' : {'form_id' : func.section.form_id, 'section_id' : func.section.id, 'question_id' : question.id, 'data' : userResponse }});  
                      

      // @collection is a collection multi-selection variable

      var deferred =$q.defer();
      var _this = this;

      //check Question is on the backend api call
      if (question.onBackendCall === true) {
        scope.error = 'already in progress';

        /* debug_log */
        logger.log({'status' : 'Update user response cancelled due to previous save in progress', 'api' : '/forms/form/' , 'params' : {'form_id' : func.section.form_id, 'section_id' : func.section.id, 'question_id' : question.id, 'data' : userResponse }});  

        deferred.reject('already progress');
        return deferred.promise;
      }

      /* add another data parameters */
      userResponse['payload'] = {
        is_visible: question.is_visible,
        is_required: question.is_required,
        required: question.required,
        is_active: question.is_active,
        parent_id: question.parent_id,
        user_id: question.user_id,
        dependent_on_question_id: question.dependent_on_question_id,
        question_section_id: question.section_id,
        section_id: func.section.id
      };

      question.onBackendCall = true;

      /* debug_log */
      logger.log({'status' : 'Calling', 'api' : '/forms/form/', 'params' : {'form_id' : func.section.form_id, 'section_id' : func.section.id, 'question_id' : question.id, 'data' : userResponse }});  

      Form.save(func.section.form_id, func.section.id, question.id, userResponse)
        .success(function(res) {

          
          question.onBackendCall = false;

          if (res.success == true) {
            scope.error = '';
            _this.hideQuestions(res.hide);
            question.hasSaveError = false;

            /* debug_log */
            logger.log({'status' : 'Success','response' : res, 'api' : '/forms/form/', 'params' : {'form_id' : func.section.form_id, 'section_id' : func.section.id, 'question_id' : question.id, 'data' : userResponse }});  

          }
          else {
            scope.error = res.error;
            question.hasSaveError = true;
            /* debug_log */
            logger.log({'status' : 'Error','response' : res, 'api' : '/forms/form/', 'params' : {'form_id' : func.section.form_id, 'section_id' : func.section.id, 'question_id' : question.id, 'data' : userResponse }});  
          }

          deferred.resolve(res);
        })
        .error(function(res) {
          console.log(res);
          question.onBackendCall = false;

          scope.error = 'Answer did not save. Refresh and try again';
          question.required = true;
          question.hasSaveError = true;

          /* debug_log */
            logger.log({'status' : 'Error','response' : res, 'api' : '/forms/form/', 'params' : {'form_id' : func.section.form_id, 'section_id' : func.section.id, 'question_id' : question.id, 'data' : userResponse }});  

          /**
           * clear out selection from collection
           * @param selections
           */
          if (collection) {
            _.each(collection, function(ele) {
              ele.selected = false;
            });
          }

          deferred.reject(res);
        });
      return deferred.promise;
    },
    deleteUserResponse: function(question, scope, collection) {

      /* debug_log */
      var logger = new jsonLogger();
      logger.setMetaData({'caller' : 'appFunc.deleteUserResponse'});
      logger.log({'status' : 'Delete user response initiated','params' : {'form_id' : func.section.form_id, 'section_id' : func.section.id, 'question_id' : question.id}});  


      // @collection is a collection multi-selection variable

      var deferred =$q.defer();
      var _this = this;

      //check Question is on the backend api call
      if (question.onBackendCall === true) {
        scope.error = 'already in progress';

        /* debug_log */
        logger.log({'status' : 'Delete user response cancelled due to previous delete in progress', 'api': 'Form.delete', 'params' : {'form_id' : func.section.form_id, 'section_id' : func.section.id, 'question_id' : question.id }});  

        deferred.reject('already progress');
        return deferred.promise;
      }
      question.onBackendCall = true;

      /* debug_log */
      logger.log({'status' : 'Calling', 'api': '/forms/form/', 'params' : {'form_id' : func.section.form_id, 'section_id' : func.section.id, 'question_id' : question.id }});  


      Form.delete(func.section.form_id, func.section.id, question.id)
        .success(function(res) {

          question.onBackendCall = false;
          if (res.success == true) {
            scope.error = '';
            question.hasSaveError = false;
            /* debug_log */
            logger.log({'status' : 'Success' , 'response' : res, 'api': '/forms/form/', 'params' : {'form_id' : func.section.form_id, 'section_id' : func.section.id, 'question_id' : question.id }});  

          }
          else {
            scope.error = res.error;
            question.hasSaveError = true;
            /* debug_log */
            logger.log({'status' : 'Error','response' : res,  'api': '/forms/form/', 'params' : {'form_id' : func.section.form_id, 'section_id' : func.section.id, 'question_id' : question.id }});  
          }

          deferred.resolve(res);
        })
        .error(function(res) {
          console.log(res);
          question.onBackendCall = false;
          scope.error = 'Answer did not save. Refresh and try again';
          question.required = true;
          question.hasSaveError = true;

          /* debug_log */
          logger.log({'status' : 'Error','response' : res,  'api': '/forms/form/', 'params' : {'form_id' : func.section.form_id, 'section_id' : func.section.id, 'question_id' : question.id }});  

          /**
           * clear out selection from collection
           * @param selections
           */
          if (collection) {
            _.each(collection, function(ele) {
              ele.selected = false;
            });
          }

          deferred.reject(res);
        });
      return deferred.promise;
    }
  };
}]);

