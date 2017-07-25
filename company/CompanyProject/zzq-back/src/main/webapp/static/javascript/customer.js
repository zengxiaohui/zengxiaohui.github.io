var customer = {
		//封装客户相关的ajax的url
		url : {
			query:function(){
				return base.getRootPath()+'/customerInfo/list';
			},
			save : function(){
				return base.getRootPath()+'/customerInfo/save';
			},
			edit : function(){
				return base.getRootPath() + '/customerInfo/edit';
			},
			deleteUrl : function(){
				return base.getRootPath() + "/customerInfo/delete";
			}
		},
		//切换显示对象
		toggle2Object:function(tableBox,formBox){
			$(tableBox).stop(true,true).toggle("slow"),$(formBox).stop(true,true).toggle("slow");
		},
		//清空form中的全部内容
		clearFormContent : function(){
			$(".form_table").attr('customerInfoId',"");
			$("input[name='name']").val("");
			$("#sex-m").prop('checked',true);
			$("input[name='mobile']").val("");
			$("input[name='detailAddress']").val("");
			$("textarea[name='remark']").val("");
		},
		//查询业主信息
		queryCustomer : function(){
			var name = $("input[name='queryName']").val() ? $("input[name='queryName']").val() : "";
			var sex = $("select[name='querySex']").val() ? $("select[name='querySex']").val() : "";
			var mobile = $("input[name='queryMobile']").val() ? $("input[name='queryMobile']").val() : "";
			var pageNum = $(".pages").attr("pagenum") ? $(".pages").attr("pagenum") : "";
			window.location.href = customer.url.query() + "?name="+name+"&sex="+sex+"&mobile="+mobile+"&pageNum="+pageNum;
		},
		//保存业主信息
		saveCustomer: function(){
			var sexVal = $("#sex-m").prop('checked') ? 0 : 1 ;
			var sexShow = $("#sex-m").prop('checked') ? "男" : "女" ;
			var param = {'id':$(".form_table").attr('customerInfoId'),'name':$("input[name='name']").val(),"sex":sexVal,"mobile":$("input[name='mobile']").val(),"detailAddress":$("input[name='detailAddress']").val(),"remark":$("textarea[name='remark']").val()};
			if(!base.checkMobilePhone($("input[name='mobile']").val())){
				alert("手机号格式不对");
				return false;
			}
			$.ajax({
				type:"post",
				url: customer.url.save(),
				dataType:"json",
				async:false,
				cache:false,
				contentType: "application/x-www-form-urlencoded; charset=utf-8",
				data:param,
				beforeSend : function(XMLHttpRequest) {
					 XMLHttpRequest.setRequestHeader("X-Custom-Header1", "Bar");
				},  
				success:function(data){
					if(data.flag){
						$(".form_table").attr('customerInfoId') ? $("#customerInfoTable tr[customerInfoId="+$(".form_table").attr('customerInfoId')+"]").remove() : "";
						var html = '<tr customerinfoid="'+ data.customerInfoId +'"><td>'+$("input[name='name']").val()+
								   '</td><td>'+sexShow+
								   '</td><td>'+$("input[name='mobile']").val()+
								   '</td><td>'+$("input[name='detailAddress']").val()+
								   '</td><td>'+$("textarea[name='remark']").val()+
								   '</td><td><a href="javascript:void(0);" onclick="customer.editCustomer('+ data.customerInfoId +');" class="edit" title="编辑"></a><a href="javascript:void(0);" onclick="customer.deleteCustomer('+ data.customerInfoId +',this);" class="delete" title="删除"></a></td></tr>';
						$("#customerInfoTable").append(html);
						customer.toggle2Object(".table-box",".form-box");
						customer.clearFormContent();
					}else{
						alert(data.msg);
					}
				},
				error:function(){
					alert("系统或网络异常");
				}
			});
		},
		//编辑业主信息
		editCustomer:function(customerId){
			$.ajax({
				type:"post",
				url: customer.url.edit(),
				dataType:"json",
				async:false,
				cache:false,
				contentType: "application/x-www-form-urlencoded; charset=utf-8",
				data:{"customerId":customerId},
				beforeSend : function(XMLHttpRequest) {
					 XMLHttpRequest.setRequestHeader("X-Custom-Header1", "Bar");
				},  
				success:function(data){
					if(data.flag){
						$(".form_table").attr('customerInfoId',data.customerInfo.id);
						$("input[name='name']").val(data.customerInfo.name);
						data.customerInfo.sex ? $("#sex-m").prop('checked',true) : $("#sex-w").prop('checked',true);
						$("input[name='mobile']").val(data.customerInfo.mobile);
						$("input[name='detailAddress']").val(data.customerInfo.detailAddress);
						$("textarea[name='remark']").val(data.customerInfo.remark);
						customer.toggle2Object(".table-box",".form-box");
					}else{
						alert(data.msg);
					}
				},
				error:function(){
					alert("系统或网络异常");
				}
			});
		},
		//删除业主信息
		deleteCustomer : function(customerId,obj){
			$.ajax({
				type:"post",
				url: customer.url.deleteUrl(),
				dataType:"json",
				data:{'customerId':customerId},
				beforeSend : function(XMLHttpRequest) {},  
				success:function(data){
					if(data.flag){
						$(obj).parents("tr").remove();
					}else{
						alert(data.msg);
					}
				},
				error:function(){
					alert("系统或网络异常");
				}
			});
		},
		//客户列表页逻辑
		list:{
			init : function(params){
				$(".submit").click(function(event) {
					customer.saveCustomer();
				});
				$(".add,.back").click(function(){
					customer.toggle2Object(".table-box",".form-box");
				});
			}
		}
}
$(function(){
	//使用EL表达式传入参数
	customer.list.init({});
});