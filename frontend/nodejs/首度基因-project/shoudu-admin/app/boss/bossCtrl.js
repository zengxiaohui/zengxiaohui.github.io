'use strict';
//大师信息
var params = '';
angular.module('adminApp').controller('bossCtrl', ['$scope', '$timeout', '$routeParams', '$http', '$location', '$uibModal', '$filter', 'pageService',
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
            "sTitle": "图片",
            "sClass": "centers",
            "mData": "image"
        }, {
            "sTitle": "姓名",
            "sClass": "centers",
            "mData": "name",
        }, {
            "sTitle": "职位",
            "sClass": "centers",
            "mData": "position"
        }, {
            "sTitle": "查看个人简介",
            "sClass": "centers",
            "mData": "id"
        }, {
            "sTitle": "修改",
            "sClass": "centers",
            "mData": "id"
        }];

        var columnDefs = [{
            "targets": 1, //显示用户头像
            "render": function(data, type, row) {
                if (row.type == 0) {
                  if (data == null || data == "") {
                      return "<div class='thumbnail magnific'  style='width:84px;height:118px;margin-left:25%;margin:auto;margin-bottom:-2px;' data-mfp-src='../../global/images/science.png'><img src='../../global/images/ceo.png'   style='width:80px;height:110px;'/></div>";
                  } else {
                      return "<div class='thumbnail magnific'  style='width:84px;height:114px;margin-left:25%;margin:auto;margin-bottom:-2px;' data-mfp-src='" + data + "'><img src='" + data + pageService.thumbnail(80, 110) + "'/></div>";
                  }
                } else {
                    if (data == null || data == "") {
                        return "<div class='thumbnail magnific'  style='width:110px;height:88px;margin-left:25%;margin:auto;margin-bottom:-2px;' data-mfp-src='../../global/images/science.png'><img src='../../global/images/boss.png'   style='width:106px;height:80px;'/></div>";
                    } else {
                        return "<div class='thumbnail magnific'  style='width:110px;height:84px;margin-left:25%;margin:auto;margin-bottom:-2px;' data-mfp-src='" + data + "'><img src='" + data + pageService.thumbnail(106, 80) + "'/></div>";
                    }
                }
            }
        }, {
            "targets": -4,
            "render": function(data, type, row) {
                if (data == null) {
                    return "";
                } else {
                    return data;
                }
            }
        }, {
            "targets": -2, //登录推荐
            "render": function(data, type, row) {
                return "<button  id='content' class='btn  btn-primary  btn-transparent'  type='button' style='margin:auto;'>查看</button>";
            }
        }, {
            "targets": -1, //编辑
            "render": function(data, type, row) {
                return "<a id='editInfo' href='#boss/" + data + "' class='btn btn-sm btn-icon btn-rounded btn-default ' type='button'><i class='fa fa-edit' style='padding-top:7px;padding-left:1px;'></i></a>";
            }
        }, {
            "targets": 0, //第一列隐藏
            "visible": false,
            "searchable": false
        }];
        var resource = "/boss";
        params = pageService.datatables(resource, false, false);
        params.aoColumns = columns;
        params.columnDefs = columnDefs;
        oTable = $('#boss-table').DataTable(params);
        //点击选中一行
        $('.table-hover tbody').on('click', 'tr', function() {
            if ($(this).hasClass('selected')) {
                $(this).removeClass('selected');
            } else {
                oTable.$('tr.selected').removeClass('selected');
                $(this).addClass('selected');
            }
        });
        $('#boss-table').on('draw.dt', function() {
            $timeout(function() {
                pageService.magnificPopup();
            }, 500);
        });

        $('.table-hover tbody').on('click', 'button#content', function() {
            var data = oTable.row($(this).parents('tr')).data();
            pageService.modalTip(oTable, data, "", "boss_content");
        });





    }
]);
