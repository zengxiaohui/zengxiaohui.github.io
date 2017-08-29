'use strict';
angular.module('adminApp').controller('liveTipCtrl', ['$scope', '$rootScope', '$timeout', '$http', '$location', '$uibModal', 'pageService',
    function($scope, $rootScope, $timeout, $http, $location, $modal, pageService) {
        $scope.test = "";
        var saveUrl = "/dictionary/liveTip/edit";
        var queryUrl = "/dictionary/all?type=" + TYPE_LIVE_PROMOT;
        var data = "";
        var path = "";
        $scope.edit = true;
        $scope.save = false;
        $scope.setData = function(result) {
            $scope.dictionary = result.data[0];
        };
        pageService.setBase();
        pageService.get(queryUrl, "", $scope.setData);
        $scope.read = true;
        $scope.class = "";
        // console.log($scope.ratio);
        $scope.editButton = function() {
            $scope.edit = false;
            $scope.read = false;
            $scope.save = true;
            $scope.class = "form-white";
        };
        $scope.result = function(data) {
            if (data.code == "200") {
                var text = "修改成功";
                pageService.notys(text, "", "", "", "success");
            }
        };

        $scope.saveButton = function() {
            $scope.save = false;
            $scope.read = true;
            $scope.edit = true;
            $scope.class = "";
            pageService.setAjax();
            pageService.setBase();
            pageService.post(saveUrl, $scope.dictionary, $scope.result);
        };
    }
]);
