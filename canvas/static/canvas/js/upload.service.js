/* jshint loopfunc:true */

(function() {

    'use strict';

    angular.module('imUpload', ['ngFileUpload'])

    .controller('imUploadModelController', ['$scope', '$modalInstance', '$location', '$timeout', 'Upload', 'user_id', 'files', '$http', imUploadModelController])

    .service('imUploadService', ['$modal', function imUploadServiceController($modal) {


        var vm = this;
  
        vm.open = function(size) {
            vm.activate();
            var imentor_cdn_prefix =  '';//typeof getCdnUrlPrefix == 'function' ? getCdnUrlPrefix() : '';
            return $modal.open({
                animation: true,
                templateUrl: imentor_cdn_prefix + '/new_platform/static/canvas/nghtml/upload.service.html',
                controller: 'imUploadModelController',
                size: size,
                resolve: {
                    user_id: function() {
                        return '';
                    },
                    files: function () {
                        return [];
                    }
                }
            }).result;
            
        };

        vm.activate = function() {
            
        };

        

    }
]);

    function imUploadModelController($scope, $modalInstance, $location, $timeout, Upload, user_id, files, $http) {

        $scope.getFilextensions = function() {
            return $http.get('/generic/file_extensions/' , {}
            );
        };

        $scope.files   = [];
        $scope.filesUpload   = [];
        $scope.uploadProgress = false;
        $scope.uploadButtonText = "Upload File";
        $scope.selected = {};
        $scope.errorMsg = "";
        $scope.getFilextensions()
          .then(function (data) {
              $scope.allowTypes = data.data.join();
              console.log($scope.allowTypes);
          });
        //$scope.allowTypes = '.doc,.docx,.docm,.dotx,.dotm,.xls,.xlsx,.xlsm,.xltx,.xltm,.xlsb,.xlam,.csv,.ppt,.pptx,.pptm,.potx,.ppam,.ppsx,.ppsm,.ade,.adp,.accdb,.accde,.accdt,.accdr,.pdf,.psd,.jpg,.jpeg,.gif,.png,.xml,.txt,.vcf,.icl,.ical,.html,.htm,.rtf,.pages,.numbers,.key,.odt,.ods,.odb,.odp,.odg,.odf,.mp4,.mp3';

        $scope.$watch('filesUpload', function (files) {
            $scope.formUpload = false;
            if (files !== null) {
                for (var i = 0; i < files.length; i++) {
                    $scope.errorMsg = null;
                    (function (file) {
                           if(!file.result){ upload(file);}
                    })(files[i]);
                }
            }
        });

        $scope.getUrl =function (relativeUrl){
            if($location.absUrl().indexOf(':' + $location.port())!==-1){ 
                return $location.protocol() + '://'+ $location.host() +':'+  $location.port()  +'' + relativeUrl;
            }
            return $location.protocol() + '://'+ $location.host() +'' + relativeUrl;
        };

        $scope.remove =function (file){
            var index = $scope.filesUpload.indexOf(file);
            if (index > -1) {
                $scope.filesUpload.splice(index, 1);
            }
        };


        $scope.abort =function (file){
            file.result = 'Aborted';
        };

        function setProgress(progress) {
               $scope.uploadProgress = progress;
               $scope.uploadButtonText = progress ?"Uploading please wait" : "Upload File" ;
        }

        function upload(file) {
         
            setProgress(true);
            file.upload = Upload.upload({
                url: '/user_content/', //staticUri.routeUri.uploadUri, // + '' + $scope.self.user_id + '/',
                method: 'POST',
               /* headers: {
                    'my-header': 'my-header-value'
                },
                fields: {user_id: $scope.self.user_id},*/
                file: file,
                fileFormDataName: 'file'
            });

            file.upload.then(function (response) {
                $timeout(function () {
                    file.result = response.data;
                    $scope.selected = file;
                    setProgress(false);
                    $scope.selected.result.url = $scope.getUrl($scope.selected.result.url);
                    $modalInstance.close($scope.selected);
                });
            }, function (response) {
                if (response.status > 0) {
                    file.result = response.status + ': ' + response.data;
                }
                $scope.errorMsg = 'This file failed to upload. Please click the red "X" icon to the left and try again, or contact your staff member with the full name of the file to get help.';
                setProgress(false);
            });

            file.upload.progress(function (evt) {
                // Math.min is to fix IE which reports 200% sometimes
                file.progress = Math.min(100, parseInt(100.0 * evt.loaded / evt.total));
            });

            file.upload.xhr(function (xhr) {
                // xhr.upload.addEventListener('abort', function(){console.log('abort complete')}, false);
            });
        }

        $scope.validateType = function(file) {
            var ext = file.name.substr(file.name.lastIndexOf('.'));
             if($scope.allowTypes.toLowerCase().indexOf(ext.toLowerCase())===-1)
             { 
                 //alert('Unable to upload. Unsupported file type.');
                 $scope.errorMsg = 'Unable to upload. Unsupported file type.';
                return false;
             }
             return true;
        };

        $scope.ok = function() {
            $modalInstance.close($scope.selected.item);
        };

        $scope.cancel = function() {
            $modalInstance.dismiss('cancel');
        };

       function activate() {
         
        }

        activate();

    }

})();

