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
    let session = await this.session('admin');
    await this.session();

    return this.success('success');
  }
}