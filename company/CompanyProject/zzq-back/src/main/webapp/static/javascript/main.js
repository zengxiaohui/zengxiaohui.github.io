var main = {
	init:function(params){
		$(".sidebar ul li").click(function(event){
			$(this).addClass("current").siblings().removeClass("current");
		});
		$(".sidebar ul li ul li a").click(function(event) {
			$(this).parents(".sidebar").find('.sub_menu li a').removeClass('current').next(".right_arr").remove();
			$(this).addClass("current").after("<span class='right_arr'></span>");
			$("#iFrame1").attr('src', $(this).attr('href'));
			return false;
		});
	}
}
$(function(){
	main.init({});
});