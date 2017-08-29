"use strict";

angular.module("adminApp").controller("feedbackCtrl", ["$scope","pageService", function($scope,pageService) {
    var columns = [{
        "sTitle": "ID",
        "sClass": "centers",
        "mData": "id"
    }, {
        "sTitle": "反馈内容",
        "sClass": "centers",
        "mData": "content"
    }, {
        "sTitle": "反馈人昵称",
        "sClass": "center",
        "mData": "profile.nickname"
    },{
        "sTitle": "联系方式",
        "sClass": "center",
        "mData": "phone"
    }, {
        "sTitle": "反馈时间",
        "sClass": "center",
        "mData": "createTime"
    }];
    var columnDefs = [{
        "targets": -1,
        "render": function(data, type, row) {
            if (data == null)
                return "";
            else
                return data;
        }
    },{
        "targets": 0, //第一列隐藏
        "visible": false,
        "searchable": false
    }];
    pageService.setAjax();
    pageService.setBase();
    var resource = "/feedback/all";
    var params = pageService.datatables(resource, false, true);
    params.columns = columns;
    params.columnDefs = columnDefs;
    var oTable = $('#feedback-table').DataTable(params);
}]);
