"use strict"
//http://192.168.2.119/carlweb/develop/Login_login?name=root&password=111111
var address="";

function sendNetworkReq(method,params,callback){
	requestUrl(address+method,method,params,callback);
}
	
function requestUrl(url,method,params,callback){
		var k;
		var str="";
		for(k in params){
			str+="&"+k+"="+params[k];
		}
		console.log(str);
		
		$.ajax({
			type:"POST",
			url:url,
			async:true,
			dataType:"json",
			data:str,
			success:function(e){
				callback(JSON.stringify(e));
				
				console.log(JSON.stringify(e));
			},
			error:function(e){
				callback(JSON.stringify(e));
			}
		});
		
}
	
