'use strict';
//添加banner
angular.module('adminApp').controller('pushCtrl', ['$scope', '$timeout', '$routeParams', '$location', '$uibModal', 'pageService', 'pluginsService',
    function($scope, $timeout, $routeParams, $location, $modal, pageService, pluginsService) {
        var text = "";
        var data = {};
        var url = "/account/update";
        $scope.push = {};
        $scope.disable = false;

        $scope.submit = function() {
            $scope.disable = true;
              $scope.push.url = $(".fileinput-preview").eq(0).find("img").attr('src');
              if($scope.push.url == "../../global/images/900z.png"){
                $scope.push.url = null;
              }
              console.log($scope.push.url);
            if ($scope.push.content == null || $scope.push.url == null) {
                $scope.disable = false;
                text = "推送文字内容和图片都需要填写！";
                pageService.notys(text, "", "", "", "danger");
            } else {
                if ($scope.push.content != null && $scope.push.url != null) {
                    $scope.push.type = TYPE_ALL;
                } else if ($scope.push.content != null) {
                    $scope.push.type = TYPE_CONTENT;
                } else if ($scope.push.url != null) {
                    $scope.push.type = TYPE_IMAGE;
                }
                var modalInstance = $modal.open({
                    templateUrl: 'system/pushTip.html',
                    controller: 'pushTipCtrl',
                    resolve: {
                        datas: function() {
                            return angular.copy($scope.push);
                        }
                    }
                });
                modalInstance.result.then(function(result) {
                    $scope.disable = false;
                    if (result == "success") {
                        $scope.push = {};
                        $(".fileinput-preview").eq(0).find("img").attr('src',"../../global/images/900z.png");
                    }
                }, function(reason) {

                });
            }
        };

    }
]).controller("pushTipCtrl", ["$scope", "$uibModalInstance", "pageService", "datas", function($scope, $modalInstance, pageService, datas) {
    $scope.close = function() {
        $modalInstance.close("normal");
    };
    $scope.title = "确认信息";
    $scope.msg = "系统消息将进行推送，请再次确认！";
    $scope.con = true;
    $scope.callback = function(result) {
        $scope.disable = false;
        $scope.$apply();
        if (result.code == "200") {
            var text = "系统消息推送成功";
            $modalInstance.close("success");
            pageService.notys(text, "", "", "", "success");
        } else {
            pageService.serverError(result);
        }
    }
    $scope.submit = function() {
        $scope.disable = true;
        pageService.setBase();
        pageService.postJson("/sysMsg/push", JSON.stringify(datas), $scope.callback);
    };
}]);
