'use strict';
//添加banner
angular.module('adminApp').controller('newsEditCtrl', ['$scope', '$timeout', '$routeParams', '$location', '$uibModal', 'pageService', 'pluginsService',
    function($scope, $timeout, $routeParams, $location, $modal, pageService, pluginsService) {
        var data = {};
        var url = "";
        var text = "";
        pageService.summernote("news");
        $scope.setData = function(result) {
          console.log(result);
            if (result.errno === 0) {
                $scope.news = result.data;
                console.log($scope.news);
                $('#news').summernote('code', $scope.news.content);
            } else {
                pageService.serverError(result);
            }
        };
        $scope.news = {};
        url = "/news";
        console.log($routeParams);
        $scope.href = "#news/"+$routeParams.type;
        if ($routeParams.operate == "edit") {
          $scope.operate = "修改";
            pageService.setBase();
            pageService.get('/news', {
                id: $routeParams.id
            }, $scope.setData);
        } else {
          $scope.operate = "添加";
        }
        if($routeParams.type == "1"){
          $scope.type = "行业动态";
        }else{
          $scope.type = "新闻";
        }
        $scope.news.type = $routeParams.type;
        $scope.select = function(){
          data.msg = "图片模糊会影响前端用户的使用，请使用清晰的图片进行裁切";
          data.width = 424;
          data.height = 299;
          data.maxSize = 424;
          data.cssTop = 500;
          data.cssTops = 810;
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
                  $scope.news.thumbnail = result;
              }
          }, function(reason) {
              console.log(reason); //点击空白区域，总会输出backdrop click，点击取消，则会暑促cancel
          });
        };
        $scope.callback = function(result) {
            if (result.errno === 0) {
              text = $scope.type+$scope.operate +"成功";
                $timeout(function() {
                    $location.path("/news/"+$routeParams.type);
                });
                pageService.notys(text, "", "", "", "success");
            } else {
                pageService.serverError(result);
            }
        };
        $scope.submit = function() {
            if ($('.form-validation').valid()) {
                if ($('#news').summernote('isEmpty')) {
                    text = $scope.type+"内容不能为空";
                    pageService.notys(text, "", "", "", "danger");
                }else if ($scope.news.thumbnail == null) {
                    text = "请上传"+$scope.type+"封面图";
                    pageService.notys(text, "", "", "", "danger");
                } else {
                    $scope.news.content = $('#news').summernote('code');
                    pageService.setBase();
                    pageService.post(url, $scope.news, $scope.callback);
                }
            }
        };
    }
]);
