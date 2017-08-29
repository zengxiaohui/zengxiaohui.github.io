'use strict';
//大师信息
var params = '';
angular.module('adminApp').controller('newsCtrl', ['$scope', '$timeout', '$routeParams', '$http', '$location', '$uibModal', '$filter', 'pageService',
    function($scope, $timeout, $routeParams, $http, $location, $modal, $filter, pageService) {
        var open = "";
        var close = "";
        var text = "";
        var url = "";
        var status = "";
        var oTable = {};
        $timeout(function() {
            $('.magnific').each(function() {
                $(this).magnificPopup({
                    type: 'image',
                    gallery: {
                        enabled: true
                    },
                    zoom: {
                        enabled: true,
                        duration: 300,
                        easing: 'ease-in-out',
                        opener: function(openerElement) {
                            return openerElement.is('img') ? openerElement : openerElement.find('img');
                        }
                    },
                    removalDelay: 300,
                    mainClass: 'mfp-fade'
                });
            });
        }, 1000);
        var columns = [{
            "sTitle": "ID",
            "mData": "id"
        }, {
            "sTitle": "封面",
            "sClass": "centers",
            "mData": "thumbnail"
        }, {
            "sTitle": "标题",
            "sClass": "centers",
            "mData": "title",
        }, {
            "sTitle": "查看内容详情",
            "sClass": "centers",
            "mData": "id"
        }, {
            "sTitle": "修改",
            "sClass": "centers",
            "mData": "id"
        }, {
            "sTitle": "删除",
            "sClass": "centers",
            "mData": "id"
        }];

        var columnDefs = [{
            "targets": 1, //显示用户头像
            "render": function(data, type, row) {
                if (data == null || data == "") {
                    return "<div class='thumbnail magnific'  style='width:115px;height:83px;margin-left:25%;margin:auto;margin-bottom:-2px;' data-mfp-src='../../global/images/news-cover.png'><img src='../../global/images/news-cover.png'   style='width:112px;height:80px;'/></div>";
                } else {
                    return "<div class='thumbnail magnific'  style='width:115px;height:83px;margin-left:25%;margin:auto;margin-bottom:-2px;' data-mfp-src='" + data + "'><img src='" + data + pageService.thumbnail(112, 80) + "'/></div>";
                }
            }
        }, {
            "targets": -3, //登录推荐
            "render": function(data, type, row) {
                return "<button  id='content' class='btn  btn-primary  btn-transparent'  type='button' style='margin:auto;'>查看</button>";
            }
        }, {
            "targets": -2, //编辑
            "render": function(data, type, row) {
                // console.log(row);
                return "<a id='editInfo' href='#news/" + $routeParams.type + "/edit/" + data + "' class='btn btn-sm btn-icon btn-rounded btn-default ' type='button'><i class='fa fa-edit' style='padding-top:7px;padding-left:1px;'></i></a>";
            }
        }, {
            "targets": -1, //删除
            "render": function(data, type, row) {
                return "<a  id='del' class='btn btn-sm btn-icon btn-rounded btn-danger' type='button'  ><i class='fa fa-trash-o' style='padding-top:7px;padding-left:1px;'></i></a>";
                // else
                //     return "<a  id='del' class='btn btn-sm btn-icon btn-rounded btn-default' type='button'  disabled style='color:gray;'><i class='fa fa-trash-o' style='padding-top:7px;padding-left:1px;'></i></a>";

            }
        }, {
            "targets": 0, //第一列隐藏
            "visible": false,
            "searchable": false
        }];
        var resource = "/news?type="+$routeParams.type;
        params = pageService.datatables(resource, true, true);
        params.aoColumns = columns;
        params.columnDefs = columnDefs;
        if ($routeParams.type == 0)
            oTable = $('#news-table').DataTable(params);
        else
            oTable = $('#industy-table').DataTable(params);
        //点击选中一行
        $('.table-hover tbody').on('click', 'tr', function() {
            if ($(this).hasClass('selected')) {
                $(this).removeClass('selected');
            } else {
                oTable.$('tr.selected').removeClass('selected');
                $(this).addClass('selected');
            }
        });
        $timeout(function() {
            //修改输入框提示信息
            $("div#news-table_filter").find('input').attr("placeholder", "输入新闻标题");
            $("div#news-table_filter").find('input').css("width", "250px");
            $("div#news-table_filter").css("margin-top", "-9px");
            $("div#industy-table_filter").find('input').attr("placeholder", "输入行业动态标题");
            $("div#industy-table_filter").find('input').css("width", "250px");
            $("div#industy-table_filter").css("margin-top", "-9px");
        });
        $('#news-table').on('draw.dt', function() {
            $timeout(function() {
                pageService.magnificPopup();
            }, 500);
        });
        $('#industy-table').on('draw.dt', function() {
            $timeout(function() {
                pageService.magnificPopup();
            }, 500);
        });
        $('.table-hover tbody').on('click', 'button#content', function() {
            var data = oTable.row($(this).parents('tr')).data();
            pageService.modalTip(oTable, data, "", "news-content");
        });

        $('.table-hover tbody').on('click', 'a#del', function() {
            var data = oTable.row($(this).parents('tr')).data();
            pageService.modalTip(oTable, data, "", "del_news");
        });




    }
]);
