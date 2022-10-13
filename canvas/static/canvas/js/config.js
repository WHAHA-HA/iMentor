(function () {
    'use strict';

    var imentor_cdn_prefix = '';//typeof getCdnUrlPrefix == 'function' ? getCdnUrlPrefix() : '';

    var app = angular.module('canvas');

    // For use with the services
    var remoteServiceName = imentor_cdn_prefix + '/new_platform/static/canvas/data/';
    
    var events = {
        controllerActivateSuccess: 'controller.activateSuccess'
    };

    var config = {
        appErrorPrefix: '[Canvas Error] ', //Configure the exceptionHandler decorator
        docTitle: 'canvas: ',
        events: events,
        remoteServiceName: remoteServiceName,
        version: '0.0.1'
    };

    var messageConstant = {
        /*# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
        # Constants
        # <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*/
        appType: {
            APP_TYPE_RECONNECTING: 1,
            APP_TYPE_PRESENTATION: 2,
            APP_TYPE_FILEUPLOAD: 3,
            APP_TYPE_LOG: 4,
        },

        widgetContentType: {
            // # Widget Content Types
            WIDGET_CONTENT_AUDIO: 1,
            WIDGET_CONTENT_YOUTUBE: 2,
            WIDGET_CONTENT_VIMEO: 3,
            WIDGET_CONTENT_TED: 4,
            WIDGET_CONTENT_PREZI: 5,
            WIDGET_CONTENT_GDOC: 6,
            WIDGET_CONTENT_MDOC: 7,
            WIDGET_CONTENT_PDF: 8,
            WIDGET_CONTENT_IMAGE: 9,
            WIDGET_CONTENT_LINK: 10,
            WIDGET_CONTENT_HTML: 11,
            WIDGET_CONTENT_PLAINTEXT: 12,
            WIDGET_CONTENT_GIST: 13,
            WIDGET_CONTENT_SOUNDCLOUD: 14,
            WIDGET_CONTENT_UPLOADED_FILE: 15

        },

        widgetResponseType: {
            //# Widget Content Response Types
            WIDGET_CRESPONSE_FREEFORM_TEXT: 1,
            WIDGET_CRESPONSE_HTML: 2,
            WIDGET_CRESPONSE_MULT_CHOICE: 3,
            WIDGET_CRESPONSE_SINGLE_CHOICE: 4,
            WIDGET_CRESPONSE_INTEGER_ENTRY: 5,
            WIDGET_CRESPONSE_SELECTION_FROM_TABLE: 6,
            WIDGET_CRESPONSE_FILE_UPLOAD: 7
        },       
        flow: {
            //# Message source/destination from_to
            W2W: 1, //# widget to widget
            ROOT_BACKEND: 2, //# from root to backend
            BACKEND_ROOT: 3, //# from backend to root
            WIDGET_BACKEND: 4, //# from widget to backend
            BACKEND_WIDGET: 5 //# from backend to widget
        },
        type: {
            /*# Message types: 'type':1,'command':1, or 
            #                'type':2,'status':3, or
            #                'type':3,'data':{'message':{...}}*/
            COMMAND: 1,
            MESSAGE: 2,
            STATUS:  3
          
        },
        canvasCommand: {
            //# Root canvas commands
            OPENW: 1,
            CLOSEW: 2
        },
        widgetCommand: {
            //# Widget-level commands
            RESET_RECV_BITMASK: 3,
            RESET_SEND_BITMASK: 4
        },
        status: {
            //# Status types
            HELLO: 1,
            GOODBYE: 2,
            ACK: 3,
            LOST_FOCUS: 4,
            MEDIA_PLAYED: 5,
            MEDIA_STOPPED: 6,
            MEDIA_PAUSED: 6,
            MEDIA_FINISHED: 7,
            SAVE_WORK:  8,
            POLL:  10
        },
        sendMask: {
            /*# Send masks reserved for knonwn widgets
            # These must be unique powers of 2*/
            MM_WRITER_1_SENDMASK: 1,
            MM_WRITER_2_SENDMASK: 2,   
            MM_WRITER_3_SENDMASK: 4,   
            MM_IMAGE_SHARE_1_SENDMASK: 8,   
            MM_IMAGE_SHARE_2_SENDMASK: 16,  
            MM_VIDEO_SHARE_1_SENDMASK: 32,  
            MM_VIDEO_SHARE_2_SENDMASK: 64
        },
        writeWidgetStatus: {
            //# Write Widget Status Messages from the Backend:
            USER_ONLINE: 1,
            USER_OFFLINE: 2
        }
    };

    var labelMessage = {
        failedToLoadDoc: "<h2><i class='fa fa-frown-o'></i> We couldn't load this content.</h2>It's likely due to a security restriction on your computer for content from external sources such as Google, Vimeo, and YouTube.<p><p>However, you have several options:<ul><li>First, if you're on a work or school computer, you could ask the technology team there about the possibility of relaxing these restrictions.</li><li>Second, if you have a mobile device with a cellular connection, you could access the Canvas and its content from there.</li><li>Finally, if you have a home computer, you could access the Canvas and its content from there as well.</li></ul></p></p>Please feel free to contact your staff member with any questions."
    };

    var staticUri = {
        templateUrl: {
            widgetContainer : imentor_cdn_prefix + "/new_platform/static/canvas/nghtml/widget.container.html", 
            mentioTextAngular : imentor_cdn_prefix + "/new_platform/static/canvas/nghtml/mentio_text_angular.html",
            widget : imentor_cdn_prefix + "/new_platform/static/canvas/nghtml/widget.html",
            
            widgetSettings : imentor_cdn_prefix + "/new_platform/static/canvas/nghtml/widget.settings.html",

            writerWidget : imentor_cdn_prefix + "/new_platform/static/canvas/nghtml/writer.widget.html",
            viewerWidget : imentor_cdn_prefix + "/new_platform/static/canvas/nghtml/viewer.widget.html",
            logWidget : imentor_cdn_prefix + "/new_platform/static/canvas/nghtml/log.widget.html",
            uploadWidget : imentor_cdn_prefix + "/new_platform/static/canvas/nghtml/upload.widget.html",



            contentTypeUnknown : imentor_cdn_prefix + "/new_platform/static/canvas/nghtml/content_type_unknown.html",
            contentTypeVideoFile : imentor_cdn_prefix + "/new_platform/static/canvas/nghtml/content_type_video_file.html",
            contentTypeAudioFile : imentor_cdn_prefix + "/new_platform/static/canvas/nghtml/content_type_audio_file.html",
            contentTypeImageFile : imentor_cdn_prefix + "/new_platform/static/canvas/nghtml/content_type_image_file.html",
            contentTypeIframe : imentor_cdn_prefix + "/new_platform/static/canvas/nghtml/content_type_iframe.html",
            contentTypePdfFile : imentor_cdn_prefix + "/new_platform/static/canvas/nghtml/content_type_pdf_file.html",
            contentTypeGoogleDocs : imentor_cdn_prefix + "/new_platform/static/canvas/nghtml/content_type_google_docs.html",
            contentTypeDocumentFile : imentor_cdn_prefix + "/new_platform/static/canvas/nghtml/content_type_document_file.html",
            contentTypeWorksheetFile : imentor_cdn_prefix + "/new_platform/static/canvas/nghtml/content_type_worksheet_file.html",
            contentTypePresentationFile: imentor_cdn_prefix + "/new_platform/static/canvas/nghtml/content_type_presentation_file.html",
            contentTypeSoundcloud : imentor_cdn_prefix + "/new_platform/static/canvas/nghtml/content_type_soundcloud.html",
            contentTypeText : imentor_cdn_prefix + "/new_platform/static/canvas/nghtml/content_type_text.html",
            contentTypeHtml : imentor_cdn_prefix + "/new_platform/static/canvas/nghtml/content_type_html.html",
            contentTypeSite : imentor_cdn_prefix + "/new_platform/static/canvas/nghtml/content_type_site.html",
            contentTypeLink : imentor_cdn_prefix + "/new_platform/static/canvas/nghtml/content_type_link.html",

            responseMarkerHtml: imentor_cdn_prefix + "/new_platform/static/canvas/nghtml/response_marker_html.html",
            responseHtml: imentor_cdn_prefix + "/new_platform/static/canvas/nghtml/response_html.html",

            //reconnectingContent : imentor_cdn_prefix + "/new_platform/static/canvas/nghtml/reconnecting.content.html",
            reconnectingWriter : imentor_cdn_prefix + "/new_platform/static/canvas/nghtml/reconnecting.writer.html",

            appTypePresentation : imentor_cdn_prefix + "/new_platform/static/canvas/nghtml/presentation.app.html",
            appTypeReconnecting : imentor_cdn_prefix + "/new_platform/static/canvas/nghtml/reconnecting.app.html",
            appTypeUpload : imentor_cdn_prefix + "/new_platform/static/canvas/nghtml/upload.app.html",
            appTypeLog : imentor_cdn_prefix + "/new_platform/static/canvas/nghtml/log.app.html",

        },
        routeUri:{
            uploadUri : "/user_content/",
            canvasFinish : "/canvas/finished/",
        },
        resourceUri: {
            emojiImage : imentor_cdn_prefix + "/new_platform/static/emoji/img-apple-64/",
            emojiPath : imentor_cdn_prefix + "/new_platform/static/emoji/"
        }
    };

    app.value('messageConstant', messageConstant);

    app.value('staticUri', staticUri);
    
    app.value('config', config);

    app.value('labelMessage', labelMessage);
    
    
    app.config(['$logProvider', function ($logProvider) {
        // turn debugging off/on (no info or warn)
        $logProvider.debugEnabled(true);
    }]);
    
    //#region Configure the common services via commonConfig
    app.config(['commonConfigProvider', function (commonConfigProvider) {
        commonConfigProvider.config.controllerActivateSuccessEvent = config.events.controllerActivateSuccess;
    }]);

    app.config(['eventTrackerProvider',  function(eventTrackerProvider) {
        eventTrackerProvider.setEventHandlers(['Log']);
    }]);

 
    //Optional $sanitize override option
    app.config(['$provide','$sceDelegateProvider', function($provide,$sceDelegateProvider){
        $provide.decorator("$sanitize", ['$delegate', '$log', function($delegate, $log){
            return function(text, target){
     
                var result = $delegate(text, target);
                //$log.info("$sanitize input: " + text);
                //$log.info("$sanitize output: " + result);
     
                return result;
            };
        }]);

        // Whitelist cdn 
        $sceDelegateProvider.resourceUrlWhitelist([
            // Allow same origin resource loads.
            'self',
            // Allow loading from outer templates domain.
            'https://cdn.imentor.org/**'
        ]); 
    }]);


    //window.onLineURL = "/generic/is_online/";
    //window.onLineCheckTimeout = 5000;
})();
