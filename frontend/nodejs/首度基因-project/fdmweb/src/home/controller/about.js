'use strict';

import Base from './base.js';
import BizMgr from '../connect/bizmgr.js';

var mgr = new BizMgr();

export default class extends Base {
  /**
   * index action
   * @return {Promise} []
   */
  async indexAction(){
    //auto render template file index_index.html
    let ceo = await this.model('boss').where({type:0}).find();
    let boss = await this.model('boss').where({type:1}).find();
    let science = await this.model('science_advisor').where({isdelete:0}).select();
    
    /*
	let pm = await mgr.getDiscPriceList(1)
	  .then( function (result) { 
			for(let j in result.discList){
				var elm = result.discList[j];
				console.log(elm);				
			}
		},   
		function (error) {   
		   console.log(error);   
		});
	

	let pm = await mgr.addTestOrder(79, 97, "1,1", "13977665555", "xx", "zj")
	  .then( function (result) {
		  return result;
		},   
		function (error) {   
		   console.log(error);   
		});
	*/
    /*
    var jsobj = new Object();
    jsobj.a1="a1";
    jsobj.f1="f1";
    jsobj.s1="s1";
    
    var str = JSON.stringify(jsobj);
    console.log("BBB: "+str);
    */
    
    this.assign('ceo',ceo);
    this.assign('boss',boss);
    this.assign('science',science);

    return this.display();
  }
}