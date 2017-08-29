export default class extends think.controller.rest {
  /**
   * init
   * @param  {Object} http []
   * @return {}      []
   */
  init(http) {
    super.init(http);
  }

  /**
   * before magic method
   * @return {Promise} []
   */
  __before() {

  }

  async postAction() {
    let username = this.post('username');
    let password = this.post('password');

    let admin = await this.model('admin')
              .where({username: username,password:password})
              .find();
    // console.log(admin);
     if (!think.isEmpty(admin)) {
      //调用tokenservice中间件
      let tokenService = think.service("token");
      let tokenServiceInstance = new tokenService();
      //写入token
      let token = await tokenServiceInstance.createToken({
        userInfo: {
          id: admin.id,
          name: admin.username
        }
      });
      //传输客户端token
      this.http.header("token", token);
      // this.session(token,admin);
      // console.log(this.session);
      return this.success({token:token,data:{id: admin.id,
          name: admin.username}});

    } else {
      return this.fail("LOGIN_ERROR");
    }
  }
};