import Base from './base.js';

export default class extends Base {

  async getAction() {
    if (!think.isEmpty(this.get("id")) || !think.isEmpty(this.post('type'))) {
      this.detail();
    } else {
      this.list();
    }
  }

  async detail() {
  	let where = {};
  	if(this.post('type')){
  		where = {type:this.get('type')};
  	} else if(this.get('id')){
  		where = {id:this.get('id')};
  	}
  	let boss = await this.model('boss')
  		.where(where).find();

  	return this.success(boss);
  }

  async list() {

  	let list = await this.model('boss').select();
  	return this.success(list);
  }

  async postAction() {
  	if(!this.post('id') && !this.post('type')){
  		return this.fail('ADMIN_PARAM_LACKED');
  	}
  	let boss = await this.model('boss')
  		.where({type:this.post('type')}).find();
  	if(!boss){
  		boss = await this.model('boss').add(this.post());
  	}else if(boss.id == this.post('id')){
  		//修改
  		boss = await this.model('boss').update(this.post());
  	}else{
  		return this.fail('ADMIN_PARAM_ERROR');
  	}

  	return this.success(boss);
  }


}