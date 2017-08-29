'use strict';
angular.module('adminApp').controller('circleCtrl', ['$scope',  '$uibModal', '$uibModalInstance','datas', function($scope,$modal, $modalInstance,datas) {
// console.log(datas);
$scope.width = datas.width;
$scope.height = datas.height;
$scope.maxSize = datas.maxSize;
// console.log(datas);
$(".modal-dialog").width("auto");
// jQuery.getScript("../../global/plugins/imageCrop/image-crop.js", function(data, status, jqxhr) {
// 	});
 $scope.fileChanged = function(e) {
        var files = e.target.files;
        var fileReader = new FileReader();
        fileReader.readAsDataURL(files[0]);
        fileReader.onload = function(e) {
            $scope.imgSrc = this.result;
            // console.log($scope.imgSrc);
            $scope.$apply();
        };
    };
    $scope.clear = function() {
        $scope.imageCropStep = 1;
        delete $scope.imgSrc;
        delete $scope.result;
        delete $scope.resultBlob;
    };
    $scope.close = function() {
        $modalInstance.close("normal");
    };
    $scope.submit = function() {
        if ($scope.result == null) {

        } else {
            var file = new AV.File('crop.jpeg', {
                base64: $scope.result
            });
            file.save().then(function(obj) {
                $modalInstance.close(obj.url());
            }, function(err) {
                console.log(err);
            });
        }
    };
}]);
