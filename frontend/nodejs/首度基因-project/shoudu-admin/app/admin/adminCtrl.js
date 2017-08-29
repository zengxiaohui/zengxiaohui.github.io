'use strict';
//管理员帐户管理
var params = '';
angular.module('adminApp').controller('adminCtrl', ['$scope', '$rootScope', '$http', '$location', '$uibModal', 'pageService',
        function($scope, $rootScope, $http, $location, $modal, pageService) {
            var open = "";
            var close = "";
            var text = "";
            var url = "";
            var status = "";
            var data = {};
            var columns = [{
                "sTitle": "id",
                "mData": "id"
            }, {
                "sTitle": "用户名",
                "mData": "username"
            }, {
                "sTitle": "角色",
                "mData": "role"
            }, {
                "sTitle": "初始化密码",
                "sClass": "center",
                "mData": "status"
            }, {
                "sTitle": "操作",
                "sClass": "center",
                "mData": "status"
            }, {
                "sTitle": "修改",
                "sClass": "center",
                "mData": "id"
            }, {
                "sTitle": "删除",
                "sClass": "center",
                "mData": "id"
            }];
            var columnDefs = [{
                "targets": 2,
                "render": function(data, type, row) {
                    if (data == "ROLE_NORMAL")
                        return "普通管理员";
                    else
                        return "超级管理员";
                }
            }, {
                "targets": -4, //操作
                "render": function(data, type, row) {
                    if (data == "0") return "<button  id='init' class='btn  btn-primary  btn-transparent'  type='button' style='margin:auto;'>初始化密码</button>";
                    else return "<button  id='init' class='btn  btn-default  btn-transparent'  type='button' disabled  style='margin:auto;'><font color='grey'>初始化密码<font></button>";
                }
            }, {
                "targets": -3, //操作
                "render": function(data, type, row) {
                    if (data == "1") return "<button  id='active' class='btn  btn-warning btn-transparent'  type='button' style='margin:auto;'>激活</button>";
                    else return "<button  id='froze' class='btn  btn-primary btn-transparent'  type='button' style='margin:auto;'>冻结</button>";
                }
            }, {
                "targets": -2, //编辑
                "render": function(data, type, row) {
                    return "<a id='editInfo' class='btn btn-sm btn-icon btn-rounded btn-default ' type='button'><i class='fa fa-edit' style='padding-top:7px;padding-left:1px;'></i></a>";
                }
            }, {
                "targets": -1, //删除
                "render": function(data, type, row) {
                    return "<a  id='del' class='btn btn-sm btn-icon btn-rounded btn-danger' type='button'  ><i class='fa fa-trash-o' style='padding-top:7px;padding-left:1px;'></i></a>";
                }
            }, {
                "targets": 0, //第一列隐藏
                "visible": false,
                "searchable": false
            }];
            pageService.setAjax();
            pageService.setBase();
            var resource = "/query-all";
            params = pageService.datatables(resource, false, false);
            params.columns = columns;
            params.columnDefs = columnDefs;
            var oTable = $('#admin-table').DataTable(params);
            $('.table-hover tbody').on('click', 'tr', function() {
                if ($(this).hasClass('selected')) {
                    $(this).removeClass('selected');
                } else {
                    oTable.$('tr.selected').removeClass('selected');
                    $(this).addClass('selected');
                }
            });
            $('.table-hover tbody').on('click', 'button#preview', function() {
                var data = oTable.row($(this).parents('tr')).data();
                var modalInstance = $modal.open({
                    templateUrl: 'admin/loginInfo.html',
                    controller: 'loginInfoCtrl',
                    resolve: {
                        datas: function() {
                            return angular.copy(data);
                        }
                    }
                });
                modalInstance.result.then(function(result) {
                    // if (result == "success") oTable.ajax.reload(); //删除成功后重新加载table
                }, function(reason) {
                    console.log(reason); //点击空白区域，总会输出backdrop click，点击取消，则会暑促cancel
                });
            });

            $('#addAdmin').click(function() {
                console.log("=======添加admin账户操作========");
                var modalInstance = $modal.open({
                    templateUrl: 'admin/adminAdd.html',
                    controller: 'adminAddCtrl',
                    resolve: {
                        datas: function() {
                            return angular.copy(data);
                        },
                        operate: function() {
                            return angular.copy("add");
                        }
                    }
                });
                modalInstance.result.then(function(result) {
                    if (result == "success") oTable.ajax.reload();
                }, function(reason) {});

            });
            $('.table-hover tbody').on('click', 'a#editInfo', function() {
                console.log("=======修改admin账户操作========");
                data = oTable.row($(this).parents('tr')).data();
                var modalInstance = $modal.open({
                    templateUrl: 'admin/adminAdd.html',
                    controller: 'adminAddCtrl',
                    resolve: {
                        datas: function() {
                            return angular.copy(data);
                        },
                        operate: function() {
                            return angular.copy("edit");
                        }
                    }
                });
                modalInstance.result.then(function(result) {
                    if (result == "success") oTable.ajax.reload();
                }, function(reason) {});

            });
            $('.table-hover tbody').on('click', 'a#del', function() {
                console.log("=======删除admin账户操作========");
                data = oTable.row($(this).parents('tr')).data();
                pageService.modalTip(oTable, data, "", "del_admin");
            });
            $('.table-hover tbody').on('click', 'button#init', function() {
                console.log("=======初始化管理员密码========");
                data = oTable.row($(this).parents('tr')).data();
                pageService.modalTip(oTable, data, "", "init_pass");
            });
            $('.table-hover tbody').on('click', 'button#froze', function() {
                console.log("=======冻结管理员账号========");
                data = oTable.row($(this).parents('tr')).data();
                pageService.modalTip(oTable, data, STATUS_BLOCK, "admin_operate");
            });
            $('.table-hover tbody').on('click', 'button#active', function() {
                console.log("=======激活管理员账号========");
                data = oTable.row($(this).parents('tr')).data();
                pageService.modalTip(oTable, data, STATUS_NORMAL, "admin_operate");
            });
        }
    ])
    .controller('adminAddCtrl', ['$scope', '$rootScope', '$uibModal', '$uibModalInstance', '$timeout', 'pageService', 'datas', 'operate',
        function($scope, $rootScope, $modal, $modalInstance, $timeout, pageService, datas, operate) {
            var open = "";
            var close = "";
            var text = "";
            var url = "/account/new";
            var path = "";
            $timeout(function() {
                $('#tree2').jstree({
                    'core': {
                        'data': $scope.menus
                    },
                    "plugins": ["checkbox"],
                });

            }, 300);
            $scope.getMenus = function getMenus(result) {
                $scope.menus = [];


                $.each(result.data, function(i, menu) {
                    var temp = {};
                    if (menu.id == 2)
                        return;
                    temp.id = menu.id;
                    temp.text = menu.name;
                    temp.fatherId = menu.fatherId;
                    temp.children = [];
                    if (menu.childNum != 0) {
                        $.each(result.data, function(i, menus) {
                            var temps = {};
                            if (menus.fatherId == menu.id) {
                                temps.id = menus.id;
                                temps.text = menus.name;
                                temps.fatherId = menus.fatherId;
                                temp.children.push(temps);
                            }
                        });
                    }
                    if (menu.fatherId == 0)
                        $scope.menus.push(temp);
                });
                console.log($scope.menus);
                $scope.$apply();
            };
            $scope.setData = function(result) {
                if (result.code == "200") {
                    var arr = result.data.result.split(",");
                    $timeout(function() {
                        $.each(arr, function(i, menu) {
                            var node = $('#tree2').jstree().get_node(menu);
                            if (node.parents.length == 2) {
                                $('#tree2').jstree().check_node(menu);
                            } else {
                                console.log($('#tree2').jstree().is_leaf(menu))
                                if ($('#tree2').jstree().is_leaf(menu)) {
                                    $('#tree2').jstree().check_node(menu);
                                } else {
                                    $('#tree2').jstree().open_node(menu);
                                }

                            }
                        });
                    }, 400);

                } else {
                    pageService.serverError(result);
                }
            }
            pageService.get("/getMenu", "", $scope.getMenus);
            if (operate == "edit") {
                $scope.user = datas;
                url = "/edit";
                pageService.setBase();
                pageService.post("/query-one", {
                    id: datas.id
                }, $scope.setData);
            } else {
                $scope.user = {};
                $scope.user.role = "ROLE_NORMAL";
                url = "/insert";
            }
            $scope.close = function() {
                $modalInstance.close("normal");
            };

            $scope.callback = function(result) {
                if (result.code == "200") {
                    if (operate == "add") {
                        text = "管理员账号添加成功";
                    } else {
                        text = "管理员信息更新成功";
                    }
                    pageService.notys(text, "", "", "", "success");
                    $modalInstance.close("success");
                } else {
                    pageService.serverError(result);
                }
            };
            $scope.submit = function() {
                var parents = $('#tree2').jstree().get_checked(true);
                var results = $('#tree2').jstree('get_checked');
                $.each(parents, function(i, parent) {
                    if (parent.parents.length > 1) {
                        if (!$('#tree2').jstree().is_checked(parent.parent)) {
                            var num = 0;
                            $.each(results, function(i, result) {
                                if (result == parent.parent) {
                                    num++;
                                }
                            });
                            if (num == 0) {
                                results.push(parent.parent);
                            }
                        }
                    }
                });
                $scope.user.role = results.join(",");
                // pageService.post(url, $scope.user, $scope.callback);
                // console.log(results);
                var reg = /^[1-9]+[0-9]*]*$/;
                var zh = /^[\u4E00-\u9FA5]+$/;
                var name = /[@#\$%\^&\*]+/g;
                var number = /^[0-9]+.?[0-9]*$/;
                var test = /^[a-zA-Z\d-]+$/;
                if ($('.form-validation').valid()) {
                    if ($scope.user.username == "" || $scope.user.username == null) {
                        var length = $.trim($('#username').val()).length;
                        if (length == 0)
                            text = "用户名不能全为空格";
                        else
                            text = "用户名不得低于三个有效字符（不包括首尾空格）";
                        pageService.notys(text, "", "", "", "danger");
                    } else if (name.test($scope.user.username)) {
                        text = "用户名不得包含‘@#$%^&*’特殊字符";
                        pageService.notys(text, "", "", "", "danger");
                    } else if (number.test($scope.user.username)) {
                        text = "用户名不能全为数字";
                        pageService.notys(text, "", "", "", "danger");
                    } else if (results.length == 0) {
                        text = "请为管理员分配菜单";
                        pageService.notys(text, "", "", "", "danger");
                    } else {
                        pageService.setBase();
                        pageService.post(url, $scope.user, $scope.callback);
                    }
                }
            };
        }
    ]).controller('loginInfoCtrl', ['$scope', '$timeout', '$uibModalInstance', 'pageService', 'datas',
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
                            name: 'createTime',
                            type: 'string'
                        }, {
                            name: 'address',
                            type: 'string'

                        }, {
                            name: 'date',
                            type: 'string'
                        }],
                        id: 'id',
                        localData: dataSource
                    };
                    columns = [{
                        text: '登录日期',
                        dataField: 'date',
                    }, {
                        text: '登录IP',
                        dataField: 'address',
                        filterable: false
                    }];
                    dataAdapter = new $.jqx.dataAdapter(source, {
                        beforeLoadComplete(records, textStatus, jqXHR) {
                            var data = new Array();
                            // update the loaded records. Dynamically add EmployeeName and EmployeeID fields.
                            for (var i = 0; i < records.length; i++) {
                                var record = records[i];
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
            pageService.get('/log/queryById', {
                id: datas.id
            }, $scope.setData);
            $scope.close = function() {
                $modalInstance.close("normal");
            };
        }
    ]);
