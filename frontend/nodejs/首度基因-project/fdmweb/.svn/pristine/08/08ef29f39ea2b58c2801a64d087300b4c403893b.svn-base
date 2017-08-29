$(function(){
	   $("#submit").click(function(){
			   console.log("dasd");
			  func();
	   })
	   
})
	function func(){
	   	 var username=$("#username").val();
		  var password=$("#password").val();
		  var infor={
				 username:username,
				 password:password
				  
		  }
		 var url="../develop/User_login"; 
			 sendNetworkReq(url,infor,function(result){
				 var result1= JSON.parse(result);
				 console.log(result1.localUserId);
				 if(result==1001){
					 alert("密码错误");
					 
					 window.location.href="index.html";
				 }else{
					 console.log(result1.localSecToken+"====="+result1.localUserId);
					$.cookie("localSecToken",result1.localSecToken);
					$.cookie("senderId",result1.localUserId); 
					 window.location.href="userlist.jsp";
				 }
			 });
		   }
	