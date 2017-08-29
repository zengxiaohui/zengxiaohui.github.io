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
    let news = await this.model('news')
      .where({id: this.get("id")}).find();
    return this.success(news);
  }


  async list() {
    let page = this.get('page') || 1;
    let size = this.get('size') || 10;
    let type = this.get('type');
    if (think.isEmpty(type)) {
      return this.fail('ADMIN_PARAM_LACKED');
    } 
    let where = {
      type:type,
      isdelete:0
    };
    if(this.get('key')){
      where.title = ['like','%'+this.get('key')+'%'];
    }
    let list = await this.model('news')
      .where(where)
      .order("updatetime DESC")
      .page(page, size)
      .countSelect(false);

    return this.success(list);
  }

  async deleteAction(){
    return ;
  }

  async postAction(){
    let id = this.post('id'); 
    let type = this.post('type');
    let title = this.post('title');
    let thumbnail = this.post('thumbnail');
    let content = this.post('content');
    if(think.isEmpty(type) || think.isEmpty(title) || think.isEmpty(thumbnail) || think.isEmpty(content)){
      return this.fail('ADMIN_PARAM_LACKED')
    }
    if(think.isEmpty(id)){
      return this.success(await this.model('news').add(this.post()));
    }else{
      //修改
      return this.success(await this.model('news').update(this.post()));
    }
  }
};