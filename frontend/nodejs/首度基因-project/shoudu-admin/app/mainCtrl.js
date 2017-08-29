angular.module('adminApp').controller('mainCtrl', ['$scope', '$rootScope', '$uibModal', '$timeout', 'applicationService', 'quickViewService', 'builderService', 'pluginsService', 'pageService', '$location', '$window',
    function($scope, $rootScope, $modal, $timeout, applicationService, quickViewService, builderService, pluginsService, pageService, $location, $window) {
        pageService.setAjax();
        $scope.getUser = function(data) {
            $scope.user = data.data;
            // 根据登录用户的角色跳转到不同的首页
            if ($scope.user.role != 'ROLE_ADMIN') {
                var src = [];
                $.each($scope.allMenu, function(i, menu) {
                    if (menu.src != null)
                        src.push("/" + menu.src);
                });
                if ($.inArray($location.$$path, src) == -1) {
                    $.each($scope.allMenu, function(i, menu) {
                        if (menu.childNum == 0) {
                            $timeout(function() {
                                $location.path('/' + menu.src);
                            });
                            return false;
                        } else {
                            $.each($scope.childmenus, function(i, childmenu) {
                                if (childmenu.fatherId == menu.id) {
                                    $timeout(function() {
                                        $location.path('/' + childmenu.src);
                                    });
                                    return false;
                                }
                            });
                            return false;
                        }
                    });
                }
            }

        };
        $scope.getMenus = function getMenus(result) {
            // console.log(result);
            $scope.menus = [];
            $scope.childmenus = [];
            $.each(result.data, function(i, menu) {
                if (menu.fatherId == "0") {
                    $scope.menus.push(menu);
                } else {
                    $scope.childmenus.push(menu);
                }
                if (menu.src == $location.$$path.substring(1)) {
                    $scope.temp = menu;
                }
            });
            $scope.allMenu = result.data;
            $scope.$apply();
            //第二种生成菜单方法
            $.each($scope.menus, function(i, fatherMenu) {
                if (fatherMenu.childNum != 0) {
                    $("#" + fatherMenu.id).addClass("nav-parent");
                    var html = '<a><i class=" ' + fatherMenu.icon + '"></i>  <span>' + fatherMenu.name + '</span><span class="fa arrow"></span></a>';
                    $("#" + fatherMenu.id).prepend(html);

                } else {
                    $("#" + fatherMenu.id).html('<a href="#' + fatherMenu.src + '" ><i class=" ' + fatherMenu.icon + '"></i>  <span>' + fatherMenu.name + '</a>');
                }
            });
            if ($scope.temp != null) {
                if ($scope.temp.fatherId != 0) {
                    $("#" + $scope.temp.fatherId).addClass("active");
                } else {
                    $("#" + $scope.temp.id).addClass("active");
                }
            }
            pageService.setBase();
            pageService.post("/query-self", "", $scope.getUser);
        };
        /*  $scope.changeMenu = function(menu) {
            // console.log(menu);
            if(menu.childNum == 0){
              $(".nav-sidebar> li").each(function(){
                if( $(this).hasClass("active")){
                  $(this).removeClass("active");
                  console.log($(this).next("a").children("span").eq(1));

                  $(this).find("ul").css("display","none");
                  $timeout(function(){
                    $(this).next("a").children("span").eq(1).removeClass("active");
                  });

                  // console.log("111");
                }
              });
              // $("#"+menu.id).addClass("active");
            }
          };*/
        $(document).ready(function() {
            applicationService.init();
            quickViewService.init();
            builderService.init();
            pluginsService.init();
            Dropzone.autoDiscover = false;
            pageService.setBase();
            pageService.setAjax();
            // pageService.get("/getMenu", "", $scope.getMenus);
            console.log($location.$$path);

        });
        $scope.$on('$viewContentLoaded', function() {
            var token = window.sessionStorage.getItem('eva-user-token');
            pluginsService.init();
            applicationService.customScroll();
            applicationService.handlePanelAction();
            $('.nav.nav-sidebar .nav-active').removeClass('nav-active active');
            // $('.nav.nav-sidebar .active:not(.nav-parent)').closest('.nav-parent').addClass('nav-active active');
            if ($location.$$path == '/' || $location.$$path == '/layout-api') {
                $('.nav.nav-sidebar .nav-parent').removeClass('nav-active active');
                $('.nav.nav-sidebar .nav-parent .children').removeClass('nav-active active');
                if ($('body').hasClass('sidebar-collapsed') && !$('body').hasClass('sidebar-hover')) return;
                if ($('body').hasClass('submenu-hover')) return;
                $('.nav.nav-sidebar .nav-parent .children').slideUp(200);
                $('.nav-sidebar .arrow').removeClass('active');
            }
            if ($location.$$path == '/') {
                $('body').addClass('dashboard');
            } else {
                $('body').removeClass('dashboard');
            }
        });
        $scope.$on('$routeChangeStart', function(scope, next, current) {
            console.log("-------$routeChangeStart--------");
            if (!next.allowAnonymous) { // 需要用户认证
                console.log('Authentication required');
                if (!sessionStorage.getItem("eva-user-token")) {
                    console.log('Authentication is invalid, redirect to login.');
                    $window.location.href = base.localhost + '/app/auth/login.html';
                } else {

                }
            }
        });
        $('#lockscreen').click(function() {
            window.sessionStorage.setItem('eva-user-info', $scope.user.username);
            window.sessionStorage.removeItem('eva-user-token');
        });
        $('#logout').click(function() {
            window.sessionStorage.removeItem('eva-user-token');
        });
        $('#reset').click(function() {
            var modalInstance = $modal.open({
                templateUrl: 'user/resetPwd.html',
                controller: 'resetPwdCtrl'
            });
            modalInstance.result.then(function(result) {
                if (result == "success") {}
            }, function(reason) {
                console.log(reason); //点击空白区域，总会输出backdrop click，点击取消，则会暑促cancel
            });
        });

        $scope.isActive = function(viewLocation) {
            return viewLocation === $location.path();
        };
    }
]).controller('resetPwdCtrl', ['$scope', '$rootScope', '$uibModal', '$uibModalInstance', '$timeout', 'pageService', function($scope, $rootScope, $modal, $modalInstance, $timeout, pageService) {
    var open = "animated fadeInDown";
    var close = "animated fadeOutUp";
    var text = " ";
    var position = "topRight";
    $scope.close = function() {
        $modalInstance.close("normal");
    };
    $timeout(function() {
        $('.form-validation').validate();
    });
    $scope.resetPwd = function(result) {
      console.log(result);
        if (result.errno == "0") {
            $modalInstance.close("success");
            text = "密码修改成功！";
            pageService.notys(text, open, close, position, "success");
        } else {
            pageService.serverError(result);
        }
    };
    $scope.submit = function() {
        if ($('.form-validation').valid()) {
            if ($scope.user.oldPwd == $scope.user.newPwd) {
                text = "新密码和旧密码不能相同";
                pageService.notys(text, open, close, position, "danger");
            } else {
                $scope.user.old = $scope.user.oldPwd;
                $scope.user.new = $scope.user.newPwd;
                console.log($scope.user);
                pageService.setBase();
                pageService.post('/modify', $scope.user, $scope.resetPwd);
            }
        }
    };
}]);
