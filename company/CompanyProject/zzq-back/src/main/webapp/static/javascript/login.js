var login = {
		submitForm:function(){
			$("#login_form").submit();
		},
		init:function(params){
			//用户名和密码回车提交登录
			$("input[name='username'],input[name='password']").keyup(function(event) {
				event.keyCode == 13 ? login.submitForm() : "";
			});
			$("#submit").click(function(){
				login.submitForm();
			});
			$('.item>input').each(function(index, el) {
				$(this).bind({
					'focus':function(event) {$(this).parent().addClass('item_focus');},
					'blur':function(event){$(this).parent().removeClass('item_focus');}
				});
			});
		}
}
$(function(){
	login.init({});
});