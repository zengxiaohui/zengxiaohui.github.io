var http = require('http'); 

// options for GET 
var optionsget = { 
	//host : 'localhost', // here only the domain name 
	//host: '120.26.217.50',
	//host: '192.168.2.21',
	/*host:'192.168.2.151',
	port : 8080,*/
	host: '121.40.55.125',
	port:9080,
	//(no http/https !) 
	path : '', 
	method : 'GET' // do GET 
}; 

//options for POST 
var optionsPost = { 
	host : 'localhost', // here only the domain name 
	port : 8360, 
	path: '',
	//data : '{"d1":1}, {"a1":2}', 
	method : 'POST',
	headers: {
		    'Content-Type': 'application/x-www-form-urlencoded',
		    'Content-Length': Buffer.byteLength('{"d1":1}, {"a1":2}')
		  }
	
}; 

var withJson = '&response=application/json';
var recvData = '';

export default class {
	
	
	updatePath(path){
		optionsget.path = path;
	}
	
	sendRequest(){	
		recvData = '';
		var promise = new Promise( function(resolve, reject) {  
			optionsget.path = optionsget.path + withJson;
			//console.info('Options prepared:'); 
			console.info(optionsget); 
			//console.info('Do the GET call'); 
			// do the GET request 
			var reqGet = http.request(optionsget, function(res) { 
				//console.log("statusCode: ", res.statusCode); 
				// uncomment it for header details 
				//console.log("headers: ", res.headers); 
				res.on('data', function(d) {
					
					//console.info('GET result:\n'); 
					//process.stdout.write(d); 
					//console.log(JSON.stringify(d));
					//console.info('\n\nCall completed'); 
					console.log(d.toString());
					recvData += d.toString();
					 
				}); 
				
				res.on('end', function() {
					try{
						console.log("END: " + recvData.toString());
						var retjson = JSON.parse(recvData.toString());
						resolve(retjson);
					}
					catch(ex){
						reject({ "errorCode" : 101, "errorMsg" : "Invalid request"});
					}
				});
			}); 
			reqGet.end(function() {
				//console.log("END2");
			}); 
			reqGet.on('error', function(e) { 
				console.error(e); 
				reject(e);
			});
		 });
		 return promise;
	};

	postRequest(path, data){	
		recvData = '';
		var promise = new Promise( function(resolve, reject) {  
			optionsPost.path = path;
			//optionsPost.data = data;
			//console.info("[postRequest] " + optionsPost.data); 
			var reqPost = http.request(optionsPost, function(res) { 
				res.on('data', function(d) {
					console.log(d.toString());
					recvData += d.toString();
					 
				}); 
				
				res.on('end', function() {
					try{
						console.log("END: " + recvData.toString());
						var retjson = JSON.parse(recvData.toString());
						resolve(retjson);
					}
					catch(ex){
						reject({ "errorCode" : 101, "errorMsg" : "Invalid request"});
					}
				});
			}); 

			reqPost.on('error', function(e) { 
				console.error(e); 
				reject(e);
			});

			var da = new Object();
			da.a1=2;
			da.a2=3;
			var str = JSON.stringify(da);
			console.log("str = " + str);
			
			reqPost.write(str);
			
			reqPost.end(function() {
				//console.log("END2");
			}); 
		 });
		 return promise;
	};

	localError(error){
		var promise = new Promise( function(resolve, reject) { 
			reject(error);
		});
		return promise;
		//return Error(error);
	};
}
