// $(function() {
'use strict';
//管理员帐户管理

var AdminApp = angular
    .module('login', [
        'ngAnimate',
        'ngCookies',
        'ngResource',
        'ngRoute',
        'ngSanitize',
        'ngTouch',
        'ui.bootstrap'
    ]).controller('lockscreenCtrl', ['$scope', '$rootScope', '$http', '$location', '$uibModal', function($scope, $rootScope, $http, $location, $modal) {
    console.log('111');
    $scope.state = false;
    $scope.username = window.sessionStorage.getItem('eva-user-info');
    console.log($scope.username);
        /*$.ajaxSetup({
            headers: {
                'X-Auth-Token': data //设置所有的ajax请求会携带这个token
            }
        });
    $.ajax({
            url:'http://192.168.1.20:6888/admin/account/query-self',
            async: false,
            method: "get",
            dataType: "json",
            contentType: "application/json"
        }).success(function(result) {
            $scope.user = result.data;
            console.log(result)
        }).error(function(data) {
            alert("error");
        });*/
    $scope.submit = function(){
         
    };

          $.backstretch(["../../global/images/gallery/login4.jpg", "../../global/images/gallery/login3.jpg", "../../global/images/gallery/login2.jpg", "../../global/images/gallery/login.jpg"], {
        fade: 600,
        duration: 4000
    });
    /* Creation of the Circle Progress */
    var circle = new ProgressBar.Circle('#loader', {
        color: '#aaa',
        strokeWidth: 3,
        trailWidth: 3,
        trailColor: 'rgba(255,255,255,0.1)',
        easing: 'easeInOut',
        duration: 2000,
        from: {
            color: '#319DB5',
            width: 3
        },
        to: {
            color: '#319DB5',
            width: 3
        },
        // Set default step function for all animate calls
        step: function(state, circle) {
            circle.path.setAttribute('stroke', state.color);
            circle.path.setAttribute('stroke-width', state.width);
        }
    });

    $('.btn-primary').click(function(e) {
        e.preventDefault();
        circle.animate(1);
        setTimeout(function() {
            // $('.loader-overlay').removeClass('loaded').fadeIn(150);
            setTimeout(function() {
                var pwd = md5($scope.password);
                console.log($scope.username,$scope.password);
                $.ajax({
                    // url: "http://192.168.1.20:6888/account/sign-in",
                    url: base.base_url+"/account/sign-in",
                    data: {
                        username: $scope.username,
                        password: pwd
                    },
                    method: "POST",
                    // dataType: "json",
                    // contentType: "application/json",
                    statusCode: {
                        401: function() {
                            circle.animate(0);
                            alert( "Username or Password mistake" );
                        },
                        404: function() {
                            circle.animate(0);
                            alert( "Page not found" );
                        }
                    },
                    success: function(data){
                        if(data.code =='200'){
                        window.sessionStorage.setItem('eva-user-token', data.data.token);
                        window.location.href = "../index.html";
                        }else if (data.code == '10003'){
                            circle.animate(0);
                            // $scope.state=true;
                            // $scope.msg = 'username or password is error';
                             alert('username or password is error');
                        }
                        else{
                            circle.animate(0);
                            alert('login error');
                        }
                    },
                    error: function(){
                        console.error("API Error");
                    }
                });
                // window.location = "/app";
            }, 1000);
        },2000);
    });



    /***** DEMO CONTENT, CAN BE REMOVED ******/
    
     /* Builder, demo purpose. Can be removed */
    var accountBuilder = '<div id="account-builder"><form class="form-horizontal" role="form"><div class="row"><div class="col-md-12 clearfix"><i class="fa fa-spin fa-gear"></i> <h3 style="font-size:15px"><strong>Customize</strong> Lockscreen</h3></div><div class="col-xs-6"><div class="form-group"><label class="col-xs-8 control-label">Background Image</label><div class="col-xs-4"><label class="switch m-r-20"><input id="image-cb" type="checkbox" class="switch-input"><span class="switch-label" data-on="On" data-off="Off"></span><span class="switch-handle"></span></label></div></div></div><div class="col-xs-6"><div class="form-group"><label class="col-xs-8 control-label">Background Slides</label><div class="col-xs-4"><label class="switch m-r-20"><input id="slide-cb" type="checkbox" class="switch-input" checked><span class="switch-label" data-on="On" data-off="Off"></span><span class="switch-handle"></span></label></div></div></div><div class="col-xs-6"><div class="form-group"><label class="col-xs-8 control-label">Separated Inputs</label><div class="col-xs-4"><label class="switch m-r-20"><input id="input-cb" type="checkbox" class="switch-input"><span class="switch-label" data-on="On" data-off="Off"></span><span class="switch-handle"></span></label></div></div></div><div class="col-xs-6"><div class="form-group"><label class="col-xs-8 control-label">User Image</label><div class="col-xs-4"><label class="switch m-r-20"><input id="user-cb" type="checkbox" class="switch-input" checked><span class="switch-label" data-on="On" data-off="Off"></span><span class="switch-handle"></span></label></div></div></div></div></form></div>';
    $('.container').append(accountBuilder);
    /* Background Slide */
    $('.bg-slider').backstretch(["../../global/images/gallery/login4.jpg", "../../global/images/gallery/login3.jpg", "../../global/images/gallery/login2.jpg", "../../global/images/gallery/login.jpg"], {
        fade: 600,
        duration: 4000
    });

    /* Show / Hide Builder on Mouseover */
    $("#account-builder").on('mouseenter', function() {
        TweenMax.to($(this), 0.35, {
            css: {
                height: 125,
                width: 500,
                marginLeft: -250
            },
            ease: Circ.easeInOut
        });
    });

    $("#account-builder").on('mouseleave', function() {
        TweenMax.to($(this), 0.35, {
            css: {
                height: 44,
                width: 250,
                marginLeft: -125
            },
            ease: Circ.easeInOut
        });
    });

    /* Hide / Show Background Image */
    $('#image-cb').change(function() {
        if ($(this).is(":checked")) {
            $.backstretch(["../../global/images/gallery/login.jpg"], {
                fade: 600,
                duration: 4000
            });
            $('#slide-cb').attr('checked', false);
        }
        else $.backstretch("destroy");
    });

    /* Add / Remove Slide Image */
    $('#slide-cb').change(function() {
        if ($(this).is(":checked")) {
            $.backstretch(["../../global/images/gallery/login4.jpg", "../../global/images/gallery/login3.jpg", "../../global/images/gallery/login2.jpg", "../../global/images/gallery/login.jpg"], {
                fade: 600,
                duration: 4000
            });
            $('#image-cb').attr('checked', false);
        }
        else {
            $.backstretch("destroy");
        }
    });

    /* Separate Inputs */
    $('#input-cb').change(function() {
        if ($(this).is(":checked")) {
            TweenMax.to($('.input-group .btn'), 0.3, {
                css: {
                    borderRadius: 0
                },
                ease: Circ.easeInOut
            });
            TweenMax.to($('.input-group #password'), 0.3, {
                css: {
                    borderRadius: 0
                },
                ease: Circ.easeInOut,
                onComplete: function() {
                    TweenMax.to($('.input-group'), 0.3, {
                        css: {
                            marginLeft: '-10px',
                            'border-spacing': '10px 0'
                        },
                        ease: Circ.easeInOut,
                        onComplete: function() {
                            $('body').addClass('separate-inputs');
                        }
                    });
                }
            });
        }
        else {
            TweenMax.to($('.input-group .btn'), 0.3, {
                css: {
                    borderRadius: '0 17px 17px 0'
                },
                ease: Circ.easeInOut
            });
            TweenMax.to($('.input-group #password'), 0.3, {
                css: {
                    borderRadius: '17px 0 0 17px'
                },
                ease: Circ.easeInOut,
                onComplete: function() {
                    TweenMax.to($('.input-group'), 0.3, {
                        css: {
                            marginLeft: 0,
                            'border-spacing': '0'
                        },
                        ease: Circ.easeInOut,
                        onComplete: function() {
                            $('body').removeClass('separate-inputs');
                        }
                    });
                }
            });
        }
    });

    /* Hide / Show User Image */
    $('#user-cb').change(function() {
        if ($(this).is(":checked")) {
            TweenMax.to($('.user-image'), 0.3, {
                opacity: 1,
                ease: Circ.easeInOut
            });
            TweenMax.to($('.form-signin'), 0.3, {
                marginLeft: 0,
                ease: Circ.easeInOut
            });
        }
        else {
            TweenMax.to($('.user-image'), 0.3, {
                opacity: 0,
                ease: Circ.easeInOut
            });
            TweenMax.to($('.form-signin'), 0.3, {
                marginLeft: -50,
                ease: Circ.easeInOut
            });
        }
    });
}]);
$(function() {
   
});