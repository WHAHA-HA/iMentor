/*
 @license textAngular
 Author : Austin Anderson
 License : 2013 MIT
 Version 1.3.7

 See README.md or https://github.com/fraywing/textAngular/wiki for requirements and use.
 */
//var textAngular = angular.module("textAngular", ['ngSanitize', 'colorpicker.module', 'ui.bootstrap.dropdownToggle']); //This makes ngSanitize required

//angular.module('textAngularSetup', ['ngSanitize', 'colorpicker.module', 'ui.bootstrap.dropdownToggle','imImageSelector','imEmbed', 'imUpload'])  // Full fledged with custom image load etc built for canvas but not used 
angular.module("textAngular", ['ngSanitize', 'colorpicker.module', 'ui.bootstrap.dropdownToggle']) 

// Here we set up the global display defaults, to set your own use a angular $provider#decorator.
.value('taOptions',  {
  toolbar: [
    ['bold', 'italics', 'underline', 'h5','h3','h1', 'insertLink', 'fontName'],

  ],
  classes: {
    focussed: "focussed",
    toolbar: "text-toolbar",
    toolbarGroup: "btn-group angularTextbar",
    toolbarButton: "btn btn-default",
    toolbarButtonActive: "active",
    disabled: "disabled",
    textEditor: 'form-control',
    htmlEditor: 'form-control'
  },
  setup: {
    // wysiwyg mode
    textEditorSetup: function($element){ /* Do some processing here */ },
    // raw html
    htmlEditorSetup: function($element){ /* Do some processing here */ }
  },
  defaultFileDropHandler:
  /* istanbul ignore next: untestable image processing */
  function(file, insertAction){
    var reader = new FileReader();
    if(file.type.substring(0, 5) === 'image'){
      reader.onload = function() {
        if(reader.result !== '') insertAction('insertImage', reader.result, true);
      };

      reader.readAsDataURL(file);
      // NOTE: For async procedures return a promise and resolve it when the editor should update the model.
      return true;
    }
    return false;
  }
})

// This is the element selector string that is used to catch click events within a taBind, prevents the default and $emits a 'ta-element-select' event
// these are individually used in an angular.element().find() call. What can go here depends on whether you have full jQuery loaded or just jQLite with angularjs.
// div is only used as div.ta-insert-video caught in filter.
.value('taSelectableElements', ['a','img'])

// This is an array of objects with the following options:
//				selector: <string> a jqLite or jQuery selector string
//				customAttribute: <string> an attribute to search for
//				renderLogic: <function(element)>
// Both or one of selector and customAttribute must be defined.
.value('taCustomRenderers', [
  {
    // Parse back out: '<div class="ta-insert-video" ta-insert-video src="' + urlLink + '" allowfullscreen="true" width="300" frameborder="0" height="250"></div>'
    // To correct video element. For now only support youtube
    selector: 'img',
    customAttribute: 'ta-insert-video',
    renderLogic: function(element){
      var iframe = angular.element('<iframe></iframe>');
      var attributes = element.prop("attributes");
      // loop through element attributes and apply them on iframe
      angular.forEach(attributes, function(attr) {
        iframe.attr(attr.name, attr.value);
      });
      iframe.attr('src', iframe.attr('ta-insert-video'));
      element.replaceWith(iframe);
    }

  }
])

.value('taTranslations', {
  // moved to sub-elements
  //toggleHTML: "Toggle HTML",
  //insertImage: "Please enter a image URL to insert",
  //insertLink: "Please enter a URL to insert",
  //insertVideo: "Please enter a youtube URL to embed",
  html: {
    tooltip: 'Toggle html / Rich Text'
  },
  // tooltip for heading - might be worth splitting
  heading: {
    tooltip: 'Large'
  },
  p: {
    tooltip: 'Paragraph'
  },
  pre: {
    tooltip: 'Preformatted text'
  },
  ul: {
    tooltip: 'Unordered List'
  },
  ol: {
    tooltip: 'Ordered List'
  },
  quote: {
    tooltip: 'Quote/unquote selection or paragraph'
  },
  undo: {
    tooltip: 'Undo'
  },
  redo: {
    tooltip: 'Redo'
  },
  bold: {
    tooltip: 'Bold'
  },
  italic: {
    tooltip: 'Italic'
  },
  underline: {
    tooltip: 'Underline'
  },
  strikeThrough:{
    tooltip: 'Strikethrough'
  },
  justifyLeft: {
    tooltip: 'Align text left'
  },
  justifyRight: {
    tooltip: 'Align text right'
  },
  justifyCenter: {
    tooltip: 'Center'
  },
  indent: {
    tooltip: 'Increase indent'
  },
  outdent: {
    tooltip: 'Decrease indent'
  },
  clear: {
    tooltip: 'Clear formatting'
  },
  insertImage: {
    dialogPrompt: 'Please enter an image URL to insert',
    tooltip: 'Insert image',
    hotkey: 'the - possibly language dependent hotkey ... for some future implementation'
  },
  insertVideo: {
    tooltip: 'Insert video',
    dialogPrompt: 'Please enter a youtube URL to embed'
  },
  insertLink: {
    tooltip: 'Link',
    dialogPrompt: "Enter your link below:"
  },
  editLink: {
    reLinkButton: {
      tooltip: "Relink"
    },
    unLinkButton: {
      tooltip: "Unlink"
    },
    targetToggle: {
      buttontext: "Open link in a new window"
    }
  },
  wordcount: {
    tooltip: 'Display words Count'
  },
  wordcountAlternative: {
    tooltip: 'Display words Count'
  },
  charcount: {
    tooltip: 'Display characters Count'
  }
})
.run(['taRegisterTool', '$window', 'taTranslations', 'taSelection', 'taCustomRenderers','imImages','imEmbedService','imUploadService', '$sanitize', function(taRegisterTool, $window, taTranslations, taSelection, taCustomRenderers,imImages,imEmbedService, imUploadService, $sanitize){
  taRegisterTool("html", {
    iconclass: 'fa fa-code',
    tooltiptext: taTranslations.html.tooltip,
    action: function(){
      this.$editor().switchView();
    },
    activeState: function(){
      return this.$editor().showHtml;
    }
  });
  // add the Header tools
  // convenience functions so that the loop works correctly
  var _retActiveStateFunction = function(q){
    return function(){ return this.$editor().queryFormatBlockState(q); };
  };
  var headerAction = function(){
    return this.$editor().wrapSelection("formatBlock", "<" + this.name.toUpperCase() +">");
  };
  var headerPick = function(h){
    if(h === "h1"){
      return "Largest";
    }else if(h == "h3"){
      return "Larger";
    }
    else{
      return "Large";
    }
  };
  angular.forEach(['h1','h2','h3','h4','h5','h6'], function(h){
    taRegisterTool(h.toLowerCase(), {
      buttontext: headerPick(h),
      tooltiptext: headerPick(h) + " text",
      action: headerAction,
      activeState: _retActiveStateFunction(h.toLowerCase())
    });
  });
  taRegisterTool('p', {
    buttontext: 'P',
    tooltiptext: taTranslations.p.tooltip,
    action: function(){
      return this.$editor().wrapSelection("formatBlock", "<P>");
    },
    activeState: function(){ return this.$editor().queryFormatBlockState('p'); }
  });
  taRegisterTool('fontColor', {
    display: "<span class='bar-btn-dropdown'><button type='button' colorpicker colorpicker-text-editor='true' colorpicker-parent='true' class='btn btn-default' ng-disabled='showHtml()'> <i class='fa fa-magic'></i><i class='fa fa-caret-down'></i></button></span>",
    action: function(color) {
      if (color !== '') {
        return this.$editor().wrapSelection('foreColor', color);
      }
    }
  });
  taRegisterTool('backgroundColor', {
    display: "<span class='bar-btn-dropdown'><button type='button' colorpicker colorpicker-text-editor='true' colorpicker-parent='true' class='btn btn-default' ng-disabled='showHtml()'> <i class='fa fa-magic'></i><i class='fa fa-caret-down'></i></button></span>",
    action: function(color) {
      if (color !== '') {
        return this.$editor().wrapSelection('backColor', color);
      }
    }
  });
  // key: pre -> taTranslations[key].tooltip, taTranslations[key].buttontext
  taRegisterTool('pre', {
    buttontext: 'pre',
    tooltiptext: taTranslations.pre.tooltip,
    action: function(){
      return this.$editor().wrapSelection("formatBlock", "<PRE>");
    },
    activeState: function(){ return this.$editor().queryFormatBlockState('pre'); }
  });
  taRegisterTool('ul', {
    iconclass: 'fa fa-list-ul',
    tooltiptext: taTranslations.ul.tooltip,
    action: function(){
      return this.$editor().wrapSelection("insertUnorderedList", null);
    },
    activeState: function(){ return this.$editor().queryCommandState('insertUnorderedList'); }
  });
  taRegisterTool('ol', {
    iconclass: 'fa fa-list-ol',
    tooltiptext: taTranslations.ol.tooltip,
    action: function(){
      return this.$editor().wrapSelection("insertOrderedList", null);
    },
    activeState: function(){ return this.$editor().queryCommandState('insertOrderedList'); }
  });
  taRegisterTool('quote', {
    iconclass: 'fa fa-quote-right',
    tooltiptext: taTranslations.quote.tooltip,
    action: function(){
      return this.$editor().wrapSelection("formatBlock", "<BLOCKQUOTE>");
    },
    activeState: function(){ return this.$editor().queryFormatBlockState('blockquote'); }
  });
  taRegisterTool('undo', {
    iconclass: 'fa fa-undo',
    tooltiptext: taTranslations.undo.tooltip,
    action: function(){
      return this.$editor().wrapSelection("undo", null);
    }
  });
  taRegisterTool('redo', {
    iconclass: 'fa fa-repeat',
    tooltiptext: taTranslations.redo.tooltip,
    action: function(){
      return this.$editor().wrapSelection("redo", null);
    }
  });
  taRegisterTool('bold', {
    iconclass: 'fa fa-bold',
    tooltiptext: taTranslations.bold.tooltip,
    action: function(){
      return this.$editor().wrapSelection("bold", null);
    },
    activeState: function(){
      return this.$editor().queryCommandState('bold');
    },
    commandKeyCode: 98
  });
  taRegisterTool('justifyLeft', {
    iconclass: 'fa fa-align-left',
    tooltiptext: taTranslations.justifyLeft.tooltip,
    action: function(){
      return this.$editor().wrapSelection("justifyLeft", null);
    },
    activeState: function(commonElement){
      var result = false;
      if(commonElement) result =
      commonElement.css('text-align') === 'left' ||
      commonElement.attr('align') === 'left' ||
      (
      commonElement.css('text-align') !== 'right' &&
      commonElement.css('text-align') !== 'center' &&
      commonElement.css('text-align') !== 'justify' &&
      !this.$editor().queryCommandState('justifyRight') &&
      !this.$editor().queryCommandState('justifyCenter')
      ) && !this.$editor().queryCommandState('justifyFull');
      result = result || this.$editor().queryCommandState('justifyLeft');
      return result;
    }
  });
  taRegisterTool('justifyRight', {
    iconclass: 'fa fa-align-right',
    tooltiptext: taTranslations.justifyRight.tooltip,
    action: function(){
      return this.$editor().wrapSelection("justifyRight", null);
    },
    activeState: function(commonElement){
      var result = false;
      if(commonElement) result = commonElement.css('text-align') === 'right';
      result = result || this.$editor().queryCommandState('justifyRight');
      return result;
    }
  });
  taRegisterTool('justifyCenter', {
    iconclass: 'fa fa-align-center',
    tooltiptext: taTranslations.justifyCenter.tooltip,
    action: function(){
      return this.$editor().wrapSelection("justifyCenter", null);
    },
    activeState: function(commonElement){
      var result = false;
      if(commonElement) result = commonElement.css('text-align') === 'center';
      result = result || this.$editor().queryCommandState('justifyCenter');
      return result;
    }
  });
  taRegisterTool('indent', {
    iconclass: 'fa fa-indent',
    tooltiptext: taTranslations.indent.tooltip,
    action: function(){
      return this.$editor().wrapSelection("indent", null);
    },
    activeState: function(){
      return this.$editor().queryFormatBlockState('blockquote');
    }
  });
  taRegisterTool('outdent', {
    iconclass: 'fa fa-outdent',
    tooltiptext: taTranslations.outdent.tooltip,
    action: function(){
      return this.$editor().wrapSelection("outdent", null);
    },
    activeState: function(){
      return false;
    }
  });
  taRegisterTool('italics', {
    iconclass: 'fa fa-italic',
    tooltiptext: taTranslations.italic.tooltip,
    action: function(){
      return this.$editor().wrapSelection("italic", null);
    },
    activeState: function(){
      return this.$editor().queryCommandState('italic');
    },
    commandKeyCode: 105
  });
  taRegisterTool('underline', {
    iconclass: 'fa fa-underline',
    tooltiptext: taTranslations.underline.tooltip,
    action: function(){
      return this.$editor().wrapSelection("underline", null);
    },
    activeState: function(){
      return this.$editor().queryCommandState('underline');
    },
    commandKeyCode: 117
  });
  taRegisterTool('strikeThrough', {
    iconclass: 'fa fa-strikethrough',
    tooltiptext: taTranslations.strikeThrough.tooltip,
    action: function(){
      return this.$editor().wrapSelection("strikeThrough", null);
    },
    activeState: function(){
      return document.queryCommandState('strikeThrough');
    }
  });
  taRegisterTool('clear', {
    iconclass: 'fa fa-ban',
    tooltiptext: taTranslations.clear.tooltip,
    action: function(deferred, restoreSelection){
      var i;
      this.$editor().wrapSelection("removeFormat", null);
      var possibleNodes = angular.element(taSelection.getSelectionElement());
      // remove lists
      var removeListElements = function(list){
        list = angular.element(list);
        var prevElement = list;
        angular.forEach(list.children(), function(liElem){
          var newElem = angular.element('<p></p>');
          newElem.html(angular.element(liElem).html());
          prevElement.after(newElem);
          prevElement = newElem;
        });
        list.remove();
      };
      angular.forEach(possibleNodes.find("ul"), removeListElements);
      angular.forEach(possibleNodes.find("ol"), removeListElements);
      if(possibleNodes[0].tagName.toLowerCase() === 'li'){
        var _list = possibleNodes[0].parentNode.childNodes;
        var _preLis = [], _postLis = [], _found = false;
        for(i = 0; i < _list.length; i++){
          if(_list[i] === possibleNodes[0]){
            _found = true;
          }else if(!_found) _preLis.push(_list[i]);
          else _postLis.push(_list[i]);
        }
        var _parent = angular.element(possibleNodes[0].parentNode);
        var newElem = angular.element('<p></p>');
        newElem.html(angular.element(possibleNodes[0]).html());
        if(_preLis.length === 0 || _postLis.length === 0){
          if(_postLis.length === 0) _parent.after(newElem);
          else _parent[0].parentNode.insertBefore(newElem[0], _parent[0]);

          if(_preLis.length === 0 && _postLis.length === 0) _parent.remove();
          else angular.element(possibleNodes[0]).remove();
        }else{
          var _firstList = angular.element('<'+_parent[0].tagName+'></'+_parent[0].tagName+'>');
          var _secondList = angular.element('<'+_parent[0].tagName+'></'+_parent[0].tagName+'>');
          for(i = 0; i < _preLis.length; i++) _firstList.append(angular.element(_preLis[i]));
          for(i = 0; i < _postLis.length; i++) _secondList.append(angular.element(_postLis[i]));
          _parent.after(_secondList);
          _parent.after(newElem);
          _parent.after(_firstList);
          _parent.remove();
        }
        taSelection.setSelectionToElementEnd(newElem[0]);
      }
      // clear out all class attributes. These do not seem to be cleared via removeFormat
      var $editor = this.$editor();
      var recursiveRemoveClass = function(node){
        node = angular.element(node);
        if(node[0] !== $editor.displayElements.text[0]) node.removeAttr('class');
        angular.forEach(node.children(), recursiveRemoveClass);
      };
      angular.forEach(possibleNodes, recursiveRemoveClass);
      // check if in list. If not in list then use formatBlock option
      if(possibleNodes[0].tagName.toLowerCase() !== 'li' &&
      possibleNodes[0].tagName.toLowerCase() !== 'ol' &&
      possibleNodes[0].tagName.toLowerCase() !== 'ul') this.$editor().wrapSelection("formatBlock", "default");
      restoreSelection();
    }
  });

  var imgOnSelectAction = function(event, $element, editorScope){
    // setup the editor toolbar
    // Credit to the work at http://hackerwins.github.io/summernote/ for this editbar logic/display
    var finishEdit = function(){
      editorScope.updateTaBindtaTextElement();
      editorScope.hidePopover();
    };
    event.preventDefault();
    editorScope.displayElements.popover.css('width', '375px');
    var container = editorScope.displayElements.popoverContainer;
    container.empty();
    var buttonGroup = angular.element('<div class="btn-group" style="padding-right: 6px;">');
    var fullButton = angular.element('<button type="button" class="btn btn-default btn-sm btn-small" unselectable="on">100% </button>');
    fullButton.on('click', function(event){
      event.preventDefault();
      $element.css({
        'width': '100%',
        'height': ''
      });
      finishEdit();
    });
    var halfButton = angular.element('<button type="button" class="btn btn-default btn-sm btn-small" unselectable="on">50% </button>');
    halfButton.on('click', function(event){
      event.preventDefault();
      $element.css({
        'width': '50%',
        'height': ''
      });
      finishEdit();
    });
    var quartButton = angular.element('<button type="button" class="btn btn-default btn-sm btn-small" unselectable="on">25% </button>');
    quartButton.on('click', function(event){
      event.preventDefault();
      $element.css({
        'width': '25%',
        'height': ''
      });
      finishEdit();
    });
    var resetButton = angular.element('<button type="button" class="btn btn-default btn-sm btn-small" unselectable="on">Reset</button>');
    resetButton.on('click', function(event){
      event.preventDefault();
      $element.css({
        width: '',
        height: ''
      });
      finishEdit();
    });
    buttonGroup.append(fullButton);
    buttonGroup.append(halfButton);
    buttonGroup.append(quartButton);
    buttonGroup.append(resetButton);
    container.append(buttonGroup);

    buttonGroup = angular.element('<div class="btn-group" style="padding-right: 6px;">');
    var floatLeft = angular.element('<button type="button" class="btn btn-default btn-sm btn-small" unselectable="on"><i class="fa fa-align-left"></i></button>');
    floatLeft.on('click', function(event){
      event.preventDefault();
      // webkit
      $element.css('float', 'left');
      // firefox
      $element.css('cssFloat', 'left');
      // IE < 8
      $element.css('styleFloat', 'left');
      finishEdit();
    });
    var floatRight = angular.element('<button type="button" class="btn btn-default btn-sm btn-small" unselectable="on"><i class="fa fa-align-right"></i></button>');
    floatRight.on('click', function(event){
      event.preventDefault();
      // webkit
      $element.css('float', 'right');
      // firefox
      $element.css('cssFloat', 'right');
      // IE < 8
      $element.css('styleFloat', 'right');
      finishEdit();
    });
    var floatNone = angular.element('<button type="button" class="btn btn-default btn-sm btn-small" unselectable="on"><i class="fa fa-align-justify"></i></button>');
    floatNone.on('click', function(event){
      event.preventDefault();
      // webkit
      $element.css('float', '');
      // firefox
      $element.css('cssFloat', '');
      // IE < 8
      $element.css('styleFloat', '');
      finishEdit();
    });
    buttonGroup.append(floatLeft);
    buttonGroup.append(floatNone);
    buttonGroup.append(floatRight);
    container.append(buttonGroup);

    buttonGroup = angular.element('<div class="btn-group">');
    var remove = angular.element('<button type="button" class="btn btn-default btn-sm btn-small" unselectable="on"><i class="fa fa-trash-o"></i></button>');
    remove.on('click', function(event){
      event.preventDefault();
      $element.remove();
      finishEdit();
    });
    buttonGroup.append(remove);
    container.append(buttonGroup);

    editorScope.showPopover($element);
    editorScope.showResizeOverlay($element);
  };

  taRegisterTool('insertImage1', {
    iconclass: 'fa fa-picture-o',
    tooltiptext: taTranslations.insertImage.tooltip,
    action: function(){
      var imageLink;
      imageLink = $window.prompt(taTranslations.insertImage.dialogPrompt, 'http://');
      if(imageLink && imageLink !== '' && imageLink !== 'http://'){
        return this.$editor().wrapSelection('insertImage', imageLink, true);
      }
    },
    onElementSelect: {
      element: 'img',
      action: imgOnSelectAction
    }
  });
  taRegisterTool('insertVideo', {
    iconclass: 'fa fa-youtube-play',
    tooltiptext: taTranslations.insertVideo.tooltip,
    action: function(deferred, restoreSelection){
      var urlPrompt;
      urlPrompt = $window.prompt(taTranslations.insertVideo.dialogPrompt, 'https://');
      if (urlPrompt && urlPrompt !== '' && urlPrompt !== 'https://') {
        // get the video ID
        var ids = urlPrompt.match(/(\?|&)v=[^&]*/);
        /* istanbul ignore else: if it's invalid don't worry - though probably should show some kind of error message */
        if(ids && ids.length > 0){
          // create the embed link
          var urlLink = "https://www.youtube.com/embed/" + ids[0].substring(3);
          // create the HTML
          // for all options see: http://stackoverflow.com/questions/2068344/how-do-i-get-a-youtube-video-thumbnail-from-the-youtube-api
          // maxresdefault.jpg seems to be undefined on some.
          //var embed = '<img class="ta-insert-video" src="https://img.youtube.com/vi/' + ids[0].substring(3) + '/mqdefault.jpg" ta-insert-video="' + urlLink + '" contenteditable="false" src="" allowfullscreen="true" frameborder="0" />';
          var embed = '<iframe  src="https://www.youtube.com/embed/' + ids[0].substring(3) + '" ta-insert-video="https://www.youtube.com/embed/' +  ids[0].substring(3) + '" contenteditable="false" allowfullscreen="true" frameborder="0"></iframe>';
          // insert
          this.$editor().wrapSelection('insertHTML', embed, true);
          restoreSelection();
          return this.$editor().wrapSelection('insertHTML', '<span> &nbsp;</span>', true);
        } 
      }
    },
    onElementSelect: {
      element: 'img',
      onlyWithAttrs: ['ta-insert-video'],
      action: imgOnSelectAction
    }
  });
  taRegisterTool('insertLink', {
    tooltiptext: taTranslations.insertLink.tooltip,
    iconclass: 'fa fa-link',
    action: function(){
      var urlLink;
      urlLink = $window.prompt(taTranslations.insertLink.dialogPrompt, 'http://');
      if(urlLink && urlLink !== '' && urlLink !== 'http://'){
          urlLink = $sanitize(urlLink);
          return this.$editor().wrapSelection('createLink', urlLink, true);
      }
    },
    activeState: function(commonElement){
      if(commonElement) return commonElement[0].tagName === 'A';
      return false;
    },
    onElementSelect: {
      element: 'a',
      action: function(event, $element, editorScope){
        // setup the editor toolbar
        // Credit to the work at http://hackerwins.github.io/summernote/ for this editbar logic
        event.preventDefault();
        editorScope.displayElements.popover.css('width', '436px');
        var container = editorScope.displayElements.popoverContainer;
        container.empty();
        container.css('line-height', '28px');
        var link = angular.element('<a href="' + $element.attr('href') + '" target="_blank">' + $element.attr('href') + '</a>');
        link.css({
          'display': 'inline-block',
          'max-width': '200px',
          'overflow': 'hidden',
          'text-overflow': 'ellipsis',
          'white-space': 'nowrap',
          'vertical-align': 'middle'
        });
        container.append(link);
        var buttonGroup = angular.element('<div class="btn-group pull-right">');
        var reLinkButton = angular.element('<button type="button" class="btn btn-default btn-sm btn-small" unselectable="on" title="' + taTranslations.editLink.reLinkButton.tooltip + '"><i class="fa fa-edit icon-edit"></i></button>');
        reLinkButton.on('click', function(event){
          event.preventDefault();
          var urlLink = $window.prompt(taTranslations.insertLink.dialogPrompt, $element.attr('href'));
          if(urlLink && urlLink !== '' && urlLink !== 'http://'){
            $element.attr('href', urlLink);
            editorScope.updateTaBindtaTextElement();
          }
          editorScope.hidePopover();
        });
        buttonGroup.append(reLinkButton);
        var unLinkButton = angular.element('<button type="button" class="btn btn-default btn-sm btn-small" unselectable="on" title="' + taTranslations.editLink.unLinkButton.tooltip + '"><i class="fa fa-unlink icon-unlink"></i></button>');
        // directly before this click event is fired a digest is fired off whereby the reference to $element is orphaned off
        unLinkButton.on('click', function(event){
          event.preventDefault();
          $element.replaceWith($element.contents());
          editorScope.updateTaBindtaTextElement();
          editorScope.hidePopover();
        });
        buttonGroup.append(unLinkButton);
        var targetToggle = angular.element('<button type="button" class="btn btn-default btn-sm btn-small" unselectable="on">' + taTranslations.editLink.targetToggle.buttontext + '</button>');
        if($element.attr('target') === '_blank'){
          targetToggle.addClass('active');
        }
        targetToggle.on('click', function(event){
          event.preventDefault();
          $element.attr('target', ($element.attr('target') === '_blank') ? '' : '_blank');
          targetToggle.toggleClass('active');
          editorScope.updateTaBindtaTextElement();
        });
        buttonGroup.append(targetToggle);
        container.append(buttonGroup);
        editorScope.showPopover($element);
      }
    }
  });
  taRegisterTool('embedLink', {
    tooltiptext: 'insert/edit resource',
    iconclass: 'fa fa-file',
    action: function(){
      var urlLink;
      urlLink = $window.prompt(taTranslations.insertLink.dialogPrompt, 'http://');
      if(urlLink) {urlLink = urlLink.trim(); }
      if(urlLink && urlLink !== '' && urlLink !== 'http://'){
        if(urlLink.indexOf('<iframe')===0){
          var res = encodeURI(urlLink);
          var iframe = angular.element(urlLink)[0];
          var src = iframe.src;
          if(src){
            src = src.split('?')[0]
            embed = '<a href="' + res + '" target="_blank" ta-embed=" ">' + src + '</a>';
          }
        } else {
          var url = urlLink.replace(/#[^#]*$/, "").replace(/\?[^\?]*$/, "");
          var urlPath = url.substring(url.lastIndexOf('/')+1);
          var regex = /(?:\.([^.]+))?$/;
          var ext = regex.exec(urlPath)[1];
          var embed ='';
          if(typeof ext !== 'undefined'){
            embed = '<a href="' + urlLink + '" target="_blank" ta-embed="' + ext + '">' + urlLink + '</a>';
          } else {
            embed = '<a href="' + urlLink + '" target="_blank" ta-embed=" ">' + urlLink + '</a>';
          } 
          //return this.$editor().wrapSelection('createLink', urlLink, true);
        }
        return this.$editor().wrapSelection('insertHTML', embed, true);
      }
    },
    activeState: function(commonElement){
      if(commonElement) return commonElement[0].tagName === 'A';
      return false;
    },
    onElementSelect: {
      element: 'a',
      action: function(event, $element, editorScope){
        // setup the editor toolbar
        // Credit to the work at http://hackerwins.github.io/summernote/ for this editbar logic
        event.preventDefault();
        editorScope.displayElements.popover.css('width', '436px');
        var container = editorScope.displayElements.popoverContainer;
        container.empty();
        container.css('line-height', '28px');
        var link = angular.element('<a href="' + $element.attr('href') + '" target="_blank">' + $element.attr('href') + '</a>');
        link.css({
          'display': 'inline-block',
          'max-width': '200px',
          'overflow': 'hidden',
          'text-overflow': 'ellipsis',
          'white-space': 'nowrap',
          'vertical-align': 'middle'
        });
        container.append(link);
        var buttonGroup = angular.element('<div class="btn-group pull-right">');
        var reLinkButton = angular.element('<button type="button" class="btn btn-default btn-sm btn-small"  unselectable="on" title="' + taTranslations.editLink.reLinkButton.tooltip + '"><i class="fa fa-edit icon-edit"></i></button>');
        reLinkButton.on('click', function(event){
          event.preventDefault();
          var urlLink = $window.prompt(taTranslations.insertLink.dialogPrompt, $element.attr('href'));
          if(urlLink && urlLink !== '' && urlLink !== 'http://'){
            $element.attr('href', urlLink);
            editorScope.updateTaBindtaTextElement();
          }
          editorScope.hidePopover();
        });
        buttonGroup.append(reLinkButton);
        var unLinkButton = angular.element('<button type="button" class="btn btn-default btn-sm btn-small"  unselectable="on" title="' + taTranslations.editLink.unLinkButton.tooltip + '"><i class="fa fa-unlink icon-unlink"></i></button>');
        // directly before this click event is fired a digest is fired off whereby the reference to $element is orphaned off
        unLinkButton.on('click', function(event){
          event.preventDefault();
          $element.replaceWith($element.contents());
          editorScope.updateTaBindtaTextElement();
          editorScope.hidePopover();
        });
        buttonGroup.append(unLinkButton);
        var targetToggle = angular.element('<button type="button" class="btn btn-default btn-sm btn-small" unselectable="on">' + taTranslations.editLink.targetToggle.buttontext + '</button>');
        if($element.attr('target') === '_blank'){
          targetToggle.addClass('active');
        }
        targetToggle.on('click', function(event){
          event.preventDefault();
          $element.attr('target', ($element.attr('target') === '_blank') ? '' : '_blank');
          targetToggle.toggleClass('active');
          editorScope.updateTaBindtaTextElement();
        });
        buttonGroup.append(targetToggle);
        container.append(buttonGroup);
        editorScope.showPopover($element);
      }
    }
  });
  taRegisterTool('wordcount', {
    display: '<div id="toolbarWC" style="display:block;">Words: <span ng-bind="wordcount"></span></div>',
    disabled: true,
    wordcount: 0,
    activeState: function(){ // this fires on keyup
      var textElement = this.$editor().displayElements.text;
      /* istanbul ignore next: will default to '' when undefined */
      var workingHTML = textElement[0].innerHTML || '';
      var noOfWords = 0;

      /* istanbul ignore if: will default to '' when undefined */
      if (workingHTML.replace(/\s*<[^>]*?>\s*/g, '') !== '') {
        var sanitizedHtml = workingHTML.replace(/<\/?(b|i|em|strong|span|u|strikethrough|a|img|small|sub|sup|label)( [^>*?])?>/gi, '') // remove inline tags without adding spaces
        .replace(/(<[^>]*?>\s*<[^>]*?>)/ig, ' ') // replace adjacent tags with possible space between with a space
        .replace(/(<[^>]*?>)/ig, '') // remove any singular tags
        .replace(/\s+/ig, ' ') // condense spacing
        //.replace('&nbsp;', ' ') // condense spacing
        //.replace('&thinsp;', ' ') // condense spacing
        //.replace('&ensp;', ' ') // condense spacing
        //.replace('&emsp;', ' ') // condense spacing
        .match(/\S+/g); // count remaining non-space strings
        noOfWords = sanitizedHtml ? sanitizedHtml.length : 0;
      }

      //Set current scope
      this.wordcount = noOfWords;
      //Set editor scope
      this.$editor().wordcount = noOfWords;

      return false;
    }
  });


  taRegisterTool('wordcountAlternative', {
    display: '<div id="toolbarWCA" style="display:block; min-width:100px;">Words: <span ng-bind="wordcount"></span></div>',
    disabled: true,
    wordcount: 0,
    activeState: function(){ // this fires on keyup
      if(this.$editor().displayElements)
      {
          var textElement = this.$editor().displayElements.text;
          var sourceText = textElement[0].innerText || textElement[0].textContent; // to cover the non-jquery use case.

          // Caculate number of words
          var sourceTextArray = sourceText.replace(/\s+/g,' ').split(' ');
          var noOfWords = 0;
          for (var i = 0; i < sourceTextArray.length; i++) {
              if (sourceTextArray[i] !== '') {
                  noOfWords++;
              }
          }

          //Set current scope
          this.wordcount = noOfWords;
          //Set editor scope
          this.$editor().wordcount = noOfWords;             
      }
      return false;
    }
  });

  taRegisterTool('charcount', {
    display: '<div id="toolbarCC" style="display:block; min-width:120px;">Characters: <span ng-bind="charcount"></span></div>',
    disabled: true,
    charcount: 0,
    activeState: function(){ // this fires on keyup
      var textElement = this.$editor().displayElements.text;
      var sourceText = textElement[0].innerText || textElement[0].textContent; // to cover the non-jquery use case.

      // Caculate number of chars
      var noOfChars = sourceText.replace(/(\r\n|\n|\r)/gm,"").replace(/^\s+/g,' ').replace(/\s+$/g, ' ').length;
      //Set current scope
      this.charcount = noOfChars;
      //Set editor scope
      this.$editor().charcount = noOfChars;
      return false;
    }
  });
  taRegisterTool('fontName', {
    tooltiptext: "Font",
    display: "<span class='bar-btn-dropdown dropdown' ng-disabled='isDisabled()'>" +
    "<button class='btn btn-default dropdown-toggle' type='button' tabindex='-1' ng-disabled='isDisabled()'><span>{{active}} </span><i class='fa fa-font'></i></button>" +
    "<ul class='dropdown-menu' ng-disabled='isDisabled()'><li ng-repeat='o in options'><button ng-disabled='isDisabled()' class='checked-dropdown font-dropdown' style='font-family: {{o.css}}' type='button' ng-click='action(o.css)'><i ng-if='o.active' class='fa fa-check'></i>{{o.name}}</button></li></ul></span>",
    action: function(font) {
      if (typeof font == 'string' && font !== '') {
        this.$editor().wrapSelection('fontName', font);
      }
    },
    options: [
      //{name: 'Sans-Serif', css: 'Arial, Helvetica, sans-serif'},
      //{name: 'Serif', css: "'times new roman', serif"},
      {name: 'Courier New', css: 'Courier New'},
      {name: 'Georgia', css: 'Georgia'},
      {name: 'Helvetica', css: 'Helvetica'},
      {name: 'Verdana', css: 'Verdana'},
      //{name: 'Wide', css: "Arial"},
      //{name: 'Narrow', css: "'arial narrow', sans-serif"},
      //{name: 'Comic Sans MS', css: "'comic sans ms', sans-serif"},
      //{name: 'Garamond', css: 'garamond, serif'},
      //{name: 'Tahoma', css: 'tahoma, sans-serif'},
      //{name: 'Trebuchet MS', css: "'trebuchet ms', sans-serif"},
      //{name: 'Proxima Nova', css: 'proxima_nova_rgregular'}
    ],
    active: '',
    setActive: function(font) {
      angular.forEach(this.options, function(option) {
        if (font === option.css) {
          this.active = option.name;
          option['active'] = true;
        } else {
          option['active'] = false;
        }
      });
    },
    getActive: function() {
      var font = document.queryCommandValue('fontName');
      if (font === '') {
        return 'Arial, Helvetica, sans-serif';
      } else {
        return font;
      }
    }
  });

  taRegisterTool('insertEmoji', {
    display: "<span class='insert-emoji  bar-btn-dropdown dropdown'><button class='btn btn-default dropdown-toggle' type='button' ng-disabled='showHtml()'><span> <i class='fa fa-smile-o'></i></span></button><ul class='dropdown-menu'><li ><div class='col-md-12'> <tabset> <tab ng-repeat='category in categorisedEmojis' ng-click='toggleDropdown($event)' > <tab-heading> <a  href class='emoji-menu-category'><img ng-src='{{getImageUrl(category.image)}}' alt='{{category.name}}'/></a> </tab-heading> <div ng-repeat='emoji in category.emojis' class='emoji-menu'> <a href='' ng-click='action(emoji)' title='{{emoji.short_name}}' ng-mouseover='hover(emoji)'><img ng-src='{{getImageUrl(emoji.image)}}'/></a> </div> <div class='clearfix'></div></tab> </tabset> <div class='clearfix'></div><div class='emoji-menu-footer'> <div class='col-md-3'> <img ng-src='{{getImageUrl(currentEmoji.image)}}' > </div><div cclass='col-md-9'> <span >{{currentEmoji.name}}</span> <br><span >:{{currentEmoji.short_name}}:</span> </div><div> <span><i class='fa fa-info-circle'></i> &nbsp;Type <b>':'</b> and hit TAB key for autocomplete</span> </div></div><div></li></ul></span>",
    tooltiptext: 'insert emoji',
    //"<span class='insert-emoji dropdown' dropdown on-toggle='toggled(open)' auto-close='outsideClick'><a href class='dropdown-toggle' dropdown-toggle><i class='fa fa-smile-o'></i></a><ul class='dropdown-menu'><li ><div class='col-md-12'><tabset><tab ng-repeat='category in categorisedEmojis'><tab-heading><a ng-click='toggleDropdown($event)' class='emoji-menu-category'><img src='{{getImageUrl(category.image)}}' alt='{{category.name}}' /></a></tab-heading><div ng-repeat='emoji in category.emojis' class='emoji-menu'><a href='' ng-click='action(emoji)' title='{{emoji.short_name}}' ng-mouseover='hover(emoji)'><img src='{{getImageUrl(emoji.image)}}' /></a></div><div class='clearfix'></div></tab></tabset><div class='clearfix'></div><div class='emoji-menu-footer'><div class='col-md-3'><img src='{{getImageUrl(currentEmoji.image)}}'></div><div cclass='col-md-9'><span>{{currentEmoji.name}}</span><br><span>:{{currentEmoji.short_name}}:</span></div><div><span><i class='fa fa-info-circle'></i> &nbsp;Type <b>':'</b> and hit TAB key for autocomplete</span></div></div></div></div></li></ul></span>", 
    action: function(emoji) {

      if (emoji && emoji.image ) {
        var editor = this.$parent.$parent.$parent.$parent.$editor();
        var embed = '<span><img src="//cdn.imentor.org/new_platform/static/emoji/img-apple-64/' + emoji.image + '" with="20" height="20" /></span>';
        editor.wrapSelection('insertHTML', embed, true);
      }
      if(this.isCategoryClick){
        $(this).dropdown('toggle');
        //$event.preventDefault();
        //$event.stopPropagation();
      }
      return false;
    },
    hover: function(emoji) {
      if (emoji && emoji.image) {
        this.$parent.$parent.$parent.$parent.currentEmoji = emoji;
      }
    },
    getImageUrl: function(file){
      return file ? '//cdn.imentor.org/new_platform/static/emoji/img-apple-64/' + file : file; 
    },
    toggleDropdown: function  ($event) {
      this.$parent.$parent.$parent.isCategoryClick = true;

      $event.preventDefault();
      $event.stopPropagation();
      //this.status.isopen = this.status.isopen;
    },
    categorisedEmojis: imEmbedService.getCategorisedEmojisArray(),
    currentEmoji: {},
    isCategoryClick: false,
  });

  taRegisterTool('insertImage', {
    iconclass: 'fa fa-image',
    tooltiptext: taTranslations.insertImage.tooltip,
    action: function(deferred, restoreSelection){
        var editor = this.$editor();
        var imageLink ='';
        imImages.open(this.size, this.photoService).then(function (result) {
              restoreSelection(); // puts the selection back in the correct place
              imageLink = result.url;
              if(imageLink && imageLink !== '' ){
                  //editor.wrapSelection('insertImage', imageLink, true);
                  var embed = '<a href="' + result.page + '" target="_blank"><img  src="' + imageLink + '" /></a>';
                  editor.wrapSelection('insertHTML', embed, true);
              }
          
             deferred.resolve();
        });
      
        return false;
    },
    photoService: {
            name: 'flickr',
            key: '6d0a7230e7a2b5a2c4bf8f9d125ecae6',
            userId: '84621158@N06'//'131666034@N05'
    },
    size: 'lg',
    onElementSelect: {
      element: 'img',
      action: imgOnSelectAction
    }
  });

  taRegisterTool('uploadFile', {
    iconclass: 'fa fa-upload',
    tooltiptext: 'upload file',
    action: function(deferred, restoreSelection){
        var editor = this.$editor();
        var urlLink ='';
        imUploadService.open(this.size).then(function (result) {
              restoreSelection(); // puts the selection back in the correct place
              urlLink = result.result.url;

              if(urlLink) {urlLink = urlLink.trim(); }
              if(urlLink && urlLink !== '' && urlLink !== 'http://'){
                var url = urlLink.replace(/#[^#]*$/, "").replace(/\?[^\?]*$/, "");
                var urlPath = url.substring(url.lastIndexOf('/')+1);
                var regex = /(?:\.([^.]+))?$/;
                var ext = regex.exec(urlPath)[1];
                var embed ='';
                if(typeof ext !== 'undefined'){
                  embed = '<a href="' + urlLink + '" target="_blank" ta-embed="' + ext + '">' + urlLink + '</a>';
                } else {
                  embed = '<a href="' + urlLink + '" target="_blank" ta-embed=" ">' + urlLink + '</a>';
                }
                return editor.wrapSelection('insertHTML', embed, true);
              }
              deferred.resolve();
        });
      
        return false;
    },
    size: 'lg', 
    onElementSelect: {
      element: 'a'
    }
  });
  
}])

.config(function ($provide) {
    $provide.decorator('taOptions', ['taCustomRenderers', '$compile', '$templateRequest',  '$rootScope', 'imEmbedService','$sce', '$delegate',function(taCustomRenderers, $compile, $templateRequest,  $rootScope, imEmbedService,$sce, taOptions){
            taCustomRenderers.push({
                customAttribute: 'ta-embed',
    renderLogic: function(element){
      var attributes = element.prop("attributes");
      // loop through element attributes and apply them on iframe
      var embedType= attributes['ta-embed'].value;
      var url = attributes['href'].value;
      
      var scope = $rootScope.$new(true);

      var wrapper;
      if(embedType && embedType.length > 0 && embedType!==' '){
        wrapper = angular.element('<div im-embed data-type="' + embedType +'" data-url="' + url + '"></div>');
      } else {
        wrapper = angular.element('<div im-embed data-url="' + url + '"><a href="' + url + '">' + element.text() + '</a></div>');
      }
      element.replaceWith($compile(wrapper)(scope));
    
    }
            });
            return taOptions;
        }]);

  });


