
angular.module('adminApp').factory('dashboardService', function () {

    var dashboard = {};
    dashboard.init = function () {
        $('*[data-jquery-clock]').each(function () {
            var t = $(this);
            var seconds = new Date().getSeconds(),
                hours = new Date().getHours(),
                mins = new Date().getMinutes(),
                sdegree = seconds * 6,
                hdegree = hours * 30 + (mins / 2),
                mdegree = mins * 6;
            var updateWatch = function () {
                sdegree += 6;
                if (sdegree % 360 == 0) {
                    mdegree += 6;
                }
                hdegree += (0.1 / 12);
                var srotate = "rotate(" + sdegree + "deg)",
                    hrotate = "rotate(" + hdegree + "deg)",
                    mrotate = "rotate(" + mdegree + "deg)";
                $(".jquery-clock-sec", t).css({
                    "-moz-transform": srotate,
                    "-webkit-transform": srotate,
                    '-ms-transform': srotate
                });
                $(".jquery-clock-hour", t).css({
                    "-moz-transform": hrotate,
                    "-webkit-transform": hrotate,
                    '-ms-transform': hrotate
                });
                $(".jquery-clock-min", t).css({
                    "-moz-transform": mrotate,
                    "-webkit-transform": mrotate,
                    '-ms-transform': mrotate
                });
            }
            updateWatch();
            setInterval(function () {
                $(".jquery-clock-sec, .jquery-clock-hour, .jquery-clock-min").addClass('jquery-clock-transitions');
                updateWatch();
            }, 1000);
            $(window).focus(function () {
                $(".jquery-clock-sec, .jquery-clock-hour, .jquery-clock-min").addClass('jquery-clock-transitions');
            });
            $(window).blur(function () {
                $(".jquery-clock-sec, .jquery-clock-hour, .jquery-clock-min").removeClass('jquery-clock-transitions');
            });
        });
    };

    function generateNotifDashboard(content) {
        var position = 'topRight';
        if ($('body').hasClass('rtl')) position = 'topLeft';
        var n = noty({
            text: content,
            type: 'success',
            layout: position,
            theme: 'made',
            animation: {
                open: 'animated bounceIn',
                close: 'animated bounceOut'
            },
            timeout: 4500,
            callback: {
                onShow: function () {
                    $('#noty_topRight_layout_container, .noty_container_type_success').css('width', 350).css('bottom', 10);
                },
                onCloseClick: function () {
                    setTimeout(function () {
                        $('#quickview-sidebar').addClass('open');
                    }, 500);
                }
            }
        });
    }

    dashboard.setHeights = function () {
        var widgetMapHeight = $('.widget-map').height();
        var pstatHeadHeight = $('.panel-stat-chart').parent().find('.panel-header').height() + 12;
        var pstatBodyHeight = $('.panel-stat-chart').parent().find('.panel-body').height() + 15;
        var pstatheight = widgetMapHeight - pstatHeadHeight - pstatBodyHeight + 30;
        $('.panel-stat-chart').css('height', pstatheight);
        var clockHeight = $('.jquery-clock ').height();
        var widgetProgressHeight = $('.widget-progress-bar').height();
        $('.widget-progress-bar').css('margin-top', widgetMapHeight - clockHeight - widgetProgressHeight - 3);
    }

    return dashboard;

});
