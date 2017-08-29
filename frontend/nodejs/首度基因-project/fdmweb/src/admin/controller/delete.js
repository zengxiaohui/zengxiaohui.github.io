import Base from './base.js';

export default class extends Base {
	
  async getAction() {
    // console.log(this.get());
    return this.fail('please use post method!');
  }

  async postAction(){

  	let obj = this.post('obj');
  	let id = this.post('id');
  	console.log(obj,id);
  	if(!obj || !id){
  		return this.fail('ADMIN_PARAM_LACKED');
  	}
  	if(obj == 'science'){
  		obj = 'science_advisor';
  	}
  	let model = this.model(obj);
  	let data = await model.where({id:id}).find();
  	if(!think.isEmpty(data)){
  		return this.success(await model.update({id:id,isdelete:1}));
  	}else{
  		return this.fail('can not fond data ,id = ' + id);
  	}
  }
  
};