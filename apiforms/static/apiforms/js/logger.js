var logger = angular.module('loggerServices',[]);

logger.value('log', {
    id: undefined,
    enabled: false,
    data: {}
});

logger.service('jsonLogger', ['$q','$http','log', function($q,$http,log){

  function logger(){
    
    var uniqueID = function(){
      function chr4(){
        return Math.random().toString(16).slice(-4);
      }
      return chr4() + chr4() +
        '-' + chr4() +
        '-' + chr4() +
        '-' + chr4() +
        '-' + chr4() + chr4() + chr4();
    };
 
    var data = {};
    data.metaData = {};

    this.createNewID = function() {
      data.log_transaction_id = uniqueID();
      return data.log_transaction_id;
    };

    this.getID = function() {
      return data.log_transaction_id;
    };

    this.enable = function() {
      log.enabled = true;
    };

    this.disable = function() {
      log.enabled = false;
    };

    this.setMetaData = function(metaData) {
      return data.metaData = metaData;
    };

    this.getMetaData = function() {
      return data.metaData;
    };

    this.setLoggerData = function(data) {
      return log.data = data;
    };

    this.getLoggerData = function() {
      return log.data;
    };

    this.log = function(payload) {
        if(log.enabled === true) {
            if(angular.isDefined(log.id)===false) {
              log.id = uniqueID();
            }
            
            if(angular.isDefined(data.log_transaction_id) === false){
              data.log_transaction_id = uniqueID();
            }
            data.logger = log;
            data.payload = payload;

            $http({ method: 'POST', url: '/generic/json_logger/',  data: JSON.stringify(angular.toJson(data))})
              .then(function(data, status, headers, config) {
                //console.log('POST logjson Success');
              }, function(error){
                //logger('POST logJson Failed - Error',error);
            });
        }
    };
  }

  return logger;

}]);

