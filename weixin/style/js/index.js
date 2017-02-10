$(function() {
    $('#home_slider').flexslider({
        animation : 'slide'
    });
    $('#subslider1').flexslider({
        animation : 'slide'
    });
    $('#subslider2').flexslider({
        animation : 'slide'
    });
    var startX, startY, endX, endY;
    var ts3d=0,slong=Math.abs($("#slide").outerWidth()-$(window).width());
    document.getElementById("slide").addEventListener("touchstart", touchStart, false);
    document.getElementById("slide").addEventListener("touchmove", touchMove, false);
    document.getElementById("slide").addEventListener("touchend", touchEnd, false);
    function touchStart(event) {
         var touch = event.touches[0];
         startY = touch.pageY;
         startX = touch.pageX;
     }
     function touchMove(event) {
         var touch = event.touches[0];
         endX = touch.pageX;
         endX-startX<0?ts3d = ts3d+Math.abs(endX-startX):ts3d = ts3d-Math.abs(endX-startX);
         ts3d<=0?ts3d=0:"";
         ts3d>=slong?ts3d=slong:"";
         $("#slide").css('transform', "translate3d(-"+ts3d+"px, 0px, 0px)");
     }
     function touchEnd(event) {
        $("#slide").css('transition', "-webkit-transform 0.5s cubic-bezier(0.333333, 0.666667, 0.666667, 1)");
    }
});
