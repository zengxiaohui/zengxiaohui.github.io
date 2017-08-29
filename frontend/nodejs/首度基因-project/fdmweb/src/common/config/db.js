'use strict';
/**
 * db config
 * @type {Object}
 */
export default {
  type: 'mysql',
  adapter: {
    mysql: {
      host: 'rdsl0473555q8c7o1kqoo.mysql.rds.aliyuncs.com',
      port: '3306',
      database: 'first_dimension',
      user: 'eva_db',
      password: 'eva_2016',
      prefix: '',
      encoding: 'UTF8MB4_GENERAL_CI' 
    },
    mongo: {

    }
  }
};