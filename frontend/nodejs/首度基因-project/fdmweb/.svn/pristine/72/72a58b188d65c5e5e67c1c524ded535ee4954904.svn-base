'use strict';
// let user = {};
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
    async __before() {
        //登录、注册不验证token
        if (this.http.action === 'login') {
            return;
        }
        //获取http-header token
        let userToken = this.http.header("token");
        //调用tokenservice中间件
        let tokenService = think.service("token");
        let tokenServiceInstance = new tokenService();
        //验证token
        let verifyTokenResult = await tokenServiceInstance.verifyToken(userToken);
        //服务器错误时
        if (verifyTokenResult === "fail") {
            this.fail("TOKEN_INVALID")
        }
        //获取用户信息
        // user = verifyTokenResult.userInfo;
        // //写入新token
        // let newToken = await tokenServiceInstance.createToken({
        //     userInfo: verifyTokenResult.userInfo
        // });
        // this.http.header("token", newToken);
    }

    __call() {
            this.fail("NEED_LOGIN");
        }
        //用户信息
    // userInfo() {
    //     return user;
    // }
}
