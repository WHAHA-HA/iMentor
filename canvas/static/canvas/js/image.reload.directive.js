(function () {
    'use strict';

   
    angular.module('imImageReload', [])
      
    /**
     * Image tag override to reload image on error.
    **/
    .directive('img', ['$timeout', function ($timeout)  {
         return {
            restrict: 'E',
            link: function (scope, element, attr) {
                // Listen for errors on the element and if there are any, reload image with new cache busting url
                var errorHanlder = function () {
                    $timeout(function () {
                        var retries = 0;
                        var original_src;

                        if (!angular.isDefined(element[0].original_src)) {
                            element[0].original_src = element[0].src;
                            original_src = element[0].src;
                        } else {
                            original_src = element[0].original_src;
                            retries = element[0].retries;
                        }

                        if (original_src && !original_src.match(/^data/)  && retries<2 ) {
                            var random =  Math.round(Math.random() * 999999);
                            var newSrc = original_src + "?cachebuster=" + random;
                            element[0].src = newSrc;
                            retries = retries + 1;
                            element[0].retries = retries;
                        } else {
                            element.off('error', errorHanlder);
                        }
                    }, 2000);
                };
                element.on('error', errorHanlder);
            }
        };
    }])

    /**
     * Reload image on error.
    **/
    .directive('imageReload', ['$timeout', function ($timeout)  {
         return {
            restrict: 'A',
            link: function (scope, element, attr) {
                var ele = $(element[0]);
                var allImgs = [];

                // CSS properties which may contain an image.
                var hasImgProperties = [
                    'backgroundImage',
                    'listStyleImage'//,
                    //'borderImage',
                    //'borderCornerImage',
                    //'cursor'
                ];
                // Element attributes which may contain an image.
                var hasImageAttributes =  ['srcset'];
                // To match `url()` references.
                // Spec: http://www.w3.org/TR/CSS2/syndata.html#value-def-uri
                var matchUrl = /url\(\s*(['"]?)(.*?)\1\s*\)/g;

                // Custom selector to find all `img` elements with a valid `src` attribute.
                $.expr[':']['has-src'] = function (obj) {
                    // Ensure we are dealing with an `img` element with a valid
                    // `src` attribute.
                    return $(obj).is('img[src][src!=""]');
                };

                // If an `img` element, add it. But keep iterating in
                // case it has a background image too.
                 if (element.is('img:has-src')) {
                    allImgs.push({
                        src: element.attr('src'),
                        element: element[0]
                    });
                } else if(element.is('img') && attr.ngSrc){
                    allImgs.push({
                        src: attr.ngSrc,
                        element: element[0]
                    });
                }

                $.each(hasImgProperties, function (i, property) {
                    var propertyValue = element.css(property);
                    var match;

                    // If it doesn't contain this property, skip.
                    if (!propertyValue || propertyValue.toLowerCase() == 'none' ) {
                        return true;
                    }

                    // Get all url() of this element.
                    while (match == matchUrl.exec(propertyValue)) {
                        if(match){
                            allImgs.push({
                                src: match[2],
                                element: element[0],
                                property: property
                            });
                        }
                    }
                });

                $.each(hasImageAttributes, function (i, attribute) {
                    var attributeValue = element.attr(attribute);
                    var attributeValues;

                    // If it doesn't contain this property, skip.
                    if (!attributeValue) {
                        return true;
                    }

                    // Check for multiple comma separated images
                    attributeValues = attributeValue.split(',');

                    $.each(attributeValues, function(i, value) {
                        // Trim value and get string before first
                        // whitespace (for use with srcset).
                        value = $.trim(value).split(' ')[0];
                        allImgs.push({
                            src: value,
                            element: element[0],
                            attribute: attribute
                        });
                    });
                });

                $.each(allImgs, function (i, img) {

                    var image = new Image();
                    var events = 'error';

                    
                    // Handle the image loading and error with the same callback.
                    //$(image).on('error', errorHanlder);
                    $(image).one(events, function me (event) {
                        errorHanlder(image ,img);
                    });
                    image.src = img.src;
                });

                // Listen for errors on the element and if there are any, reload image with new cache busting url
                var errorHanlder = function (image, img) {
                    $timeout(function () {
                        var retries = 0;
                        if (angular.isDefined(attr.retries)) {
                            retries = element.retries;
                        }

                        if (img.src && !img.src.match(/^data/)  && retries<3 ) {
                            var random =  Math.round(Math.random() * 999999);
                            var newSrc = img.src + "?cachebuster=" + random;
                            if(angular.isDefined(img.property)){
                                 element.css(img.property,' url(' + newSrc + ')');
                            } else if(angular.isDefined(img.attribute)){
                                 element.attr(img.attribute, newSrc );
                            } else {
                                 element.src = newSrc;
                            }
                            image.src = newSrc;
                            retries = retries + 1;
                            element.retries = retries;
                        } else {
                            element.off('error', errorHanlder);
                        }
                    }, 2000);
                };

            }
        };
    }]);

})();