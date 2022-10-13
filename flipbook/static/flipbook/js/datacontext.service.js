(function () {
    'use strict';

    var serviceId = 'datacontext';

    angular.module('flipbook')
        .factory(serviceId, ['$http','$window', '$timeout','$q',  datacontext]);

    function datacontext($http, $window, $timeout, $q) {
        var connectionTimeout = 20000;
        var canceller;
        
        var service = {
            getPartnerInfo: getPartnerInfo,
            getNewContent: getNewContent,
            cancelNewContentRequest: cancelNewContentRequest,
            addFlag : addFlag
        };

        return service;

        function getPartnerInfo(partner_id) {
           
            return $http({ method: 'GET', url: '/generic/partner_info/'})
                .then(function(data, status, headers, config) {

                    //if a user is posting under the incorrect user id
                    if(data.status == 403){
                        $window.location.href = '/';
                    }
                    return data.data;
                }, function(error){
                    console.log('Get PartnerInfo Failed - Network Error - ' + error);
                    return error;
                });
        }

        function getNewContent(partner_ids, filter) {
        	
        	if(canceller && canceller.promise.$$state.status === 0) {
				canceller.resolve("user cancelled");
				canceller = $q.defer();
			}else {
				canceller = $q.defer();
			}
            return $http({ method: 'POST', url: '/flipbook/new_content/',  data: JSON.stringify({'partner_ids' : partner_ids, 'filter' : filter}),
			        timeout: canceller.promise})
                .then(function(data, status, headers, config) {
                    if(data.status == 403){
                        $window.location.href = '/';
                    }
                    return data.data;
                }, function(error){
                    if(error.status == 403){
                        $window.location.href = '/';
                    }
                    console.log('Get NewContent Failed - Network Error - ' + error);
                    return error;
                });
  
        }

        function cancelNewContentRequest() {
        	if(canceller) {
				canceller.resolve("user cancelled");	
			}
        }

        function addFlag(flag_id, flag_type_id, content_id, content_type) {
            
            return $http({ method: 'POST', url: '/flipbook/flag/',  data: JSON.stringify({'flag_id' : flag_id, 'flag_type_id' : flag_type_id, 'content_id' : content_id, 'content_type' : content_type}),
                    timeout: 20000})
                .then(function(data, status, headers, config) {
                    if(data.status == 403){
                        $window.location.href = '/';
                    }
                    return data.data;
                }, function(error){
                    if(error.status == 403){
                        $window.location.href = '/';
                    }
                    console.log('Get NewContent Failed - Network Error - ' + error);
                    return error;
                });
  
        }

    }
})();
