(function () {
    'use strict';

    var serviceId = 'gridsterBuilder';

    angular.module('canvas')
        .factory(serviceId, ['$http', 'config','common', gridsterBuilder]);

    function gridsterBuilder($http, config, common) {
        var $q = common.$q;
        var getLogFn = common.logger.getLogFn;
        var log = getLogFn(serviceId);

        var service = {
            getWidgetPosition: getWidgetPosition,
            getGridsterOptions: getGridsterOptions,
            getWidgetOrder: getWidgetOrder,
            setOrder: setOrder
        };

        return service;
        
        function setOrder(widgets){
            if(widgets !== undefined) {
               
                widgets = widgets.sort(function(a,b) { return a.ordinal - b.ordinal;} );
                for (var i = 0; i < widgets.length; i++) {
                    widgets[i].ordinal = i + 1;
                }
            }
            return widgets;
        }

        function getWidgetOrder(widgets) {
            if(widgets !== undefined) {

                widgets = _(widgets).chain()
                          .sortBy('col')
                          .sortBy('row')
                          .value();
                for (var x = 0; x < widgets.length; x ++) {
                    widgets[x].ordinal = x + 1 ;
                }
            }
            
            return widgets;
        }

        function getWidgetPosition(widgets) {
            if(widgets !== undefined) {
                widgets = setOrder(widgets);

                var row = 0;
                var col = 0;
                
                var lastRowHeight = 0;
                var lastWidgetWidth = 0;
                var lastWidgetCol = 0;

                for (var x = 0; x < widgets.length; x ++) {
                    
                    widgets[x].width = widgets[x].width || 12;
                    widgets[x].height = widgets[x].height || 6;

                    widgets[x].sizeX = 1 * widgets[x].width; 
                    widgets[x].sizeY = "auto"; // widgets[x].height === "auto" ? widgets[x].height : 1 * widgets[x].height;

                    if(widgets[x].width === 1 && x !== 0 && lastWidgetWidth !== 2){
                       col = lastWidgetCol === 0  ? 1 : 0;
                    } else {
                       col = 0;
                    }

                    row = col === 0 && x !== 0 ? row + lastRowHeight : row;

                    widgets[x].row = row;
                    widgets[x].col = col;
                    lastWidgetCol = col;

                    lastRowHeight = widgets[x].width === 1 && 
                    col === 1 && 
                    lastRowHeight > widgets[x].height ? lastRowHeight : widgets[x].height;
                    lastWidgetWidth = widgets[x].width;
                }
            }

            return widgets;
          
        }

        function getGridsterOptions(canvasConfig) {

            var gridsterOptions = {
                columns: 12, // number of columns in the grid //canvasConfig.stacked === true ? 1 : 2 
                pushing: true, // whether to push other items out of the way
                floating: true, // whether to automatically float items up so they stack
                swapping: false, // whether or not to have 
                                 //items switch places instead of push down if they are the same size
                width: 'auto',  // width of the grid. "auto" 
                                //will expand the grid to its parent container
                colWidth: 'auto', // width of grid columns. 
                                    //"auto" will divide the width of the grid evenly among the columns
                rowHeight: 'match', // height of grid rows. 
                                    //'match' will make it the same as the column width, 
                                    //a numeric value will be interpreted as pixels, '/2' is half the column width, 
                                    //'*5' is five times the column width, etc.
                margins: [0, 0], // margins in between grid items
                outerMargin: true,
                isMobile: false, // toggle mobile view
                mobileBreakPoint: 600, // width threshold to toggle mobile mode
                mobileModeEnabled: true, // whether or not to toggle mobile mode 
                                        //when screen width is less than mobileBreakPoint
                minColumns: 1, // minimum amount of columns the grid can scale down to
                minRows: 4, // minimum amount of rows to show if the grid is empty
                maxRows: 1000, // maximum amount of rows in the grid
                defaultSizeX: 2, // default width of an item in columns
                defaultSizeY: 2, // default height of an item in rows
                minSizeX: 1, // minimum column width of an item
                maxSizeX: null, // maximum column width of an item
                minSizeY: 1, // minumum row height of an item
                maxSizeY: null, // maximum row height of an item
                saveGridItemCalculatedHeightInMobile: false, // grid item height in mobile display. 
                                                             //true- to use the calculated height by sizeY given
                resizable: { // options to pass to resizable handler
                    enabled: false,
                    handles: ['s', 'e', 'n', 'w', 'se', 'ne', 'sw', 'nw']
                },
                draggable: { // options to pass to draggable handler
                    enabled: canvasConfig.draggable || false,
                    scrollSensitivity: 20, // Distance in pixels from the edge of the viewport
                                          // after which the viewport should scroll, relative to pointer
                    scrollSpeed: 15 // Speed at which the window should scroll once 
                                    //the mouse pointer gets within scrollSensitivity distance
                }
            };

            return gridsterOptions;
        }

    }
})();