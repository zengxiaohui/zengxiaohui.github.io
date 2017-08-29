'use strict';

import Base from './base.js';
import UserMgr from '../connect/usermgr.js';
import BizMgr from '../connect/bizmgr.js';


var mgr = new UserMgr();
//-------------------------------
var mgm = new BizMgr();


export default class extends Base {

	async indexAction(){
	 	return this.display();
	 }



	 async  downloadAction(){
	 		try{

	 			let orderId = this.get("orderId");

	 			console.log(orderId);
	 			let userId = this.cookie("userId");
	 		
	 			let pm = await mgm.downLoadPill(userId,orderId)
	 			.then(function(result){

	 				console.log(result);
	 				return result;
	 			},function(error){

	 			})
	 			let pillinfor = pm.receipt;
	 			console.log(typeof pillinfor);
	 			var pillinfor1 = JSON.parse(pillinfor);
	 			console.log(typeof pillinfor1);

	 			console.log(pillinfor1[0].fphm);
	 			//var pillinfor2 =JSON.stringify(pillinfor1);
	 			//console.log(pillinfor[2]);
	 		
	 		console.log(pillinfor1[0].fphm);
	 		//var filename = 'user.js';
	 			
	 			//var address = 'C://Users//Administrator//Desktop//test//';
	 			//var address = 'C://Users//Administrator//Desktop//fdmweb22//fdmweb//src//home//controller//'
	 			var filename =  pillinfor1[0].fphm+ '_personal.pdf';

	 			//var filename1 =  pillinfor1[0].fphm+ '.pdf';
	 			/*var test = 'jcltest';
	 			var filename = test+'_个人.pdf' ;
	 			var filename1 = test+'.pdf' ;*/
	 			
	 			//var filename = '16359593_个人.pdf' ;
	 			//var filename = '11.txt' ;
	 			//var filename = '16359582.pdf' ;
	 			//var address = '//fp//'
	 			var address = '/fp1/';


	 			var __filename = address+filename;


	 	


	 			let filePath = __filename;
	 			
	 			this.download(filePath);
	 		}catch(e){
	 				return this.error("没有发票信息");
	 		}
	 		
	 }

	 
	 async queryAction(){
	 	//这个是删除map的操作



	 	try{
	 		let userId = this.cookie("userId");
	 		console.log("========queryAction============");
	 		console.log(userId)
	 		let pm = await mgm.queryOrder(userId)
	 		.then(function(result){

	 			console.log(result);
	 			return result;
	 		},function(error){
	 			console.log(error);
	 		})

	 		//console.log(pm);
	 		//console.log(pm.testList);
	 		this.assign("pm",pm);
	 		//for(let j in pm){
      //var elm = pm.testList;
     // console.log(elm.userId + "|" + elm.name + "|" + elm.password); 
     // this.assign('elm',elm);

     	console.log("====pm==========");
      	console.log(pm);
      	console.log(pm.testList.length);
      	console.log(pm.testList.sendDate);
      	


      	if(pm.testList.length==null){
      		console.log("一条订单的时候");
      		//console.log(pm.testList);
      		let sendDate1 = pm.testList.sendDate.substring(0,10);
      		let testList1 = new Array();
      		testList1.push(sendDate1);
      		this.assign("sendDate",sendDate1);
      		this.assign('testList1',pm.testList);

      	}else{
      		let testList1 = new Array();
      	for(let j in pm.testList){
      		let sendDate = pm.testList[j].sendDate.substring(0,10);
      		testList1.push(sendDate);
      		
      	}
      	console.log(testList1);
      	this.assign("sendDate",testList1);
      	this.assign('testList',pm.testList);
      	}
     
      //this.assign('testList',pm.testList.phoneNumber);
   // }
	 		//this.assign("pm",pm);

	 	}catch(e){

	 	}


	 	return this.display();
	 }


	 async billAction(){
	 	console.log("=====billAction=========");
	 	var infor = this.get();
	 	var userId = this.cookie('userId');

	 	console.log(infor.testItem);
	 	var testItem = infor.testItem;
	 	var aa  = testItem.split(",");
	 	console.log(aa);
	 	console.log(aa.length);
	 	var testItemName=["FD-Tissue-180","FD-ctDNA-180","FD-Tissue-600","FD-ctDNA-600","FD-Exome","FD-ctDNA-Exome",
	 	"FD-Tissue-RNA","FD-Tissue-180+FD-ctDNA-180","FD-Tissue-600+FD-ctDNA-600"]
	 	this.assign('itemName1',testItemName[aa[0]-1]);
	 	this.assign('itemName1Num',aa[1]);
	 	this.assign('itemName2',testItemName[aa[2]-1]);
	 	this.assign('itemName2Num',aa[3]);
	 	this.assign('itemName3',testItemName[aa[4]-1]);
	 	this.assign('itemName3Num',aa[5]);
	 	console.log(aa[0]);
	 	console.log(testItemName[aa[0]-1]);
	 	console.log(aa[1]);
	 	console.log(testItemName[aa[2]-1]);
	 	console.log(aa[3]);
	 	console.log(testItemName[aa[4]-1]);
	 	console.log(aa[5]);


	 	 try{
	 	 	//可能过期的价格或者没过期的价格
	 let pp = await mgm.getPersonCurrentPrice(userId,aa[0], infor.code)

	 .then(function(result){

	 	console.log("=========ppp=========");

	 	console.log(result);
	 	return result;
	 })
	 console.log(pp.price);



	 //10个A的价格	 	
      let gp=await mgm.getCurrentPrice(aa[0], 'AAAAAAAAAA')
    .then(function (result){
      console.log(result.itemId+result.price+"----------------");
      //
      console.log("-----------------")
      
     
      
      return result;

    });
   // console.log(gp);
   // this.assign('price',gp);


   console.log(gp.price);

     var  price =  gp.price;
   var  minprice = pp.price<gp.price?pp.price:gp.price;

   console.log(price);
    }
    
    catch(e){

    }
    if(aa[2]!=null){

    	try{

    //可能过期的价格或者没过期的价格
	 let pp1 = await mgm.getPersonCurrentPrice(userId,aa[2], infor.code)

	 .then(function(result){

	 	console.log("=========ppp=========");

	 	console.log(result);
	 	return result;
	 })
	 console.log(pp1.price);




      let gp1=await mgm.getCurrentPrice(aa[2], 'AAAAAAAAAA')
    .then(function (result){
      console.log(result.itemId+result.price+"----------------");
      //
      console.log("-----------------")
      
     
      
      return result;

    });
    console.log(gp1);
   // this.assign('price',gp);

   var  price1 =  gp1.price;
   var  minprice1 = pp1.price<gp1.price?pp1.price:gp1.price;

   console.log(price1);
    }
    
    catch(e){

    }


    }
     if(aa[4]!=null){

    	try{


     //可能过期的价格或者没过期的价格
	 let pp2 = await mgm.getPersonCurrentPrice(userId,aa[4], infor.code)

	 .then(function(result){

	 	console.log("=========ppp=========");

	 	console.log(result);
	 	return result;
	 })
	 console.log(pp2.price);



      let gp2=await mgm.getCurrentPrice(aa[4], 'AAAAAAAAAA')
    .then(function (result){
      console.log(result.itemId+result.price+"----------------");
      //
      console.log("-----------------")
      
     
      
      return result;

    });
    console.log(gp2);
   // this.assign('price',gp);
   var  price2 =  gp2.price;

   var  minprice2 = pp2.price<gp2.price?pp2.price:gp2.price;

   console.log(price2);
    }
    
    catch(e){

    }


    }

    console.log(price1)

    var priceTatol = price*aa[1];

    var minpriceTatol = minprice*aa[1];

    if(price1 != null){

    	priceTatol = priceTatol+price1*aa[3];

    	minpriceTatol = minpriceTatol+minprice1*aa[3];
    }

    if(price2 != null){
    	priceTatol = priceTatol+price2*aa[5];

    	minpriceTatol = minpriceTatol+minprice2*aa[5];
    }

    console.log(minpriceTatol);
    this.assign("priceTatol",priceTatol);
    this.assign("minpriceTatol",minpriceTatol);

    console.log(priceTatol);






    	console.log("==========infor==========")
    	console.log(infor);
	 	this.assign("inforbill",infor);


	 	console.log(infor.recvAddress);
	 	let reptReceiver_1 = infor.reptReceiver;
	 	let reptReceiver_2 = encodeURIComponent(reptReceiver_1);
	 	console.log(reptReceiver_2);
	 	this.assign("reptReceiver",reptReceiver_2);



	 	var  sendDate = infor.sendDate;
  			

   		var sendDate1 = sendDate.substring(0,10);

   		this.assign("sendDate1",sendDate1);
   		

	 	return this.display();

	 }
}