'use strict';
//添加banner
angular.module('adminApp').controller('scienceEditCtrl', ['$scope', '$timeout', '$routeParams', '$location', '$uibModal', 'pageService', 'pluginsService',
    function($scope, $timeout, $routeParams, $location, $modal, pageService, pluginsService) {
        var data = {};
        var url = "";
        var text = "";
        $scope.setData = function(result) {
            if (result.errno === 0) {
                $scope.science = result.data;
            } else {
                pageService.serverError(result);
            }
        };
        $scope.science = {};
        url = "/science";
        if ($routeParams.operate == "edit") {
          $scope.operate = "修改";
            pageService.setBase();
            pageService.get('/science', {
                id: $routeParams.id
            }, $scope.setData);
        } else {
          $scope.operate = "添加";
        }
        $scope.select = function(){
          data.msg = "图片模糊会影响前端用户的使用，请使用清晰的图片进行裁切";
          data.width = 459;
          data.height = 424;
          data.maxSize = 459;
          data.cssTop = 1070;
          data.cssTops = 610;
          // data.top = "{'margin-top':'60%'}";
          var modalInstance = $modal.open({
              templateUrl: 'crop/largeCrop.html',
              controller: 'largeCropCtrl',
              // size: 'lg',
              resolve: {
                  datas: function() {
                      return angular.copy(data);
                  }
              }
          });
          modalInstance.result.then(function(result) {
              // console.log(result);
              if (result == "" || result == null || result == "normal") {} else {
                  $scope.science.image = result;
              }
          }, function(reason) {
              console.log(reason); //点击空白区域，总会输出backdrop click，点击取消，则会暑促cancel
          });
        };
        $scope.callback = function(result) {
            if (result.errno === 0) {
              text = "科学顾问信息"+$scope.operate +"成功";
                $timeout(function() {
                    $location.path("/science");
                });
                pageService.notys(text, "", "", "", "success");
            } else {
                pageService.serverError(result);
            }
        };
        $scope.submit = function() {
          console.log($scope.science);
            if ($('.form-validation').valid()) {
                 if ($scope.science.image == null) {
                    text = "请上传科学顾问图片";
                    pageService.notys(text, "", "", "", "danger");
                } else {
                    pageService.setBase();
                    pageService.post(url, $scope.science, $scope.callback);
                }
            }
        };
    }
]);
