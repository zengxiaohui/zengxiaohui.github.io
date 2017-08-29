'use strict';
//App用户管理
var params = '';
angular.module('adminApp').controller('appUserCtrl', ['$scope', '$rootScope', '$timeout', '$http', '$location', '$uibModal', '$filter', 'pageService',
    function($scope, $rootScope, $timeout, $http, $location, $modal, $filter, pageService) {
        var open = "";
        var close = "";
        var text = "";
        var url = "";
        var status = "";
        var oTable = {};
        $timeout(function() {
            pageService.magnificPopup();
        }, 1000);
        var columns = [{
            "sTitle": "ID",
            "sClass": "centers",
            "mData": "id"
        }, {
            "sTitle": "ID",
            "sClass": "centers",
            "mData": "uid"
        }, {
            "sTitle": "头像",
            "sClass": "centers",
            "mData": "profile.avatar"
        }, {
            "sTitle": "昵称",
            "sClass": "centers",
            "mData": "profile.nickname",
        }, {
            "sTitle": "性别",
            "sClass": "little",
            "mData": "profile.gender"
        }, {
            "sTitle": "所在地",
            "sClass": "centers",
            "mData": "profile.city"
        }, {
            "sTitle": "等级",
            "sClass": "centers",
            "mData": "profile.userLevel"
        }, {
            "sTitle": "联系方式",
            "sClass": "centers",
            "mData": "phone"
        }, {
            "sTitle": "状态",
            "sClass": "centers",
            "mData": "profile.status"
        }, {
            "sTitle": "Banner用户列表",
            "sClass": "centers",
            "mData": "profile.isBanner"
        }, {
            "sTitle": "冻结",
            "sClass": "centers",
            "mData": "status"
        }, {
            "sTitle": "修改",
            "sClass": "center",
            "mData": "profile.status"
        }];

        var columnDefs = [{
                "targets": 2, //显示用户头像
                "render": function(data, type, row) {
                    if (data == null || data == "") {
                        return "<div class='thumbnail magnific'  style='width:80px;height:80px;margin-left:25%;margin:auto;margin-bottom:-2px;' data-mfp-src='../../global/images/avatar.png'><img src='../../global/images/avatar.png'  css='img-circle' style='width:70px;height:70px;'/></div>";
                    } else {
                        return "<div class='thumbnail magnific'  style='width:80px;height:80px;margin-left:25%;margin:auto;margin-bottom:-2px;' data-mfp-src='" + data + "'><img src='" + data + pageService.thumbnail(70, 70) + "'  css='img-circle'/></div>";
                    }
                }
            }, {
                "targets": 3,
                "render": function(data, type, row) {
                    if (data == null) {
                        return "";
                    } else {
                        return data;
                    }
                }
            }, {
                "targets": 4,
                "render": function(data, type, row) {
                    if (data == null) {
                        return "";
                    }
                    if (data == MAN) {
                        return '男';
                    }
                    if (data == WOMEN) {
                        return '女';
                    }
                }
            }, {
                "targets": 5,
                "render": function(data, type, row) {
                    if (data == null) {
                        return "";
                    } else {
                        return data;
                    }
                }
            }, {
                "targets": 6,
                "render": function(data, type, row) {
                    if (data == null) {
                        return "";
                    } else {
                        return data;
                    }
                }
            }, {
                "targets": 7,
                "render": function(data, type, row) {
                    if (data == null) {
                        return "";
                    } else {
                        return data;
                    }
                }
            }, {
                "targets": 8,
                "render": function(data, type, row) {
                    if (data == STATUS_INCOMPLETE) {
                        return "未完善信息";
                    } else if (data == STATUS_NORMAL) {
                        return "正常用户";
                    } else if (data == STATUS_APPLY_PENDING) {
                        return "法师审核中";
                    } else if (data == STATUS_APPLY_FAIL) {
                        return "法师审核失败";
                    }
                }
            }, {
                "targets": -3, //登录推荐
                "render": function(data, type, row) {
                    if (row.status == STATUS_BLOCK) {
                        return "<button  class='btn  btn-default  btn-transparent'  type='button' disabled  style='margin:auto;'><font color='grey'>设置<font></button>";
                    } else if (row.profile.status == STATUS_INCOMPLETE) {
                        return "<button  class='btn  btn-default  btn-transparent'  type='button' disabled  style='margin:auto;'><font color='grey'>未完善信息<font></button>";
                    } else {
                        if (data == HOT_YES) {
                            return "<button  id='bannerNo' class='btn  btn-danger  btn-transparent'  type='button' style='margin:auto;'>取消设置</button>";
                        } else {
                            return "<button  id='bannerYes' class='btn  btn-primary  btn-transparent'  type='button' style='margin:auto;'>设置</button>";
                        }
                    }
                }
            }, {
                "targets": -2, //冻结
                "render": function(data, type, row) {
                    if (data == STATUS_NORMAL)
                        return "<a  id='froze' class='btn  btn-danger  btn-transparent' style='margin:auto;'>冻结</a>";
                    else
                        return "<a  id='active' class='btn  btn-primary  btn-transparent' style='margin:auto;'>激活</a>"
                }
            }, {
                "targets": -1, //编辑
                "render": function(data, type, row) {
                    if (row.status == STATUS_BLOCK) {
                        return "<a class='btn btn-sm btn-icon btn-rounded btn-default ' type='button' disabled><i class='fa fa-edit' style='padding-top:7px;padding-left:1px;'></i></a>";
                    } else {
                        if (data == STATUS_INCOMPLETE) {
                            return "<a class='btn btn-sm btn-icon btn-rounded btn-default ' type='button' disabled><i class='fa fa-edit' style='padding-top:7px;padding-left:1px;'></i></a>";
                        } else {
                            return "<a id='editInfo' class='btn btn-sm btn-icon btn-rounded btn-default ' type='button' href='#editUserInfo/" + row.id + "'><i class='fa fa-edit' style='padding-top:7px;padding-left:1px;'></i></a>";
                        }
                    }
                }
            }, {
                "targets": 0, //第一列隐藏
                "visible": false,
                "searchable": false
            }
            /*, {
                        "targets": -1, //修改用户信息
                        "render": function(data, type, row) {
                            return "<a id='editUserInfo' class='btn btn-sm btn-icon btn-rounded btn-default ' type='button' href='#editUserInfo/" + data + "' style='margin:auto;'><i class='fa fa-edit' style='padding-top:7px;'></i></a>";
                        }
                    }*/
        ];

        var status = '-1,0,1,3';
        var resource = "/account/all?type=" + ROLE_TYPE_USER;
        params = pageService.datatables(resource + "&status=" + status, true, true);
        params.aoColumns = columns;
        params.columnDefs = columnDefs;
        oTable = $('#appUser-table').DataTable(params);
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
            $("div#appUser-table_filter").find('input').attr("placeholder", "输入昵称或手机号");
            $("div#appUser-table_filter").find('input').css("width", "250px");
        });
        //解决跳转到下一页插件不生效
        // $('#appUser-table').on('page.dt', function() {
        //     $timeout(function() {
        //         $('.magnific').each(function() {
        //             $(this).magnificPopup({
        //                 type: 'image',
        //                 gallery: {
        //                     enabled: true
        //                 },
        //                 zoom: {
        //                     enabled: true,
        //                     duration: 300,
        //                     easing: 'ease-in-out',
        //                     opener: function(openerElement) {
        //                         return openerElement.is('img') ? openerElement : openerElement.find('img');
        //                     }
        //                 },
        //                 removalDelay: 300,
        //                 mainClass: 'mfp-fade'
        //             });
        //         });
        //     }, 500);
        // });
        $('#appUser-table').on('draw.dt', function() {
            $timeout(function() {
                pageService.magnificPopup();
            }, 500);
        });
        $('.table-hover tbody').on('click', 'button#bannerYes', function() {
            var data = oTable.row($(this).parents('tr')).data();
            pageService.modalTip(oTable, data, HOT_YES, "banner_set");
        });

        $('.table-hover tbody').on('click', 'button#bannerNo', function() {
            var data = oTable.row($(this).parents('tr')).data();
            pageService.modalTip(oTable, data, HOT_NO, "banner_set");
        });

        $('.table-hover tbody').on('click', 'a#editUserInfo', function() {
            var data = oTable.row($(this).parents('tr')).data();
        });

        $('.table-hover tbody').on('click', 'a#froze', function() {
            var data = oTable.row($(this).parents('tr')).data();
            pageService.modalTip(oTable, data, STATUS_BLOCK, "froze_account");
        });

        $('.table-hover tbody').on('click', 'a#active', function() {
            var data = oTable.row($(this).parents('tr')).data();
            pageService.modalTip(oTable, data, STATUS_NORMAL, "froze_account");
        });

        $('.table-hover tbody').on('click', 'button#records', function() {
            var data = oTable.row($(this).parents('tr')).data();
            var modalInstance = $modal.open({
                templateUrl: 'user/record.html',
                controller: 'recordCtrl',
                resolve: {
                    datas: function() {
                        return angular.copy(data);
                    }
                }
            });
            modalInstance.result.then(function(result) {
                // if (result == "success") oTable.ajax.reload(); //删除成功后重新加载table
            }, function(reason) {});
        });

    }
]).controller('editUserInfoCtrl', ['$scope', '$rootScope', '$routeParams', '$timeout', '$http', '$location', '$uibModal', 'pageService', function($scope, $rootScope, $routeParams, $timeout, $http, $location, $modal, pageService) {
    var data = {};
    $scope.setInfo = function setInfo(result) {
        $scope.user = result.data;
    };
    pageService.setBase();
    pageService.get('/account/query-one', {
        id: $routeParams.id
    }, $scope.setInfo);
    $('.select').click(function() {
        data.msg = "请选用清晰的图片进行裁切，图片模糊是因为图片尺寸太小哦~~"
        data.width = 300;
        data.height = 300;
        data.maxSize = 300;
        data.cssTop = 500;
        data.cssTops = 810;
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
            if (result == "" || result == null || result == "normal") {} else {
                $scope.user.profile.avatar = result;
            }
        }, function(reason) {});
    });
    $timeout(function() {
        $('#man').on('ifChecked', function(event) {
            $scope.user.profile.gender = MAN;
            $scope.$apply();
        });
        $('#woman').on('ifChecked', function(event) {
            $scope.user.profile.gender = WOMEN;
            $scope.$apply();
        });
    });
    $scope.callback = function callback(result) {
        if (result.code == "200") {
            var text = "用户信息修改成功";
            pageService.notys(text, "", "", "", "success");
            $timeout(function() {
                $location.path('/manageUser');
            });
        } else {
            pageService.serverError(result);
        }
    };
    $scope.submit = function() {
        if ($('.form-validation').valid()) {

            pageService.setBase();
            pageService.postJson('/account/user/update', JSON.stringify($scope.user.profile), $scope.callback);
        }
    };
}]).controller('recordCtrl', ['$scope', '$timeout', '$uibModalInstance', 'pageService', 'datas',
    function($scope, $timeout, $modalInstance, pageService, datas) {
        var data = {};
        var dataSource = [];
        var source = [];
        var columns = [];
        var params = {};
        var dataAdapter = "";
        $scope.user = datas;
        $scope.setData = function(result) {
            if (result.code == "200") {
                dataSource = result.data;
                source = {
                    dataType: "json",
                    dataFields: [{
                        name: 'id',
                        type: 'number'
                    }, {
                        name: 'price',
                        type: 'string'
                    }, {
                        name: 'prices',
                        type: 'string'

                    }, {
                        name: 'createTime',
                        type: 'string'

                    }, {
                        name: 'date',
                        type: 'string'

                    }, {
                        name: 'title',
                        type: 'string',
                        map: 'program>title'
                    }, {
                        name: 'realName',
                        type: 'string',
                        map: 'program>master>realName'
                    }],
                    id: 'id',
                    localData: dataSource
                };
                columns = [{
                    text: '消费金额',
                    dataField: 'prices',
                }, {
                    text: '消费日期',
                    dataField: 'date',
                    // filterable:false
                }, {
                    text: '消费专栏标题',
                    dataField: 'title',
                }, {
                    text: '消费专栏作者',
                    dataField: 'realName',
                }];
                dataAdapter = new $.jqx.dataAdapter(source, {
                    beforeLoadComplete(records, textStatus, jqXHR) {
                        var data = new Array();
                        // update the loaded records. Dynamically add EmployeeName and EmployeeID fields.
                        for (var i = 0; i < records.length; i++) {
                            var record = records[i];
                            record.prices = "-" + record.price + "元";
                            record.date = new Date(record.createTime).format("yyyy-MM-dd hh:mm:ss");
                            data.push(record);
                        }
                        return data;
                    }
                });
                params = pageService.treeGid(columns, dataAdapter);
                params.pageable = true;
                params.width = "90%";
                $("#record").jqxDataTable(params);

            } else {
                pageService.serverError(result);
            }
        };


        pageService.setBase();
        pageService.post('/account/program', {
            id: datas.id
        }, $scope.setData);
        $scope.close = function() {
            $modalInstance.close("normal");
        };
    }
]);
