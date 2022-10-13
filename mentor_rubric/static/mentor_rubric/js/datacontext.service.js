(function () {
    'use strict';

    var serviceId = 'datacontext';

    angular.module('mentor_rubric')
        .factory(serviceId, ['$http','$window', '$timeout','$q',  datacontext]);

    function datacontext($http, $window, $timeout, $q) {
        var connectionTimeout = 20000;
        var canceller;
        
        var service = {
            getProgramYears: getProgramYears,
            getPartnerInfo: getPartnerInfo,
            getNewContent: getNewContent,
            cancelNewContentRequest: cancelNewContentRequest,
            updateData : updateData
        };

        return service;

        

        function getProgramYears(partner_id) {
           
            return $http({ method: 'POST', url: '/mentor_rubric/program_years/', data: {'force' : true}})
                .then(function(data, status, headers, config) {
                    return data.data;
                }, function(error){
                    console.log('Get PartnerInfo Failed - Network Error - ' + error);
                    return error;
                });
        }

        function getPartnerInfo(partner_id) {
           
            return $http({ method: 'GET', url: '/generic/partner_info/'})
                .then(function(data, status, headers, config) {
                    return data.data;
                }, function(error){
                    console.log('Get PartnerInfo Failed - Network Error - ' + error);
                    return error;
                });
        }

        function getNewContent(partner_ids, program_year_id) {
        	
        	if(canceller && canceller.promise.$$state.status === 0) {
				canceller.resolve("user cancelled");
				canceller = $q.defer();
			}else {
				canceller = $q.defer();
			}
            return $http({ method: 'POST', url: '/mentor_rubric/rubric_data/',  data: JSON.stringify({'partner_ids' : partner_ids, 'program_year_id' : program_year_id}),
			        timeout: canceller.promise})
                .then(function(data, status, headers, config) {
                    return data.data;
                }, function(error){
                    console.log('Get NewContent Failed - Network Error - ' + error);
                    return error;
                });
  
        }

        function cancelNewContentRequest() {
        	if(canceller) {
				canceller.resolve("user cancelled");	
			}
        }


        function updateData(persona_id, user_id, program_year_id, rubric_strengths_based, rubric_resources, rubric_response_time, rubric_curriculum) {
            
            return $http({ method: 'POST', url: '/mentor_rubric/mentor_data/',  data: JSON.stringify({'persona_id' : persona_id, 'user_id': user_id, 'program_year_id' : program_year_id, 'rubric_strengths_based' : rubric_strengths_based, 'rubric_resources' : rubric_resources, 'rubric_response_time' : rubric_response_time, 'rubric_curriculum' : rubric_curriculum}),
                    timeout: 20000})
                .then(function(data, status, headers, config) {
                    return data.data;
                }, function(error){
                    console.log('Get NewContent Failed - Network Error - ' + error);
                    return error;
                });
  
        }

    }
})();
