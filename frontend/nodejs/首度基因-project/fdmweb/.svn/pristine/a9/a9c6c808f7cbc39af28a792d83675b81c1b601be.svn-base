'use strict';

import Base from './base.js';
import UserMgr from '../connect/usermgr.js';


export default class extends Base {
indexAction(){
	return this.display();
}

registerAction(){


	let test = this.post();

	console.log(test);

	let senderId = this.cookie('userId');
	console.log(senderId);
	return this.display()
}


async  alipaynotifyAction(){

	 	console.log("==========alipaynotifyAction start=========");

	 	let userId = this.cookie('userId');


	 	
	 	
	 	console.log(userId);


		var infor = this.post();


	 	console.log(infor);
	 	
	 	
	 	//var senderId = 220;
	 	
	 	//var senderId = 236;
	 	



	 	return  this.success(infor);


	 }
}