angular.module('adminApp').factory('pageService', ['$http', '$rootScope', '$q', '$location', '$window', '$timeout', '$uibModal',
    function($http, $rootScope, $q, $location, $window, $timeout, $modal) {
        var service = {};
        var msg = "";
        var rdata = {};
        $rootScope.base = base.base_url + "/admin";
        service.setBase = function() {
            $rootScope.base = base.base_url + "/admin";
            return base.base_url + "/admin";
        };
        service.setBases = function() {
            $rootScope.base = base.base_url;
        };
        service.shopAvatar = function() {
            $rootScope.shopAvatar = "http://ac-0k1hxbyo.clouddn.com/716aeee3d6bd34ee.jpg";
        };
        service.manicuristAvatar = function() {
            $rootScope.manicuristAvatar = "http://ac-0k1hxbyo.clouddn.com/1dfb94dffa114242.png";
        };
        service.thumbnail = function(width, height) {
            return "?imageView2/1/w/" + width + "/h/" + height + "/format/jpg/q/80";
        }
        service.get = function(url, data, callback) {
            $.ajax({
                type: 'get',
                url: $rootScope.base + url,
                data: data,
                statusCode: {
                    401: function() {
                        $window.location.href = base.localhost + '/app/auth/login.html';
                    },
                    403: function() {
                        // alert("身份已过期，请重新登录");
                        $window.location.href = base.localhost + '/app/auth/login.html';
                    }
                },
                success: function(data) {
                    callback(data);
                },
                done: function(data) {},
                error: function(data) {
                    // console.log("====service-->get-->error====");
                }
            });
        };
        service.postJson = function(url, data, callback) {
            $.ajax({
                type: 'post',
                url: $rootScope.base + url,
                data: data,
                statusCode: {
                    401: function() {
                        $window.location.href = base.localhost + '/app/auth/login.html';
                    },
                    403: function() {
                        // alert("身份已过期，请重新登录");
                        $window.location.href = base.localhost + '/app/auth/login.html';
                    }
                },
                contentType: "application/json",
                success: function(data) {
                    callback(data);
                },
                done: function(data) {},
                error: function(data) {
                    // console.log("====service-->get-->error====");
                }
            });
        };
        service.post = function(url, data, callback) {
            $.ajax({
                type: 'post',
                url: $rootScope.base + url,
                data: data,
                statusCode: {
                    401: function() {
                        $window.location.href = base.localhost + '/app/auth/login.html';
                    },
                    403: function() {
                        // alert("身份已过期，请重新登录");
                        $window.location.href = base.localhost + '/app/auth/login.html';
                    }
                },
                success: function(data) {
                    callback(data);
                },
                done: function(data) {},
                error: function(data) {
                    // console.log("====service-->get-->error====");
                }
            });
        };
        service.setAjax = function() {
            var data = window.sessionStorage.getItem('eva-user-token');
            $.ajaxSetup({
                headers: {
                    'token': data //设置所有的ajax请求会携带这个token
                }
            });
        };
        /*
        datatables官网api：http://www.datatables.net/reference/api/
         */
        /**
         * [datatables参数初始化]
         * @param  {[type]} url      [请求服务器路径]
         * @param  {[type]} search   [是否启用搜索框：true或false]
         * @param  {[type]} pageable [是否分页：true或false]
         * @return {[type]}          [description]
         */
        service.datatables = function(url, search, pageable) {
            var params = {};
            params.bPaginate = true;
            params.bProcessing = false;
            params.sAjaxSource = $rootScope.base + url;
            params.bFilter = true;
            params.bLengthChange = false;
            params.bSort = false;
            params.bInfo = true;
            // params.aoColumns = columns;
            // params.columnDefs = columnDefs;
            params.iDisplayLength = 10;
            params.bDestroy = true;
            /*
            去除搜索框
             */
            if (!search) {
                params.searching = false;
            }
            /*
            不需要进行分页的datatable 页面配置
             */
            if (!pageable) {
                params.fnServerData = function(sSource, aoData, fnCallback) {
                    $.ajax({
                        "dataType": 'json',
                        "type": "GET",
                        "url": sSource,
                        "data": aoData,
                        'crossDomain': true,
                        'success': function(result) {
                            console.log(result);
                            fnCallback(result); //把返回的数据传给这个方法就可以了,datatable会自动绑定数据的
                        }
                    });
                };
            } else {
                //需要进行分页的datatable的页面配置
                params.bServerSide = true;
                params.fnServerData = function(sSource, aoData, fnCallback, oSettings) {
                    // console.log(oSettings);
                    var page = 0;
                    var length = 0;
                    var sEcho = 0;
                    var key = '';
                    //获取查询参数和分页参数
                    $.each(aoData, function(i, n) {
                        if (n.name == 'iDisplayStart') page = (parseInt(n.value) / 10) + 1;
                        else if (n.name == 'iDisplayLength') length = parseInt(n.value);
                        else if (n.name == 'sEcho') sEcho = parseInt(n.value);
                        else if (n.name == 'sSearch') key = n.value;
                    });
                    // console.log(page);
                    oSettings.jqXHR = $.ajax({
                        "dataType": 'json',
                        "type": "GET",
                        "url": sSource,
                        "data": {
                            page: page,
                            key: key
                        },
                        'crossDomain': true,
                        'success': function(result) {
                          // console.log(result);
                                // params.size = result.data.data.count;
                                result.iTotalRecords = result.data.count;
                                result.iTotalDisplayRecords = result.data.count;
                                result.aaData = result.data.data;
                                result.sEcho = sEcho;
                                fnCallback(result); //把返回的数据传给这个方法就可以了,datatable会自动绑定数据的
                            }
                            // "success": fnCallback
                    });
                };
                params.fnDrawCallback = function(settings) {

                };
                params.fnPreDrawCallback = function(settings) {};
                // params.retrieveData
            }
            params.language = {
                "lengthMenu": "Display _MENU_ records per page", //显示每页显示的记录数
                "zeroRecords": "对不起，未查询到数据", //查询时没有查询到任何数据时的提示信息
                "infoEmpty": "没有数据", //表格无数据时的显示信息
                "sInfo": "显示第 _START_ 条 - 第 _END_ 条 记录　统计 _TOTAL_ 条记录",
                "processing": "数据加载中，请稍等",
                /*自定义分页语言信息*/
                "infoFiltered": "(从 _MAX_ 条记录中筛选得出)",
                "oPaginate": {
                    "sFirst": "首页",
                    "sPrevious": "前一页",
                    "sNext": "后一页",
                    "sLast": "尾页"
                }
            };
            return params;
        };

        /**
         * [通用提示信息方法]
         * @param  {[type]} text     [提示信息（div信息）]
         * @param  {[type]} open     [打开方法 参考官网]
         * @param  {[type]} close    [关闭方式 参考官网]
         * @param  {[type]} position [显示位置 参考官网]
         * @return {[type]}          [description]
         * 官网地址：http://ned.im/noty/#/about
         */
        /**
         * [通用提示信息方法]
         * @param  {[type]} text     [提示文本信息]
         * @param  {[type]} open     [提示信息打开方式]
         * @param  {[type]} close    [提示信息关闭方式]
         * @param  {[type]} position [出现的位置：top;topRight;topLeft;TopCenter;center;centerLeft;centerRight;bottom;bottomLeft;bottomRight;bottomCenter]
         * @param  {[type]} result   [description]
         * @return {[type]}          [description]
         * 官网地址：http://ned.im/noty/#/about
         */
        service.notys = function(text, open, close, position, result) {
            if (close == null || close == "")
                close = "animated fadeOutUp";
            if (open == null || open == "")
                open = "animated fadeInDown";
            if (position == null || position == "")
                position = "topRight";
            return noty({
                text: "<div class='bit top right notification active'><div class='alert alert-" + result + "  media fade in active' style='font-family:Tahoma;font-size:17px;'><p>" + text + "</p></div></div>",
                dismissQueue: true,
                type: 'success',
                layout: position,
                theme: 'made',
                maxVisible: 10,
                animation: {
                    open: open,
                    close: close,
                    easing: 'swing',
                    speed: 100
                },
                timeout: 3500
            });
        };
        // service.notys = function(text, open, close, position, result) {
        //     if (close == null || close == "")
        //         close = "animated fadeOutUp";
        //     if (open == null || open == "")
        //         open = "animated fadeInDown";
        //     if (position == null || position == "")
        //         position = "topRight";
        //     return noty({
        //         text: text,
        //         dismissQueue: true,
        //         type: result,
        //         layout: position,
        //         theme: 'defaultTheme',
        //         template:"<div class='bit top right notification active'><p><span class='noty_text'></span></p></div><div class='noty_close'></div>",
        //         // template    : '<div class="noty_message"><span class="noty_text"></span><div class="noty_close"></div></div>',
        //         maxVisible: 1,
        //         animation: {
        //             open: open,
        //             close: close,
        //             easing: 'swing',
        //             // speed: 100
        //         },
        //         // timeout: 3500
        //     });
        // };
        service.serverError = function(data) {
            return noty({
                text: "<div class='bit top right notification active'><div class='alert alert-danger  media fade in active' style='font-family:Tahoma;font-size:17px;'><p>" + data.errmsg + "</p></div></div>",
                dismissQueue: true,
                type: 'success',
                layout: "topRight",
                theme: 'made',
                maxVisible: 10,
                animation: {
                    open: "animated fadeInDown",
                    close: "animated fadeOutUp",
                    easing: 'swing',
                    speed: 100
                },
                timeout: 4500
            });
        };
        //将文件上传到leancloud
        service.imageUpToLeanCloud = function(file, type, callback) {
            // console.log(type);
            if (type === 'image') {
                // console.log(file.type);
                // console.log(file.type.indexOf('image'));
                if (file.type.indexOf('image') != -1 && file.size <= (1024 * 2000)) {
                    //暂定图片小于2M
                    // console.log(type);
                    var name = "sep_admin.jpg";
                    var avFile = new AV.File(name, file);
                    avFile.save().then(function(data) {
                        // console.log(data);
                        if (callback) {
                            callback(data);
                        }
                    }, function(error) {
                        // console.log(error);
                    });
                }
            }

        };
        service.treeGid = function(columns, dataAdapter) {
            var params = {};
            params.width = "100%";
            params.source = dataAdapter;
            params.theme = 'glacier';
            params.selectionMode = "singleRow";
            params.filterable = true;
            params.autoRowHeight = true;
            params.columns = columns;
            return params;
        };
        service.modalTip = function(oTable, data, status, operate) {
            var modalInstance = $modal.open({
                templateUrl: 'tip/tip.html',
                controller: 'tipCtrl',
                resolve: {
                    datas: function() {
                        return angular.copy(data);
                    },
                    status: function() {
                        return angular.copy(status);
                    },
                    operate: function() {
                        return angular.copy(operate);
                    }
                }
            });
            modalInstance.result.then(function(result) {
                if (result == "success") oTable.ajax.reload(null, false); //删除成功后重新加载table
            }, function(reason) {

            });
        };
        service.modalTips = function(oTable,data,status,operate){
          var modalInstance = $modal.open({
              templateUrl: 'tip/tip.html',
              controller: 'tipCtrl',
              resolve: {
                  datas: function() {
                      return angular.copy(data);
                  },
                  status: function() {
                      return angular.copy(status);
                  },
                  operate: function() {
                      return angular.copy(operate);
                  }
              }
          });
          modalInstance.result.then(function(result) {
              if (result == "success") oTable.api().ajax.reload(null,false); //删除成功后重新加载table
          }, function(reason) {

          });
        };
        service.magnificPopup = function() {
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
        };

        service.summernote = function(id) {
            $("#" + id).summernote({
                height: 300,
                airmode: 'default',
                airMode: $(this).data('airmode') ? $(this).data('airmode') : false,
                airPopover: [
                    ["style", ["style"]],
                    ['color', ['color']],
                    ['font', ['bold', 'underline', 'clear']],
                    ['para', ['ul', 'paragraph']],
                    ['img', ['shapeRounded']],
                    ['table', ['table']],
                    ['insert', ['link', 'picture']]
                ],
                lang: 'zh-CN',
                toolbar: [
                    ["style", ["style"]],
                    ["style", ["bold", "italic", "underline", "clear"]],
                    ["fontsize", ["fontsize"]],
                    ["color", ["color"]],
                    ["para", ["paragraph"]],
                    ["height", ["height"]],
                    ["picture", ["picture"]],
                    ["link", ["link"]],
                    ["table", ["table"]],
                    ['view', ['codeview']],
                ],
                callbacks: {
                    onPaste: function(e) {
                        //  console.log(e);
                        //  console.log('Called event paste');
                    },
                    onImageUpload: function(files) {
                      var token = "zSrOjwqxi3Xh0uaAnnPUSvgUP_cguj9OoudgpWhD:8JHejqUs-eNAi-K1f4c_-3BjqmA=:eyJzY29wZSI6InBpY3R1cmVzIiwiZGVhZGxpbmUiOjI1NzM3MjIzNTV9";
                      var qiNiu = "http://7xpsze.com1.z0.glb.clouddn.com/";
                        var Qiniu_UploadUrl = "http://up.qiniu.com";
                        var xhr = new XMLHttpRequest();
                        xhr.open('POST', Qiniu_UploadUrl, true);
                        var formData, startDate;
                        formData = new FormData();
                        formData.append('token',token);
                        formData.append('file', files[0]);
                        xhr.onreadystatechange = function() {
                            if (xhr.readyState == 4 && xhr.status == 200) {
                              var res = eval("("+xhr.responseText+")");
                              $("#" + id).summernote('insertImage', qiNiu+res.key, files[0].name);
                              // return qiniu+res.key;
                            }
                        };
                        xhr.send(formData);
                        /*var name = 'banner-content.jpg';
                        var avFile = new AV.File(name, files[0]);
                        avFile.save().then(function(data) {
                            $("#" + id).summernote('insertImage', data.attributes.url, files[0].name);
                        }, function(error) {
                            console.log("图片上传失败");
                            // The file either could not be read, or could not be saved to AV.
                        });*/
                    }
                }
            });
        };
        return service;
    }
]);
