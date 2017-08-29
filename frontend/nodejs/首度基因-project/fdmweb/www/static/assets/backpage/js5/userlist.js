$(function(){
	var localSecToken=$.cookie("localSecToken");
	
	var senderId=$.cookie("senderId");
	
	
	//导出excel表个
	
	
	var url ="../develop/User_getUserList1";
	
	var infor ={
			SecToken:localSecToken,
			senderId:senderId
	}
	
	sendNetworkReq(url,infor,function(result){
		var result1 = JSON.parse(result);                                         
		tableshow(result1);
	})
	
	
	 function tableshow(result1){
		//console.log(result1.localUserList);

		$('#table').bootstrapTable('load', result1.localUserList);
		
		//return result1;
		
	}
	
	
	//删除方法
	var $table = $('#table'), $remove = $('#delete');
	$table.on('check.bs.table uncheck.bs.table check-all.bs.table uncheck-all.bs.table', function () {
        $remove.prop('disabled', !$table.bootstrapTable('getSelections').length);
    });
    $remove.click(function () {
        var ids = $.map($table.bootstrapTable('getSelections'), function (row) {
            return row.localUserId
        });
        console.log(typeof ids);
       console.log(ids[1]);
       for(var i=0;i<ids.length;i++){
    	   deleteUser(ids[i]);
       }
        $remove.prop('disabled', true);
    });
	
	function deleteUser(ids){
		var userId=ids;
		var infor={
				SecToken:localSecToken,
				senderId:senderId,
				userId:userId
		}
		var url="../develop/User_deleteUser";
		
		sendNetworkReq(url,infor,function(result){
			var result1 = JSON.parse(result);
			console.log(result1);
			window.location.href="userlist.jsp";
		})
	}
	//添加方法
	function addUser(url,infor){
		sendNetworkReq(url,infor,function(result){
			var result1 = JSON.parse(result);
			console.log(result1);
			window.location.href="userlist.jsp";
		})
	}
})