var services = angular.module('ccServices', []);

var apiEndpoint = "/cchklist/fullsearch/";

var apiUncertainEndpoint = "/cchklist/fixed/3/"; //gets CUNY, etc. as suggestions upon no match.

var picksEndpoint = "/cchklist/picks/";

services

.factory('CollegeSearch', ['$http', function($http){
    

    
    var CollegeAPI = {};
    
    CollegeAPI.getList = function(keyword){
        return $http.get(apiEndpoint + keyword + '/');
    };

    CollegeAPI.getUncertainList = function(){
        return $http.get(apiUncertainEndpoint);
    };

    CollegeAPI.getPicks = function(){
    };
    
    return CollegeAPI;
    
}])

.factory('CollegePicks', ['$http', function($http){


	var PicksAPI = {};

  PicksAPI.listColleges = function(filter){
    return $http.get(picksEndpoint + filter + '/');
  };

	PicksAPI.getList = function(){
		return $http.get(picksEndpoint );

	};

	//This is for POSTing a user's first college pick. 
	//It should also update a single existing college pick object if the college's row "id" field is passed in
	// as part of the "pick" object.
	//Subsequent POSTing of additional/updated list of college picks is done by PicksAPI.updatePicks() factory below.
	PicksAPI.postPick = function(pick) {
		return $http.post(picksEndpoint, pick);
	};


	//We are using this to update a user's list of college picks. 
	// When they add new picks or delete existing ones, the most current list of picks will be passed in to replace
	//what currently exist in the backend for this user's record.
	//current_picks is an array of the user's current college picks
	PicksAPI.updateAllPicks = function ( current_picks){
    return $http.post(picksEndpoint , current_picks);
	};

	//NOTE: This has the potential to delete the whole endpoint (i.e. cchklist/picks/1201/) instead of just the list of picks for the userhe
	// As such, would the updateAllPicks() factory be usable to update a user's list of colleges when one or more colleges is deleted
	// from their record?
	PicksAPI.deleteCollege = function (pick_obj){
		return $http.delete(picksEndpoint + 'pick/' + pick_obj.id + '/');
	};

	PicksAPI.updateCollege = function( updated_obj){
    return $http.post(picksEndpoint, updated_obj);
	};

	return PicksAPI;
}]);


