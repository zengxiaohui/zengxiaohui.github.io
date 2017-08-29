angular.module('adminApp')
    .directive('ngImage', ["$uibModal", function($modal) {
        return {
            template: '<div class="fileinput fileinput-new" data-provides="fileinput" data-width="{{width}}" data-height="{{height}}" data-max-size="{{maxSize}}" data-shape="{{shape}}" data-top="{{top}}">' +
                '<div class="fileinput-new">' +
                '<img alt="gallery 3" class="img-responsive  {{shapes}}"src ="{{src}}" ng-src="{{result}}"/>' +
                '</div>' +
                '<div ng-click="crop()" style="padding-top:10px;">' +
                '  <span class="btn btn-default btn-file">' +
                '<span class="fileinput-new {{class}}">' +
                '  选择图片' +
                '  </span>' +
                '</span>' +
                '</div>' +
                '  </div>',
            replace: true,
            restrict: 'AE',
            scope: {
                src: '=',
                width: '@',
                height: '@',
                maxSize: '@',
                top: '@',
                shape: '@',
                result: '=',
                shapes: '=',
                crop: '&'
            },
            link: function(scope, element, attributes) {
                scope.class = scope.class || 'select';
                scope.shape = scope.shape || 'largeCrop';
                var data = {};
                data.width = scope.width;
                data.height = scope.height;
                data.maxSize = scope.maxSize;
                data.top = scope.top;
                console.log(scope);
                console.log(attributes);
                scope.crop = function() {
                    var modalInstance = $modal.open({
                        templateUrl: 'crop/'+scope.shape+'.html',
                        controller: scope.shape+'Ctrl',
                        resolve: {
                            datas: function() {
                                return angular.copy(data);
                            }
                        }
                    });
                    modalInstance.result.then(function(result) {
                        if (result == "" || result == null || result == "normal") {} else {
                            scope.result = result;
                        }
                    }, function(reason) {
                        console.log(reason); //点击空白区域，总会输出backdrop click，点击取消，则会暑促cancel
                    });
                };
            }
        };
    }]);
