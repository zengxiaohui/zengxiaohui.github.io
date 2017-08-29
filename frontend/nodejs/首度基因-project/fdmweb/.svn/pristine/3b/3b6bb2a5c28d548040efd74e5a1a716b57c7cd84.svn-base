import Base from './base.js';

export default class extends Base {
	async postAction(){
		// console.log(this.http.headers.token);
		let username = this.post('username');
		let oldword = this.post('old');
		let newword = this.post('new');
		if(!oldword || !newword ){
			return this.fail('ADMIN_PARAM_LACKED');
		}
		let tokenService = think.service("token");
	    let tokenServiceInstance = new tokenService();
		let userInfo = await tokenServiceInstance.verifyToken(this.http.headers.token);
		console.log(userInfo);
		let user = await this.model('admin')
					.where({id:userInfo.userInfo.id})
					.field(['id,username,password'])
					.select();

		if(user[0].password == oldword){
			user[0].password = newword;
			return this.success(await this.model('admin').update(user[0]));
		}else{
			return this.fail('原密码错误');
		}
	}
}