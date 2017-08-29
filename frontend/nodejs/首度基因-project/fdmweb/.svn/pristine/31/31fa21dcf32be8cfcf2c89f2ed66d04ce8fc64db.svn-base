'use strict';

import Base from './base.js';

export default class extends Base {
  /**
   * index action
   * @return {Promise} []
   */
  async indexAction(){
    //auto render template file index_index.html
    
    let news = this.model('news').where({isdelete:0,type:0}).order("updatetime DESC").limit(3).select();
    let status = this.model('news').where({isdelete:0,type:1}).order("updatetime DESC").limit(3).select(); 
    this.assign('news',news);
    this.assign('status',status);
    
    return this.display();
  }
  async cleancookieAction(){
    this.cookie("name", null);
    this.cookie("phone", null);
    this.cookie("email", null);
    return this.redirect("/index/index");
  }
}