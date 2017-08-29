import Base from './base.js';

export default class extends Base {

	async getAction() {
		if (!think.isEmpty(this.get("id"))) {
	      this.detail();
	    } else {
	      this.list();
	    }
	}

	async detail() {
		let scientist  = await this.model('science_advisor')
	      .where({id: this.get("id")}).find();
	    return this.success(scientist );
	}

	async list() {
		let page = this.get('page') || 1;
	    let size = this.get('size') || 10;
	    let where = {
	    	isdelete:0
	    };
	    if(this.get('key')){
	    	where.name = ['like','%'+ this.get('key') +'%'];
	    }
	    let list = await this.model('science_advisor')
	      .where(where)
	      .order("updatetime DESC")
	      .page(page, size)
	      .countSelect(false);

	    return this.success(list);
	}

	async postAction(){
		let id = this.post('id'); 
	    let name = this.post('name');
	    let education = this.post('education');
	    let image = this.post('image');
	    if(think.isEmpty(name) || think.isEmpty(education) || think.isEmpty(image) ){
	      return this.fail('ADMIN_PARAM_LACKED');
	    }
	    if(think.isEmpty(id)){
	      return this.success(await this.model('science_advisor').add(this.post()));
	    }else{
	      //修改
	      return this.success(await this.model('science_advisor').update(this.post()));
	    }
	}
  



}