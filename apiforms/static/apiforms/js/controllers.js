var controllers = angular.module('inControllers', ['loggerServices']);

controllers
.controller ('GenericSectionController', ['$scope','jsonLogger', function($scope,jsonLogger){
	
	loadSections();
	function loadSections(){
		/* debug_log */
		var logger = new jsonLogger();		
        var loggerData = logger.getLoggerData();
        loggerData.form_id = $scope.form_id;
        logger.setLoggerData(loggerData);
		logger.setMetaData({'caller' : 'inControllers.loadSections'});
		logger.log({'status' : 'Calling'});

		loadSections.AllSections({'form_id':$scope.form_id})
			.success(function(response){
				$scope.sections = response["sections"];

				/* debug_log */
				logger.log({'status' : 'Success', 'response' : JSON.stringify(response)});
			})
			.error(function(error_msg){
				$scope.contact_error = "Sorry, no response from server. Please, try again.";

				/* debug_log */
				logger.log({'status' : 'Error', 'response' : JSON.stringify(error_msg)});
				
				alert($scope.contact_error);
			});

	};
}]);
