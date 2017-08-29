'use strict';
angular.module('adminApp').controller('squareCtrl', ['$scope',  '$uibModal', '$uibModalInstance','datas', function($scope,$modal, $modalInstance,datas) {
console.log(datas);
$scope.width = datas.width;
$scope.height = datas.height;
$(".modal-dialog").width(datas.modalWidth);
// jQuery.getScript("../../global/plugins/imageCrop/image-crop.js", function(data, status, jqxhr) {
// 	});
 $scope.fileChanged = function(e) {
        var files = e.target.files;
        var fileReader = new FileReader();
        fileReader.readAsDataURL(files[0]);
        fileReader.onload = function(e) {
            $scope.imgSrc = this.result;
            console.log($scope.imgSrc);
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
        if ($scope.result == null) {} else {
            // AV.initialize('0K1hxBYoqK1uO10pvrQigRzR-gzGzoHsz', '4gM39gGUa7qfnlgl4QlgyeTJ');
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
