'use strict';

import Base from './base.js';

export default class extends Base {
    /**
     * index action
     * @return {Promise} []
     */
    async indexAction() {
        //auto render template file index_index.html
        let type = parseInt(this.get('type')) || 0;
        //console.log(type);
        //console.log("----------------------------------------")
        let page = parseInt(this.get('page')) || 1;
        let size = 6;
        let where = {
            type:type,
            isdelete:0
        };

        let list = await this.model('news')
              .where(where)
              .order("updatetime DESC")
              .page(page, size)
              .countSelect(false);
        let total = [];
        for(let i=0;i<list.totalPages;i++){
            total.push(i+1);
        }
        this.assign('list',list.data);
        this.assign('current',list.currentPage);
        this.assign('total',total);
        this.assign('type',type);
        return this.display();
    }


    async getNewsAction() {
        let id = this.get('id');
        try {
            let data = await this.model('news').where({
                isdelete:0,id:id
            }).find();
            return this.success(data);
        } catch (err) {
            return this.fail(err);
        }
    }

    async detailAction() {
        let id = parseInt(this.get('id')) || 0;
        let detail = await this.model('news').where({isdelete:0,id:id}).find();
        this.assign('detail',detail);
        return this.display();
    }

}
