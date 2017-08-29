'use strict';
angular.module('adminApp').controller('ratioCtrl', ['$scope', '$rootScope', '$timeout', '$http', '$location', '$uibModal', 'pageService',
    function($scope, $rootScope, $timeout, $http, $location, $modal, pageService) {
        $scope.test = "";
        var saveUrl = "/dictionary/edit";
        var queryUrl = "/dictionary/all";
        var data = "";
        var path = "";
        $scope.edit = true;
        $scope.save = false;
        $scope.edits = true;
        $scope.saves = false;
        $scope.editss = true;
        $scope.savess = false;
        $scope.reads = true;
        $scope.readss = true;
        $scope.setGoldFlower = function(result) {
            $scope.dictionary = result.data[0];
        };
        $scope.setFlowerGold = function(result) {
            $scope.dictionary1 = result.data[0];
        };
        $scope.setFlowerRMB = function(result) {
            $scope.dictionary2 = result.data[0];
        };
        pageService.setBase();
        pageService.get(queryUrl + "?type=" + MASTER2PETAL, "", $scope.setGoldFlower);
        pageService.get(queryUrl + "?type=" + PETAL2MASTER, "", $scope.setFlowerGold);
        pageService.get(queryUrl + "?type=" + PETAL2CNY, "", $scope.setFlowerRMB);
        $scope.read = true;
        $scope.class = "";
        $scope.editButton = function() {
            $scope.edit = false;
            $scope.read = false;
            $scope.save = true;
            $scope.class = "form-white";
        };
        $scope.editButtons = function() {
            $scope.edits = false;
            $scope.reads = false;
            $scope.saves = true;
            $scope.classs = "form-white";
        };
        $scope.editButtonss = function() {
            $scope.editss = false;
            $scope.readss = false;
            $scope.savess = true;
            $scope.classss = "form-white";
        };
        $scope.result = function(data) {
            if (data.code == "200") {
                var text = "师币：花瓣比例修改成功";
                pageService.notys(text, "", "", "", "success");
            } else {
                pageService.serverError(result);
            }
        };

        $scope.saveButton = function() {
            if ($('.form-validation').valid()) {
                $scope.save = false;
                $scope.read = true;
                $scope.edit = true;
                $scope.class = "";
                pageService.setAjax();
                pageService.setBase();
                pageService.postJson(saveUrl, JSON.stringify($scope.dictionary), $scope.result);
            }
        };

        $scope.results = function(data) {
            if (data.code == "200") {
                var text = "花瓣：师币比例修改成功";
                pageService.notys(text, "", "", "", "success");
            } else {
                pageService.serverError(result);
            }
        };
        $scope.saveButtons = function() {
            if ($('.form-validations').valid()) {
                $scope.saves = false;
                $scope.reads = true;
                $scope.edits = true;
                $scope.classs = "";
                pageService.setAjax();
                pageService.setBase();
                pageService.postJson(saveUrl, JSON.stringify($scope.dictionary1), $scope.results);
            }
        };
        $scope.resultss = function(data) {
            if (data.code == "200") {
                var text = "花瓣：RMB比例修改成功";
                pageService.notys(text, "", "", "", "success");
            } else {
                pageService.serverError(result);
            }
        };
        $scope.saveButtonss = function() {
            if ($('.form-validationss').valid()) {
                $scope.savess = false;
                $scope.readss = true;
                $scope.editss = true;
                $scope.classss = "";
                pageService.setAjax();
                pageService.setBase();
                pageService.postJson(saveUrl, JSON.stringify($scope.dictionary2), $scope.resultss);
            }
        };
    }
]);
