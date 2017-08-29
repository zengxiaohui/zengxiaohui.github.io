function copyrightPos() {
    var windowHeight = $(window).height();
    if (windowHeight < 700) {
        $('.account-copyright').css('position', 'relative').css('margin-top', 40);
    } else {
        $('.account-copyright').css('position', '').css('margin-top', '');
    }
}

$(window).resize(function () {
    copyrightPos();
});

$(function () {
 console.log(base.base_url);
    copyrightPos();
    if ($('body').data('page') == 'login') {

        /* Show / Hide Password Recover Form */
        $('#forget-pwd').on('click', function (e) {
            e.preventDefault();
            $('.form-signin').slideUp(300, function () {
                $('.form-password').slideDown(300);
            });
        });
        $('#login').on('click', function (e) {
            e.preventDefault();
            $('.form-password').slideUp(300, function () {
                $('.form-signin').slideDown(300);
            });
        });

        var form = $(".form-signin");
        /*
        登录信息输入限制和相应的提示信息
         */
        $('#submit-form').click(function (e) {
            var self = this;
            form.validate({
                rules: {
                    username: {
                        required: true,
                        minlength: 3
                    },
                    password: {
                        required: true,
                        minlength: 4,
                        maxlength: 16
                    }
                },
                messages: {
                    username: {
                        required: '请输入您的账号',
                        minlength: '账号长度太短 (最少3个字符)'
                    },
                    password: {
                        required: '请输入密码',
                        minlength: '密码长度太短(最少6个字符)',
                        maxlength: '密码长度太长(最多16个字符)'
                    }
                },
                errorPlacement: function (error, element) {
                    error.insertAfter(element);
                }
            });
            e.preventDefault();
            /*
            登录
             */
            if (form.valid()) {
                // 请求服务器
                var name = $('#username').val();
                var pwd = $('#password').val();
                // var pwd = md5($('#password').val());
                $.ajax({
                    url: base.base_url+"/admin/login",
                    data: {
                        username: name,
                        password: pwd
                    },
                    method: "POST",
                    statusCode: {
                        401: function() {
                            alert( "Username or Password mistake" );
                        },
                        404: function() {
                            alert( "Page not found" );
                        }
                    },
                    success: function(data){
                        console.log(data);
                        if (data.errno === 0) {
                          window.sessionStorage.setItem('eva-user-token', data.data.token);
                            window.location.href = base.localhost + "/app";
                            return true;
                        } else {
                            alert("用户名或密码错误");
                        }
                    },
                    error: function(){
                        console.error("API Error");
                    }
                });
            }
        });

        $('#submit-forget-password').click(function (e) {
            var self = this;
            var form = $(".form-password");
            form.validate({
                rules: {
                    email: {
                        required: true,
                        email: true
                    }
                },
                messages: {
                    email: {
                        required: '请输入邮箱',
                        email: '请输入合法的邮箱'
                    }
                },
                errorPlacement: function (error, element) {
                    error.insertAfter(element);
                }
            });
            e.preventDefault();
            if (form.valid()) {
                var l = Ladda.create(self);
                l.start();
                setTimeout(function () {
                    window.location.href = "/app";
                }, 2000);
            }
        });
        $.backstretch(["../../global/images/gallery/login.jpg"], {
            fade: 600,
            duration: 4000
        });


        /***** DEMO CONTENT, CAN BE REMOVED ******/
        $("#account-builder").on('mouseenter', function () {
            TweenMax.to($(this), 0.35, {
                css: {
                    height: 160,
                    width: 500,
                    left: '37%',
                    'border-bottom-left-radius': 0,
                    'border-top-right-radius': 0,
                    '-moz-border-bottom-left-radius': 0,
                    '-moz-border-top-right-radius': 0,
                    '-webkit-border-bottom-left-radius': 0,
                    '-webkit-border-top-right-radius': 0
                },
                ease: Circ.easeInOut
            });
        });
        $("#account-builder").on('mouseleave', function () {
            TweenMax.to($(this), 0.35, {
                css: {
                    height: 44,
                    width: 250,
                    left: '44%',
                    'border-bottom-left-radius': 20,
                    'border-top-right-radius': 20
                },
                ease: Circ.easeInOut
            });
        });
        /* Hide / Show Social Connect */
        $('#social-cb').change(function () {
            if ($(this).is(":checked")) {
                $('.social-btn').slideDown(function () {
                    $('body').removeClass('no-social');
                });
            } else {
                $('.social-btn').slideUp(function () {
                    $('body').addClass('no-social');
                });
            }
        });
        /* Hide / Show Boxed Form */
        $('#boxed-cb').change(function () {
            if ($(this).is(":checked")) {
                TweenMax.to($('.account-wall'), 0.5, {
                    backgroundColor: 'rgba(255, 255, 255,1)',
                    ease: Circ.easeInOut,
                    onComplete: function () {
                        $('body').addClass('boxed');
                    }
                });
            } else {
                TweenMax.to($('.account-wall'), 0.5, {
                    backgroundColor: 'rgba(255, 255, 255,0)',
                    ease: Circ.easeInOut,
                    onComplete: function () {
                        $('body').removeClass('boxed');
                    }
                });
            }
        });
        /* Hide / Show Background Image */
        $('#image-cb').change(function () {
            if ($(this).is(":checked")) {
                $.backstretch(["../../global/images/gallery/login.jpg"], {
                    fade: 600,
                    duration: 4000
                });
                $('#slide-cb').attr('checked', false);
            } else $.backstretch("destroy");
        });
        /* Add / Remove Slide Image */
        $('#slide-cb').change(function () {
            if ($(this).is(":checked")) {
                $.backstretch(["../../global/images/gallery/login4.jpg", "../../global/images/gallery/login3.jpg", "../../global/images/gallery/login2.jpg", "../../global/images/gallery/login.jpg"], {
                    fade: 600,
                    duration: 4000
                });
                $('#image-cb').attr('checked', false);
            } else {
                $.backstretch("destroy");
            }
        });
        /* Separate Inputs */
        $('#input-cb').change(function () {
            if ($(this).is(":checked")) {
                TweenMax.to($('.username'), 0.3, {
                    css: {
                        marginBottom: 8,
                        'border-bottom-left-radius': 2,
                        'border-bottom-right-radius': 2
                    },
                    ease: Circ.easeInOut,
                    onComplete: function () {
                        $('body').addClass('separate-inputs');
                    }
                });
                TweenMax.to($('.password'), 0.3, {
                    css: {
                        'border-top-left-radius': 2,
                        'border-top-right-radius': 2
                    },
                    ease: Circ.easeInOut
                });
            } else {
                TweenMax.to($('.username'), 0.3, {
                    css: {
                        marginBottom: -1,
                        'border-bottom-left-radius': 0,
                        'border-bottom-right-radius': 0
                    },
                    ease: Circ.easeInOut,
                    onComplete: function () {
                        $('body').removeClass('separate-inputs');
                    }
                });
                TweenMax.to($('.password'), 0.3, {
                    css: {
                        'border-top-left-radius': 0,
                        'border-top-right-radius': 0
                    },
                    ease: Circ.easeInOut
                });
            }
        });
        /* Hide / Show User Image */
        $('#user-cb').change(function () {
            if ($(this).is(":checked")) {
                TweenMax.to($('.user-img'), 0.3, {
                    opacity: 0,
                    ease: Circ.easeInOut
                });
            } else {
                TweenMax.to($('.user-img'), 0.3, {
                    opacity: 1,
                    ease: Circ.easeInOut
                });
            }
        });
    }

    if ($('body').data('page') == 'signup') {

        var form = $(".form-signup");
        $.backstretch(["../../global/images/gallery/login.jpg"], {
            fade: 600,
            duration: 4000
        });
        $("#account-builder").on('mouseenter', function () {
            TweenMax.to($(this), 0.35, {
                css: {
                    height: 160,
                    width: 500,
                    left: '37%',
                    'border-bottom-left-radius': 0,
                    'border-top-right-radius': 0,
                    '-moz-border-bottom-left-radius': 0,
                    '-moz-border-top-right-radius': 0,
                    '-webkit-border-bottom-left-radius': 0,
                    '-webkit-border-top-right-radius': 0
                },
                ease: Circ.easeInOut
            });
        });
        $("#account-builder").on('mouseleave', function () {
            TweenMax.to($(this), 0.35, {
                css: {
                    height: 44,
                    width: 250,
                    left: '44%',
                    'border-bottom-left-radius': 20,
                    'border-top-right-radius': 20
                },
                ease: Circ.easeInOut
            });
        });
        /* Hide / Show Social Connect */
        $('#social-cb').change(function () {
            if ($(this).is(":checked")) {
                $('.social-btn').slideDown(function () {
                    $('body').removeClass('no-social');
                });
            } else {
                $('.social-btn').slideUp(function () {
                    $('body').addClass('no-social');
                });
            }
        });
        /* Hide / Show Boxed Form */
        $('#boxed-cb').change(function () {
            if ($(this).is(":checked")) {
                TweenMax.to($('.account-wall'), 0.5, {
                    backgroundColor: 'rgba(255, 255, 255,1)',
                    ease: Circ.easeInOut,
                    onComplete: function () {
                        $('body').addClass('boxed');
                    }
                });
            } else {
                TweenMax.to($('.account-wall'), 0.5, {
                    backgroundColor: 'rgba(255, 255, 255,0)',
                    ease: Circ.easeInOut,
                    onComplete: function () {
                        $('body').removeClass('boxed');
                    }
                });
            }
        });
        /* Hide / Show Background Image */
        $('#image-cb').change(function () {
            if ($(this).is(":checked")) {
                $.backstretch(["../../global/images/gallery/login.jpg"], {
                    fade: 600,
                    duration: 4000
                });
                $('#slide-cb').attr('checked', false);
            } else $.backstretch("destroy");
        });
        /* Add / Remove Slide Image */
        $('#slide-cb').change(function () {
            if ($(this).is(":checked")) {
                $.backstretch(["../../global/images/gallery/login4.jpg", "../../global/images/gallery/login3.jpg", "../../global/images/gallery/login2.jpg", "../../global/images/gallery/login.jpg"], {
                    fade: 600,
                    duration: 4000
                });
                $('#image-cb').attr('checked', false);
            } else {
                $.backstretch("destroy");
            }
        });
        /* Hide / Show Terms Checkbox */
        $('#terms-cb').change(function () {
            if ($(this).is(":checked")) {
                $('.terms').slideDown(function () {
                    $('body').removeClass('no-terms');
                });
            } else {
                $('.terms').slideUp(function () {
                    $('body').addClass('no-terms');
                });
            }
        });
        /* Hide / Show User Image */
        $('#user-cb').change(function () {
            if ($(this).is(":checked")) {
                TweenMax.to($('.user-img'), 0.3, {
                    opacity: 0,
                    ease: Circ.easeInOut
                });
            } else {
                TweenMax.to($('.user-img'), 0.3, {
                    opacity: 1,
                    ease: Circ.easeInOut
                });
            }
        });
        $('#submit-form').click(function (e) {
            form.validate({
                rules: {
                    username: {
                        required: true,
                        minlength: 3
                    },
                    email: {
                        required: true,
                        email: true
                    },
                    password: {
                        required: true,
                        minlength: 6,
                        maxlength: 16
                    },
                    password2: {
                        required: true,
                        minlength: 6,
                        maxlength: 16,
                        equalTo: '#password'
                    },
                    terms: {
                        required: false
                    }
                },
                messages: {
                    username: {
                        required: '请输入账号',
                        minlength: '请输入最少3个字符'
                    },
                    email: {
                        required: '请输入邮箱',
                        email: '请输入合法的邮箱'
                    },
                    password: {
                        required: '请输入密码',
                        minlength: '最少6个字符',
                        maxlength: '最大16个字符'
                    },
                    password2: {
                        required: '请输入密码',
                        minlength: '最少6个字符',
                        maxlength: '最大16个字符',
                        equalTo: '2个密码必须相同'
                    },
                    terms: {
                        required: '你必须同意条款'
                    }
                },
                errorPlacement: function (error, element) {
                    if (element.is(":radio") || element.is(":checkbox")) {
                        element.closest('.option-group').after(error);
                    } else {
                        error.insertAfter(element);
                    }
                }
            });
            e.preventDefault();
            if (form.valid()) {
                $(this).addClass('ladda-button');
                alert('valide');
                var l = Ladda.create(this);
                l.start();
                setTimeout(function () {
                    window.location.href = "/app";
                }, 2000);
            } else {
                // alert('not valid');
            }
        });

    }
});
