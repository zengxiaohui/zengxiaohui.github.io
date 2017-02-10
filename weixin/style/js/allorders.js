$(function(){
	$(".tab li").click(function(event) {
		$(this).addClass('tlact').siblings().removeClass('tlact');
	});
});