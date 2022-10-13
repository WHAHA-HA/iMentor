(function () {
    'use strict';

    var serviceId = 'widgetService';

    angular.module('canvas')
        .factory(serviceId, ['$http', 'config','common', 'messageConstant','imEmbedService', widgetService]);

    function widgetService($http, config, common, messageConstant,imEmbedService) {
        var $q = common.$q;

        var service = {
            getWidgetHeights: getWidgetHeights,
            createActivityMessage: createActivityMessage,
            getTimestamp: getTimestamp,
            createMessage : createMessage,
            getWidgetApp: getWidgetApp,
            getWidgetContent: getWidgetContent,
            getWidgetResponseMarker: getWidgetResponseMarker,
            getWidgetResponse: getWidgetResponse
        };

        return service;
        // Base64 encoding service used by AuthenticationService
        
        function getWidgetContentTemplate(url, type, scope) {
            var template = '';
            
            template = imEmbedService.getTemplate(url, type, scope);

            return template;
        }


        function getWidgetContent(content) {
            var type = content.content_type;
            
            var template = '';
                
            switch(type) {
                case  messageConstant.widgetContentType.WIDGET_CONTENT_AUDIO:
                    template = '<div class="audio-widget" content="{{content.url}}"></div>';
                    break;
                case  messageConstant.widgetContentType.WIDGET_CONTENT_YOUTUBE:
                    template = '<div class="html-widget" content="{{content.url}}"></div>';
                    break;
                case  messageConstant.widgetContentType.WIDGET_CONTENT_VIMEO:
                    template = '<div class="html-widget" content="{{content.url}}"><div ng-transclude></div></div>';
                    break;
                case  messageConstant.widgetContentType.WIDGET_CONTENT_TED:
                    template = '<div class="html-widget" content="{{content.url}}"></div>';
                    break;
                case  messageConstant.widgetContentType.WIDGET_CONTENT_PREZI:
                    template = '<div class="html-widget" content="{{content.url}}"></div>';
                    break;
                case  messageConstant.widgetContentType.WIDGET_CONTENT_GDOC:
                    template = '<div class="html-widget" content="{{content.url}}"></div>';
                    break;
                case  messageConstant.widgetContentType.WIDGET_CONTENT_MDOC:
                    template = '<div class="file-widget" content="{{content.url}}"></div>';
                    break;
                case  messageConstant.widgetContentType.WIDGET_CONTENT_PDF:
                    template = '<div class="file-widget" content="{{content.url}}"></div>';
                    break;
                case  messageConstant.widgetContentType.WIDGET_CONTENT_IMAGE:
                    template = '<div class="image-widget" content="{{content.url}}"></div>';
                    break;
                case  messageConstant.widgetContentType.WIDGET_CONTENT_LINK:
                    template = '<div class="file-widget" content="{{content.url}}"></div>';
                    break;
                case  messageConstant.widgetContentType.WIDGET_CONTENT_HTML:
                    template = '<div class="html-widget" content="{{content.url}}"></div>';
                    break;
                case  messageConstant.widgetContentType.WIDGET_CONTENT_PLAINTEXT:
                    template = '<div class="text-widget" content="{{content.url}}"></div>';
                    break;
                case  messageConstant.widgetContentType.WIDGET_CONTENT_GIST:
                    template = '<div class="html-widget" content="{{content.url}}"></div>';
                    break;
                case  messageConstant.widgetContentType.WIDGET_CONTENT_SOUNDCLOUD:
                    template = '<div class="html-widget" content="{{content.url}}"></div>';
                    break;
                case messageConstant.widgetContentType.WIDGET_CONTENT_UPLOADED_FILE:
                    template = '<div class="link-widget" content="{{content.url}}"></div>';
                    break;
            }

            return template;
        }


        function getWidgetResponseMarker(responseMarker) {
            var type = responseMarker.response_type;
            
            var template = '';
                
            switch(type) {
                case  messageConstant.widgetResponseType.WIDGET_CRESPONSE_FREEFORM_TEXT:
                    template = '<div class="response-marker-html-widget response-type-widget" content="{{content.prompt}}"></div>';
                    break;
                case  messageConstant.widgetResponseType.WIDGET_CRESPONSE_HTML:
                    template = '<div class="response-marker-html-widget response-type-widget" content="{{content.prompt}}"></div>';
                  break;
                case  messageConstant.widgetResponseType.WIDGET_CRESPONSE_MULT_CHOICE:
                    template = '<div class="response-marker-html-widget response-type-widget" content="{{content.prompt}}"></div>';
                    break;
                case  messageConstant.widgetResponseType.WIDGET_CRESPONSE_SINGLE_CHOICE:
                    template = '<div class="response-marker-html-widget response-type-widget" content="{{content.prompt}}"></div>';
                    break;
                case  messageConstant.widgetResponseType.WIDGET_CRESPONSE_INTEGER_ENTRY:
                    template = '<div class="response-marker-html-widget response-type-widget" content="{{content.prompt}}"></div>';
                    break;
                case  messageConstant.widgetResponseType.WIDGET_CRESPONSE_SELECTION_FROM_TABLE:
                    template = '<div class="response-marker-html-widget response-type-widget" content="{{content.prompt}}"></div>';
                    break;
                case  messageConstant.widgetResponseType.WIDGET_CRESPONSE_FILE_UPLOAD:
                    template = '<div class="upload-widget response-type-widget" ></div>';
                    break;
            }

            return template;
        }

        function getWidgetResponse(responseMarker) {
            var type = responseMarker.response_type;
            
            var template = '';
                
            switch(type) {
                case  messageConstant.widgetResponseType.WIDGET_CRESPONSE_FREEFORM_TEXT:
                    template = '<div class="response-html-widget response-type-widget" content="{{content.prompt}}"></div>';
                    break;
                case  messageConstant.widgetResponseType.WIDGET_CRESPONSE_HTML:
                    template = '<div class="response-html-widget response-type-widget" content="{{content.prompt}}"></div>';
                  break;
                case  messageConstant.widgetResponseType.WIDGET_CONTENT_VIMEO:
                    template = '<div class="response-html-widget response-type-widget" content="{{content.prompt}}"></div>';
                    break;
                case  messageConstant.widgetResponseType.WIDGET_CRESPONSE_MULT_CHOICE:
                    template = '<div class="response-html-widget response-type-widget" content="{{content.prompt}}"></div>';
                    break;
                case  messageConstant.widgetResponseType.WIDGET_CRESPONSE_SINGLE_CHOICE:
                    template = '<div class="response-html-widget response-type-widget" content="{{content.prompt}}"></div>';
                    break;
                case  messageConstant.widgetResponseType.WIDGET_CRESPONSE_INTEGER_ENTRY:
                    template = '<div class="response-html-widget response-type-widget" content="{{content.prompt}}"></div>';
                    break;
                case  messageConstant.widgetResponseType.WIDGET_CRESPONSE_SELECTION_FROM_TABLE:
                    template = '<div class="response-html-widget response-type-widget" content="{{content.prompt}}"></div>';
                    break;
            }

            return template;
        }

        function getWidgetApp(app) {
            var type = app.app_type;
            var template = '';
            
            switch(type) {
                case messageConstant.appType.APP_TYPE_RECONNECTING:
                    template = '<div class="reconnecting-app"><div ng-transclude></div></div>';
                    break;
                case messageConstant.appType.APP_TYPE_PRESENTATION:
                    template = '<div class="presentation-app"><div ng-transclude></div></div>';
                    break;
                case messageConstant.appType.APP_TYPE_FILEUPLOAD:
                    template = '<div class="upload-app"><div ng-transclude></div></div>';
                    break;
                case messageConstant.appType.APP_TYPE_LOG:
                    template = '<div class="log-app"><div ng-transclude></div></div>';
                    break;
            }

            return template;
        }

        function getWidgetHeights() {
            
            return {
                '1': 'Small',
                '2': 'Medium',
                '3': 'Large'
            };

        }

        function createActivityMessage(widget,state,type,data) {
            var message = {'id':getTimestamp(), 'state': state, 'sendMask':widget.sendMask, 'type':type, 'data':data};
            return angular.copy(message);
        }

        function createMessage(param,data) {
            var message = {};

            message.src_dst = param.flow;
            message.type = param.type;
            if(param.command) {message.command = param.command;}
            if(param.status) {message.status = param.status;}
            message.timestamp_ms = getTimestamp();
            message.recv_mask = param.recv_mask;
            message.send_mask = param.send_mask;
            if(data) {message.data = data; }
            return angular.copy(message);
        }

        function getTimestamp(){
            return (new Date()).getTime();
        }


        function SetCredentials(username, password) {
            //console.log(Base64);
            var authdata = '';//Base64.encode(username + ':' + password);
            $http.defaults.headers.common['Authorization'] = 'Basic ' + authdata; // jshint ignore:line
        }

    }
})();

/*
    id = Column(Integer, primary_key=True, nullable=False)
    user_id = Column(Integer, ForeignKey(IuserUser.id), nullable=False, default=0)
    # This message is intended for user id X, which could be null.
    for_user_id = Column(Integer, ForeignKey(IuserUser.id), nullable=True, default=None)
    src_dst = Column(Integer, nullable=False, default=0) # see src/dest types, above
    # see widget types, above
    widget_type_send_mask = Column(Integer, nullable=False, default=0) 
    receive_mask = Column(Integer, nullable=False, default=0) 
    # See above message types
    message_type = Column(Integer, nullable=False, default=0)
    # command or status based on message type
    command = Column(Integer, nullable=False, default=0)
    status = Column(Integer, nullable=False, default=0)
    timestamp_ms = Column(BigInteger, nullable=False, default=0)
    received_by_server = Column(DateTime, nullable=True, default=None)
    sent_to_recipient = Column(DateTime, nullable=True, default=None)
    json_data = Column(Text, nullable=True, default=None)
*/
/*
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
# Constants
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
# Message source/destination from_to
W2W =   1 # widget to widget
ROOT_BACKEND =  2 # from root to backend
BACKEND_ROOT =  3 # from backend to root
WIDGET_BACKEND =  4 # from widget to backend
BACKEND_WIDGET =  5 # from backend to widget

# Message types: 'type':1,'command':1, or 
#                'type':2,'status':3, or
#                'type':3,'data':{'message':{...}}
COMMAND =  1
MESSAGE =  2
STATUS =   3

# Root canvas commands
OPENW = 1
CLOSEW = 2

# Widget-level commands
RESET_RECV_BITMASK = 3
RESET_SEND_BITMASK = 4

# Status types
HELLO = 1
GOODBYE = 2
ACK = 3
LOST_FOCUS = 4

# Send masks reserved for knonwn widgets
# These must be unique powers of 2
MM_WRITER_1_SENDMASK          = 1   
MM_WRITER_2_SENDMASK          = 2   
MM_WRITER_3_SENDMASK          = 4   
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
