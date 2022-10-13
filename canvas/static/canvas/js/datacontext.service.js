(function () {
    'use strict';

    var serviceId = 'datacontext';

    angular.module('canvas')
        .factory(serviceId, ['$http', 'config','common', '$window', '$timeout',  datacontext]);

    function datacontext($http, config, common, $window, $timeout) {
        var $q = common.$q;
        var messages = [];
        var connectionTimeout = 20000;

        // Special edge cas efor IE or Edge browser
        var version = detectIE();

        if (version === false) {
          connectionTimeout = 20000;
        } else if (version >= 12) {
          connectionTimeout = 600000;
        } else {
          connectionTimeout = 600000;
        }

        var logger = common.logger.getLogFn('Data Service');

        var service = {
            getCanvas: getCanvas,
            getGrid: getGrid,
            getState: getState,
            getImages: getImages,
            postMessages: postMessages,
            getMessages: getMessages,
            getUserInfo: getUserInfo,
            getPresentation: getPresentation,
            getCanvasNew: getCanvasNew,
            postPresentation: postPresentation,
            postReconnecting: postReconnecting,
            getSurvey: getSurvey,
            getPresentationLesson: getPresentationLesson,
            postFinished: postFinished,
            logJson: logJson,
            postNoload: postNoload,
            getPresentationLessonCopy: getPresentationLessonCopy
        };

        return service;

        function getSurvey(){
            return $http({ method: 'GET', url: '/new_surveys/survey_link/'})
              .then(function(data, status, headers, config) {
                  return data.data;
              }, function(error){
                  logger('Get Survey Failed - Network Error',error);
                  return error;
              });
        }
        function getCanvas(role) {
            var canvasdata = 'canvas.json';
            switch(role){
                case 'mentee':
                    canvasdata = 'canvas.mentee.json';
                    break;
                case 'mentor':
                    canvasdata = 'canvas.mentor.json';
                    break;
                case 'teacher':
                    canvasdata = 'canvas.teacher.json';
            }

            return $http({ method: 'GET', url: config.remoteServiceName +  canvasdata})
                .then(function(data, status, headers, config) {
                    return data.data;
                }, function(error){
                    logger('Get Canvas Failed - Network Error',error);
                    return error;
                });
        }

         function getCanvasNew() {
            var canvasdata = 'canvas.teacher.json';//'canvas.mentee.json'; //'canvas.new.json';

            return $http({ method: 'GET', url: config.remoteServiceName +  canvasdata})
                .then(function(data, status, headers, config) {
                    return data.data;
                }, function(error){
                    logger('Get Canvas Failed - Network Error',error);
                    return error;
                });
        }

        function getState() {
            return $http({ method: 'GET', url: config.remoteServiceName +  'canvas.update.json'})
                .then(function(data, status, headers, config) {
                    return data.data;
                }, function(error){
                    logger('Get State Failed - Network Error',error);
                    return error;
                });
        }

        function getGrid() {
            return $http({method: 'GET', url: config.remoteServiceName +  'grid.json'})
                .then(function(data, status, headers, config) {
                    return data.data;
                }, function(error){
                    logger('Get Grid Failed - Network Error',error);
                    return error;
                });
        }

        function getImages() {
            return $http({ method: 'GET', url: config.remoteServiceName +  'images.json'})
                .then(function(data, status, headers, config) {
                    return data.data;
                }, function(error){
                    logger('Get Images Failed - Network Error',error);
                    return error;
                });
        }

        function getMessages(userid, timestamp) {
                return  _.filter(messages, function(item){ return messages.timestamp > timestamp && messages.userid !== userid; });
        }

        function postMessages(message) {
                  return $http({ method: 'POST', url: '/canvas/messages/',  data: JSON.stringify(message)})
                .then(function(data, status, headers, config) {
                    if(data.status == 403) {
                        $window.location.href = '/';
                    }
                    console.log('message');
                    if(_.isObject(data.data)) {
                        return data.data;
                    }else {
                        $window.location.href = '/';
                    }
                    
                }, function(error){
                    if(error.status == 403) {
                        $window.location.href = '/';
                    }
                    console.log(error);
                    return error;
                });
        }


        function logJson(json) {
                return $http({ method: 'POST', url: '/generic/json_logger/',  data: JSON.stringify(json)})
                .then(function(data, status, headers, config) {
                    console.log('log json success');
                    if(_.isObject(data.data)) {
                        return data.data;
                    }else {
                        $window.location.href = '/';
                    }
                    
                }, function(error){
                    logger('POST logJson Failed - Network Error',error);
                    return error;
                });
        }

        function postNoload(json) {
                return $http({ method: 'POST', url: '/generic/noload/',  data: JSON.stringify(json)})
                .then(function(data, status, headers, config) {
                    console.log('postNoload success');
                }, function(error){
                    logger('postNoload Failed - Network Error',error);
                    return error;
                });
        }

        function getUserInfo(user_id) {
            if(user_id){
            return $http({ method: 'GET', url: '/generic/user_info/' + user_id + '/'})
                .then(function(data, status, headers, config) {
                    if(data.status == 403) {
                        $window.location.href = '/';
                    }
                    return data.data;
                }, function(error){
                    logger('Get UserInfo Failed - Network Error',error);
                    
                    //Work around show loging page when the user info is unavailable. (ex. back button press after signout)
                    if(_.isObject(error.data) === false || error.status === 404 ) {
                        $window.location.href = '/';
                    }
                    
                    return error;
                });
            } else {
                return $http({ method: 'GET', url: '/generic/user_info/'})
                .then(function(data, status, headers, config) {
                    if(data.status == 403) {
                        $window.location.href = '/';
                    }
                    return data.data;
                }, function(error){
                    logger('Get UserInfo Failed - Network Error',error);
                    
                    //Work around show loging page when the user info is unavailable. (ex. back button press after signout)
                    if(_.isObject(error.data) === false || error.status === 404 ) {
                        $window.location.href = '/';
                    }
                    
                    return error;
                });
            }
        }

        function getPresentation(user_id) {
            var url = '/canvas/presentation/';
            if(user_id) {
              url = url + user_id + '/'
            }

            return $http({ method: 'GET', url: url, timeout: connectionTimeout})
                .then(function(data, status, headers, config) {
                    if(data.status == 403) {
                        $window.location.href = '/';
                    }
                    return data.data;
                }, function(error){
                    logger('Get Presentation Failed - Network Error',error);
                    return error;
                });
        }

        function getPresentationLesson(lessonNum, user_id) {
            var url = '/canvas/lesson/' + lessonNum +'/presentation/';
            if(user_id) {
              url = url + user_id + '/'
            }
            return $http({ method: 'GET', url: url, timeout: connectionTimeout})
                  .then(function(data, status, headers, config) {
                    if(data.status == 403) {
                        $window.location.href = '/';
                    }
                      return data.data;
                  }, function(error){
                      logger('Get Presentation Lesson Failed - Network Error',error);
                      return error;
                  });

        }

        function getPresentationLessonCopy(lessoncopyid, user_id) {
            var url = '/canvas/lessoncopy/' + lessoncopyid +'/presentation/';
            if(user_id) {
              url = url + user_id + '/'
            }
            return $http({ method: 'GET', url: url, timeout: connectionTimeout})
                  .then(function(data, status, headers, config) {
                    if(data.status == 403) {
                        $window.location.href = '/';
                    }
                      return data.data;
                  }, function(error){
                      logger('Get Presentation Lesson Failed - Network Error',error);
                      return error;
                  });

        }


        function postPresentation(message, user_id) {

            var url = '/canvas/presentation/';
            if(user_id) {
              url = url + user_id + '/'
            }

            var deferredAbort = $q.defer();
            var isReolved = false;

            var timeuotTimer = $timeout(function () {
                if(!isReolved) {
                    deferredAbort.resolve();
                }
            },connectionTimeout);

            return $http({ method: 'POST', url: url, data: JSON.stringify(message), 
                timeout: deferredAbort.promise})
                .then(function(data, status, headers, config) {
                    try{ $timeout.cancel(timeuotTimer); } catch(err){ }
                    isReolved = true;

                    //if a user is posting under the incorrect user id
                    if(angular.isDefined(data.data) && angular.isDefined(data.data.success) && data.data.success  === false ) {
                        $window.location.href = '/';
                    }
                    if(data.status == 403) {
                        $window.location.href = '/';
                    }
                    return data.data;
                }, function(error){
                    isReolved = true;
                    logger('POST Presentation Failed - Network Error',error);
                    return error;
                });
        }
        
        function postReconnecting(message, user_id) {
            
            var url = '/canvas/reconnecting/';
            if(user_id) {
              url = url + user_id + '/'
            }

            return $http({ method: 'POST', url: url, data: JSON.stringify(message), timeout: connectionTimeout})
                .then(function(data, status, headers, config) {
                    if(data.status == 403) {
                        $window.location.href = '/';
                    }
                    return data.data;
                }, function(error){
                    logger('POST Reconnecting Failed - Network Error',error);
                    return error;
                });
        }
        
        function postFinished(message, user_id) {

            var url = '/canvas/finished/';
            if(user_id) {
              url = url + user_id + '/'
            }

            return $http({ method: 'POST', url: url, data: JSON.stringify(message), timeout: connectionTimeout})
                .then(function(data, status, headers, config) {
                    if(data.status == 403) {
                        $window.location.href = '/';
                    }
                    return true;
                }, function(error){
                    if(error.status == 403) {
                        $window.location.href = '/';
                    }
                    logger('POST Finished Failed - Network Error',error);
                    return false;
                });            
        }
        
    }
})();

/*
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
# Constants
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
# Canvas App and Widget Constants
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
APP_TYPE_WRITING = 1
APP_TYPE_PRESENTATION = 2

# Widget Content Types
WIDGET_CONTENT_AUDIO = 1
WIDGET_CONTENT_VIDEO = 2
WIDGET_CONTENT_DOC   = 3
WIDGET_CONTENT_HTML  = 4
WIDGET_CONTENT_SITE  = 5 # This is an iframe-embedded site, not a site url.
WIDGET_CONTENT_IMAGE = 6 

# Widget Content Response Types
WIDGET_CRESPONSE_FREEFORM_TEXT = 1
WIDGET_CRESPONSE_HTML          = 2
WIDGET_CRESPONSE_MULT_CHOICE   = 3
WIDGET_CRESPONSE_SINGLE_CHOICE = 4
WIDGET_CRESPONSE_INTEGER_ENTRY = 5
WIDGET_CRESPONSE_SELECTION_FROM_TABLE = 6

# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
# Protocol Constants
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
# Message source/destination from_to
W2W =   1 # widget to widget
ROOT_BACKEND =  2 # from root to backend
BACKEND_ROOT =  3 # from backend to root
WIDGET_BACKEND =  4 # from widget to backend
BACKEND_WIDGET =  5 # from backend to widget

REPLY_MAPPING = {
    W2W:W2W,
    ROOT_BACKEND:BACKEND_ROOT,
    WIDGET_BACKEND:BACKEND_WIDGET
    }

# Message types: 'type':1,'command':1, or 
#                'type':2,'status':3, or
#                'type':3,'data':{'message':{...}}
COMMAND =  1
MESSAGE =  2
STATUS =   3

# Root canvas commands
OPENW = 1
CLOSEW = 2
BLOCK_UI = 3
UNBLOCK_UI = 4

# Widget-level commands
RESET_RECV_BITMASK = 3
RESET_SEND_BITMASK = 4

# Root-level Status types
POLL = 10  # Front end polls from Root Canvas, no messages to process.

# Widget-level Status types
HELLO = 1
GOODBYE = 2
ACK = 3
LOST_FOCUS = 4

# Send masks reserved for known widgets
# These must be unique powers of 2
APP_WRITING_W_SENDMASK        = 1   
APP_WRITING_R_SENDMASK        = 2   
APP_WRITER_PROMPT_SENDMASK    = 4   
MM_IMAGE_SHARE_1_SENDMASK     = 8   
MM_IMAGE_SHARE_2_SENDMASK     = 16  
MM_VIDEO_SHARE_1_SENDMASK     = 32  
MM_VIDEO_SHARE_2_SENDMASK     = 64

# Write Widget Status Messages from the Backend:
USER_ONLINE = 1
USER_OFFLINE = 2


# Message format:
#
# {'src_dst': A, 'type': B, 'status':C or 'command':D, 'timestamp_ms_ms':E, 
# 'send_mask':F, 'recv_mask':G, 'data': {'message':{}...}}
#
# where A = W2W/BACKEND/ROOT, B = COMMAND/STATUS,  C = HELLO/GOODBYE/etc, 
# D = OPENW/CLOSEW (for ROOT type), RESET_RECV_BITMASK/etc (for POLL type),
# and where data:{message:{}} is only required for type MESSAGE.
#
# Note that ACKs contain 'data':{'message':{'timestamp':H}}
#
# where H is the timestamp of the original message

# Message uniqueness is guaranteed by send_mask, timestamp and user_id

# Newly-opened widgets will send a HELLO status msg to the back end, and will
# receive an ACK.

# Messages send to/from the back end are sent as a list.

# Message examples:

# This tells the front end root canvas to open a new widget of type "image"
#{'src_dst':3,'type':1,'command':1,'timestamp_ms':12341241241,'send_mask':8,'recv_mask:0}

# Front end root canvas sends an ACK:
#{'src_dst':3,'type':3,'status':3,'timestamp_ms':3333388877,'send_mask':8,
#    'data':{'timestamp_ms':12341241241}}

# This is a HELLO status message from a widget to the back end
#{'src_dst':2,'type':3,'status':1,'timestamp_ms':12341241241,'send_mask':2, 'recv_mask':1}

# an ACK
#{'src_dst':2,'type':3,'status':3,'timestamp_ms':8888833334444,'send_mask':2,data:{'timestamp_ms':12341241241,...}

*/
