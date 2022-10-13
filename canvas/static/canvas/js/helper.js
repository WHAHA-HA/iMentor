
/*** Download Helper ***/
(function() {

window.downloadFile = function (sUrl) {

    //iOS devices do not support downloading. We have to inform user about this.
    if (/(iP)/g.test(navigator.userAgent)) {
        alert('Your device does not support files downloading. Please try again in desktop browser.');
        return false;
    }

    //If in Chrome or Safari - download via virtual link click
    if (window.downloadFile.isChrome || window.downloadFile.isSafari) {
        //Creating new link node.
        var link = document.createElement('a');
        link.href = sUrl;

        if (link.download !== undefined) {
            //Set HTML5 download attribute. This will prevent file from opening if supported.
            var fileName = sUrl.substring(sUrl.lastIndexOf('/') + 1, sUrl.length);
            link.download = fileName;
        }

        //Dispatching click event.
        if (document.createEvent) {
            var e = document.createEvent('MouseEvents');
            e.initEvent('click', true, true);
            link.dispatchEvent(e);
            return true;
        }
    }

    // Force file download (whether supported by server).
    if (sUrl.indexOf('?') === -1) {
        sUrl += '?download';
    }

    window.open(sUrl, '_self');
    return true;
};

window.downloadFile.isChrome = navigator.userAgent.toLowerCase().indexOf('chrome') > -1;
window.downloadFile.isSafari = navigator.userAgent.toLowerCase().indexOf('safari') > -1;

})();
/*** --Download Helper-- ***/


/*** Iframe Helper ***/
(function() {
    window.loadIframeObject = function () {
        onYouTubeIframeAPIReady();
        onViemoIframeReady();
    };
})();
/*** --Iframe Helper-- ***/

/*** Viemo Helper ***/
var viemoRegex = /^(http\:\/\/|https\:\/\/)?(www\.)?(vimeo\.com\/[0-9]+($|\?.*)|player\.vimeo\.com\/video\/[0-9]*($|\?.+))/;
var viemoPlayerIds = {};
var viemoPlayers = [];

function onViemoIframeReady() {
    
    $('iframe').each( function (k, v) {
        if( viemoRegex.test(this.src)){
            if (!this.id) { this.id='viemovideoiframe' + k; }
            var id = this.id;
            if(!viemoPlayerIds[id]){ 
                var player = $f(this);
                         // When the player is ready, add listeners for pause, finish, and play
                player.addEvent('ready', function() { 
                    player.addEvent('pause', onViemoStateChange(6));
                    player.addEvent('finish', onViemoStateChange(7));
                    player.addEvent('play', onViemoStateChange(5));
                });

                viemoPlayerIds[id] = player;
                viemoPlayers.push(player);
            }
        }
    });
}

function onViemoStateChange(playerState) {
    return function (id) {
        console.log('Viemo : : onViemoStateChange');
        console.log(playerState);
        console.log(id);
        var iframe = angular.element(document.getElementById(id));
        if(iframe){
            var iframeScope = iframe.scope();
            if(iframeScope) {
                var player =  viemoPlayerIds[id];
                player.api("getCurrentTime", function (currentTime, player_id) {
                     iframeScope.videoStateChange(playerState, currentTime);
                });
            }
        }
    };
}

/*** --Viemo Helper-- ***/


/*** Youtube Helper ***/
var youtubeRegexp = /https?:\/\/(?:[0-9A-Z-]+\.)?(?:youtu\.be\/|youtube(?:-nocookie)?\.com\S*[^\w\s-])([\w-]{11})(?=[^\w-]|$)(?![?=&+%\w.-]*(?:['"][^<>]*>|<\/a>))[?=&+%\w.-]*/ig;
var youtubePlayerIds = {};
var youtubePlayers = [];

function onYouTubeIframeAPIReady() {
    $('iframe').each( function (k, v) {
        if( youtubeRegexp.test(this.src)){
            if (!this.id) { this.id='youtubevideoiframe' + k; }
            var id = this.id;
            if(!youtubePlayerIds[id]){ 
                youtubePlayerIds[id] = id;
                youtubePlayers.push(new YT.Player(id, {
                        events: {
                            'onStateChange': onYouTubeStateChange(id)
                        }
                    })
                );
            }
        }
    });
}


// Returns a function to enable events
function onYouTubeStateChange(identifier) {
    return function (event) {

        console.log('Youtube : : onYouTubeStateChange');
        console.log(identifier);
        console.log(event.data);
        var playerState;
        switch(event.data) {
            case YT.PlayerState.ENDED:
                playerState = 7;
                break;
            case YT.PlayerState.PLAYING:
                playerState = 5;
                break;
            case YT.PlayerState.PAUSED:
                playerState = 6;
                break;
            case YT.PlayerState.BUFFERING:
                break;
            case YT.PlayerState.CUED:
                break;
        }

        if(playerState) {
            var iframe = angular.element(document.getElementById(identifier));
            if(iframe){
                var iframeScope = iframe.scope();
                if(iframeScope) {
                    var currentTime = event.target.getCurrentTime();
                    iframeScope.videoStateChange(playerState, currentTime);
                }
            }
        }
    };
}
/*
(function() {
    // Load YouTube Frame API
    var tag = document.createElement('script');
    tag.src = "//www.youtube.com/iframe_api";
    var firstScriptTag = document.getElementsByTagName('script')[0];
    firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
})();*/
/*** --YouTube Helper-- ***/

/*** File Exists Check ***/
function fileExistsCheck(url, callback){
    try 
    {
        var http = new XMLHttpRequest();
        http.ontimeout = function () {
            callback(false);
        };
        http.onload = function() {
            if (http.readyState === 4) { 
                callback(false); //callback(http.status != 404);
            }
        };
        http.open("HEAD", url, true);
        http.timeout = 5000;
        http.send(null);
        
    } catch(ex) {
        console.log(ex);
    }
    
    return false;
}

/*** --File Exists Check-- ***/

/*** URL Accessible Check ***/
function urlAccessibleCheck( url , callback)
{
    var script = document.body.appendChild(document.createElement("script"));
    script.onload = function()
    {
        callback(true, url);
    };
    script.onerror = function()
    {
        callback(false, url);
    };
    script.src = url;//'https://docs.google.com/uc?authuser=0&id=0B8-E0EGP-JdMbGZRTlA3bDBzYzQ&export=download';
}

function urlAccessibleCheck_old(url, callback){
    try 
    {
        var http = new XMLHttpRequest();
        http.ontimeout = function () {
            callback(false, url);
        };
        http.onload = function() {
            if (http.readyState === 4) { 
                if (http.status === 200) {
                    callback(true, url);
                } else {
                    callback(false, url);
                }
            }
        };
        http.onreadystatechange = function() {
            if (this.readyState == this.DONE) {
                callback(this.status != 404);
            }
        };
        http.open("HEAD", url, true);
        http.timeout = 5000;
        http.send();
        
    } catch(ex) {
        console.log(ex);
    }
    
    return false;
}
/*** --URL Accessible Check-- ***/


/*** Get Random value between two numbers ***/
function randomIntFromInterval(min,max)
{
    return Math.floor(Math.random()*(max-min+1)+min);
}

/*** --Get Random value between two numbers-- ***/


/*** --Get Local IP Address-- ***/ 
function findIP(onNewIP) { //  onNewIp - your listener function for new IPs
    /*
    var promise = new Promise(function (resolve, reject) {
        try {
            var myPeerConnection = window.RTCPeerConnection || window.mozRTCPeerConnection || window.webkitRTCPeerConnection; //compatibility for firefox and chrome
            var pc = new myPeerConnection({ iceServers: [] }),
                noop = function () { },
                localIPs = {},
                ipRegex = /([0-9]{1,3}(\.[0-9]{1,3}){3}|[a-f0-9]{1,4}(:[a-f0-9]{1,4}){7})/g,
                key;
            function ipIterate(ip) {
                if (!localIPs[ip]) onNewIP(ip);
                localIPs[ip] = true;
            }
            pc.createDataChannel(""); //create a bogus data channel
            pc.createOffer(function (sdp) {
                sdp.sdp.split('\n').forEach(function (line) {
                    if (line.indexOf('candidate') < 0) return;
                    line.match(ipRegex).forEach(ipIterate);
                });
                pc.setLocalDescription(sdp, noop, noop);
            }, noop); // create offer and set local description

            pc.onicecandidate = function (ice) { //listen for candidate events
                if (ice && ice.candidate && ice.candidate.candidate && ice.candidate.candidate.match(ipRegex)) {
                    ice.candidate.candidate.match(ipRegex).forEach(ipIterate);
                }
                resolve("FindIPsDone");
                return;
            };
        }
        catch (ex) {
            reject(Error(ex));
        }
    });// New Promise(...{ ... });
    return promise;
    */
};

//This is the callback that gets run for each IP address found
function foundNewIP(ip) {
    if (typeof window.ipAddress === 'undefined')
    {
        window.ipAddress = ip;
    }
    else
    {
        window.ipAddress += " - " + ip;
    }
}

//This is How to use the Waitable findIP function, and react to the
//results arriving

//var ipWaitObject = findIP(foundNewIP);        // Puts found IP(s) in window.ipAddress

/*ipWaitObject.then(
    function (result) {
        alert ("IP(s) Found.  Result: '" + result + "'. You can use them now: " + window.ipAddress)
    },
    function (err) {
        alert ("IP(s) NOT Found.  FAILED!  " + err)
    }
);
*/
/*** --Get Local IP Address End-- ***/

 
/**
 * detect IE
 * returns version of IE or false, if browser is not Internet Explorer
 */
function detectIE() {
  var ua = window.navigator.userAgent;

  // Test values; Uncomment to check result …

  // IE 10
  // ua = 'Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; Trident/6.0)';
  
  // IE 11
  // ua = 'Mozilla/5.0 (Windows NT 6.3; Trident/7.0; rv:11.0) like Gecko';
  
  // Edge 12 (Spartan)
  // ua = 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36 Edge/12.0';
  
  // Edge 13
  // ua = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2486.0 Safari/537.36 Edge/13.10586';

  var msie = ua.indexOf('MSIE ');
  if (msie > 0) {
    // IE 10 or older => return version number
    return parseInt(ua.substring(msie + 5, ua.indexOf('.', msie)), 10);
  }

  var trident = ua.indexOf('Trident/');
  if (trident > 0) {
    // IE 11 => return version number
    var rv = ua.indexOf('rv:');
    return parseInt(ua.substring(rv + 3, ua.indexOf('.', rv)), 10);
  }

  var edge = ua.indexOf('Edge/');
  if (edge > 0) {
    // Edge (IE 12+) => return version number
    return parseInt(ua.substring(edge + 5, ua.indexOf('.', edge)), 10);
  }

  // other browser
  return false;
}