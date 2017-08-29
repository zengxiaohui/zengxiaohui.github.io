'use strict';
//大图片裁切
angular.module('adminApp').controller('largeCropCtrl', ['$scope', '$uibModal', '$uibModalInstance', '$timeout','pageService', 'datas', function($scope, $modal, $modalInstance,$timeout, pageService, datas) {
    var open = "animated fadeInDown";
    var close = "animated fadeOutUp";
    var position = "topRight";
    var text = "";
    var data = {};
    $scope.width = datas.width;
    $scope.height = datas.height;
    $scope.maxSize = datas.maxSize;
    $scope.msg = datas.msg;
    $scope.url = datas.url;
    // $scope.top = datas.top;
    var width = 0;
    var needWidth = datas.width * 2 + 470;
    $timeout(function() {
        width = document.getElementById("modal").offsetWidth;
        if (needWidth > width) {
            $('.modal-footer').css("top", datas.cssTops + "px");
        } else {
            $('.modal-footer').css("top", datas.cssTop + "px");
        }
    });

    $(window).resize(function() {
        var widths = document.getElementById("modal").offsetWidth;
        if (needWidth > widths) {
            $('.modal-footer').css("top", datas.cssTops + "px");
        } else {
            $('.modal-footer').css("top", datas.cssTop + "px");
        }
    });
    // $scope.modal =  $('.modal-dialog').width();
    // console.log($('.modal-dialog').width());
    $scope.fileChanged = function(e) {
        var files = e.target.files;
        var fileReader = new FileReader();
        fileReader.readAsDataURL(files[0]);
        fileReader.onload = function(e) {
            $scope.imgSrc = this.result;
            $scope.$apply();
        };
    };
    $scope.clear = function() {
        $scope.imageCropStep = 1;
        delete $scope.imgSrc;
        delete $scope.result;
        delete $scope.resultBlob;
    };
    $scope.callback = function callback(result) {
        if (result.code == "200") {
            $modalInstance.close(result.data.homeImage);
            text = " <div class='bit top right notification active'><div class='alert alert-success  media fade in active' style='font-family:Tahoma;font-size:17px;'><p>图片更新成功！</p></div></div>";
            pageService.noty(text, open, close, position);
        } else {
            pageService.serverError(result);
        }
    };
    $scope.close = function() {
        $modalInstance.close("normal");
    };
    $scope.submit = function() {
        if ($scope.result == null) {} else {
            var file = new AV.File('crop.jpeg', {
                base64: $scope.result
            });
            file.save().then(function(obj) {
                datas.value = obj.url();
                if (datas.url == null) {
                    $modalInstance.close(obj.url());
                } else {
                    pageService.setAjax();
                    pageService.setBase();
                    pageService.post($scope.url, datas, $scope.callback);
                }
            }, function(err) {
            }).catch(function(error) {
            });
        }
    };
}]);
