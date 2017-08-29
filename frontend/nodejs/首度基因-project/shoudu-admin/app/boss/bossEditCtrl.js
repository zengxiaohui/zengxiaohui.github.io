angular.module("adminApp").controller("bossEditCtrl", ["$scope", "$timeout", "$uibModal", "$location", "$routeParams", "pageService", function($scope, $timeout, $modal, $location, $routeParams, pageService) {
    var data = {};
    $scope.setData = function(result) {
        if (result.errno == "0") {
            $scope.boss = result.data;
            if ($scope.boss.type == "0") {
                $scope.ceo = true;
                $scope.bosss = false;
                $scope.type = "CEO";
            } else {
                $scope.ceo = false;
                $scope.bosss = true;
                $scope.type = "总裁";
            }
        }

    };
    pageService.setBase();
    pageService.get("/boss", {
        id: $routeParams.id
    }, $scope.setData);
    $scope.select = function() {
        data.msg = "图片模糊会影响前端用户的使用，请使用清晰的图片进行裁切";
        if ($scope.boss.type == "0") {
            data.width = 428;
            data.height = 592;
            data.maxSize = 592;
            data.cssTop = 790;
            data.cssTops = 1410;
        } else {
            data.width = 612;
            data.height = 410;
            data.maxSize = 612;
            data.cssTop = 1070;
            data.cssTops = 1050;
        }
        var modalInstance = $modal.open({
            templateUrl: 'crop/largeCrop.html',
            controller: 'largeCropCtrl',
            resolve: {
                datas: function() {
                    return angular.copy(data);
                }
            }
        });
        modalInstance.result.then(function(result) {
            // console.log(result);
            if (result == "" || result == null || result == "normal") {} else {
                $scope.boss.image = result;
            }
        }, function(reason) {
            console.log(reason); //点击空白区域，总会输出backdrop click，点击取消，则会暑促cancel
        });
    };

    $scope.callback = function(result) {
        if (result.errno == "0") {
            var text = $scope.type + "信息修改完成";
            $timeout(function() {
                $location.path("/boss");
            });
            pageService.notys(text, "", "", "", "success");
        }
    };
    $scope.submit = function() {
        if ($(".form-validation").valid()) {
            if ($scope.boss.image == null) {
                text = "请上传" + $scope.type + "图片";
                pageService.notys(text, "", "", "", "danger");
            } else {
                pageService.setBase();
                pageService.post("/boss", $scope.boss, $scope.callback);
            }
        }
    };
}]);
