var base = function() {
    // this.base_url = "http://www.shijiaapp.com:15001";
    // this.localhost = "http://www.shijiaapp.com:8080";
    /*this.base_url = "http://139.224.104.67:15001";
    this.localhost = "http://139.224.104.67:12012";*/
    this.base_url = "http://www.firstdimension.cn:8360";
    // this.localhost = "http://121.41.90.22:12012";
    // this.base_url = "http://192.168.1.22:15001";
    this.localhost = "http://www.firstdimension.cn:8000";
    return this;
}();
var STATUS_NORMAL = 0; // 正常
var STATUS_BLOCK = 1; // 冻结
var STATUS_DELETE = 2; //删除

var STATUS_INCOMPLETE = -1; // 未完善信息
var STATUS_NORMAL = 0; // 正常用户
var STATUS_APPLY_PENDING = 1; // 法师审核中
var STATUS_APPLY_OK = 2; // 法师审核成功
var STATUS_APPLY_FAIL = 3; // 法师审核失败

var ROLE_TYPE_USER = 1; // 用户
var ROLE_TYPE_FS = 2; // 法师

var TYPE_HOT = 0; //热门
var TYPE_REC = 1; //推荐
var TYPE_BANNER = 2; //banner

var HOT_NO = 0; //否
var HOT_YES = 1; //热门

var MAN = 1; //男
var WOMEN = 2; //女

var FREE_NO = 0; //否
var FREE_YES = 1; //免费

var STATUS_SHIELD = 1; // 屏蔽

var TYPE_QUESTION = 1;
var TYPE_ANSWER = 2;

var TAG_TYPE_QUESTION = 1; //问题标签
var TAG_TYPE_LIVE = 2; //直播标签
var TAG_TYPE_LIVE_TOPIC = 3; //直播话题标签
var TAG_TYPE_HELP = 4; //帮助分类

var TYPE_GOLD_FLOWER = 1; //师币：花瓣
var TYPE_FLOWER_GOD = 2; //花瓣：师币
var TYPE_FLOWER_RMB = 3; //花瓣：RMB
var TYPE_LIVE_PROMOT = 4; //直播提示消息

var TYPE_NORMAL = 1; //通用模板
var TYPE_USER = 2; //用户列表模板
var TYPE_LIVE = 3; //直播列表模板

var STATUS_EFFECT_NO = 0; //未生效
var STATUS_EFFECT_YES = 1; //已生效
var STATUS_DELETE_YES = 2; //删除

var PLATFORM_ALIPAY = 1; // 支付宝支付
var PLATFORM_WXPAY = 2; // 微信支付

var DEVICE_IOS = 1; // IOS
var DEVICE_ANDROID = 2; // ANDROID
var DEVICE_WEB = 3; // WEB

var TYPE_RECHARGE = 1; // 充值
var TYPE_REFUND = 2; // 退款

var STATUS_WAITING = 0; // 等待中
var STATUS_COMPLETED = 1; // 已完成
var STATUS_FAILED = 2; // 已失败

var MONEY2CNY = 1; // 人民币 -> 钱包余额, 即充值
var CNY2MONEY = 10; // 钱包余额 -> 人民币, 即提现

var MONEY2MASTER = 2; // 人民币 -> 师币, 暂时用于IOS内购

var CNY2MASTER = 12; // 钱包余额 -> 师币
var MASTER2CNY = 21; // 师币 -> 钱包余额

var CNY2PETAL = 13; // 钱包余额 -> 花瓣
var PETAL2CNY = 31; // 花瓣 -> 钱包余额

var MASTER2PETAL = 23; // 师币 -> 花瓣
var PETAL2MASTER = 32; // 花瓣 -> 师币
var ACTION_ASK = 101; // 提问随喜
var ACTION_LIVE_PRESENT = 102; // 直播送礼

var TYPE_CONTENT = 1; //纯文字
var TYPE_IMAGE = 2; //纯图片
var TYPE_ALL = 3; //图文


var TYPE_HOT_LIVE_CONFIG_SWITCH = 2; //热门直播开关
var TYPE_HOT_QUESTION_CONFIG_SWITCH = 3; //热门问禅开关

var VALUE1_SWITCH_HANDED = 0; //手动配置
var VALUE1_SWITCH_AUTO = 1; //自动配置

var BANNER_ALL = 0; //同时
var BANNER_LIVE = 1; //只在直播
var BANNER_QUESTION = 2; //只在问禅

$.datetimepicker.setLocale('zh');
Date.prototype.format = function(fmt) { //author: meizz
    var o = {
        "M+": this.getMonth() + 1, //月份
        "d+": this.getDate(), //日
        "h+": this.getHours(), //小时
        "m+": this.getMinutes(), //分
        "s+": this.getSeconds(), //秒
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度
        "S": this.getMilliseconds() //毫秒
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
        if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}
setTimeout(function(){
  $('#4').find("a").click(function() {
      $('#4').find("a").find('span[class="pull-right badge badge-danger"] ').remove();
  });
},1000);


function getNum() {
    $.ajax({
        type: 'get',
        url: base.base_url + "/admin" + "/live/unread",
        data: '',
        statusCode: {
            401: function() {
                $window.location.href = '/app/auth/login.html';
            }
        },
        success: function(result) {
            // console.log("unread", result.data);
            if (result.data == 0) {
                $('#4').find("a").find('span[class="pull-right badge badge-danger"] ').remove();
            } else {
                $('#4').find("a").find('span[class="pull-right badge badge-danger"] ').remove();
                $('#4').find("a").append('<span class="pull-right badge badge-danger">' + result.data + '</span>');
            }
            /*if (data.data.totalCount != 0) {
              $('#5').find('span[class="pull-right badge badge-danger"] ').remove();
                $('#5').append('<span class="pull-right badge badge-danger">' + data.data.totalCount + '</span>');
                temp = data.data.totalCount;
            }
            if (data.data.totalCount == 0) {
                $('#5').find('span[class="pull-right badge badge-danger"] ').remove();
            }
            if (data.data.unpaidCount != 0) {
              $('#6').find('span[class="pull-right badge badge-danger"] ').remove();
                var temp = '<span class="pull-right badge badge-danger">' + data.data.unpaidCount + '</span>';
                $('#6').append(temp);
            }
            if (data.data.unpaidCount == 0) {
                $('#6').find('span').remove();
            }
            if (data.data.paidCount != 0) {
              $('#7').find('span[class="pull-right badge badge-danger"] ').remove();
                $('#7').append('<span class="pull-right badge badge-danger">' + data.data.paidCount + '</span>');
            }
            if (data.data.paidCount == 0) {
                $('#7').find('span').remove();
            }
            if (data.data.refundCount != 0) {
              $('#12').find('span[class="pull-right badge badge-danger"] ').remove();
                $('#12').append('<span class="pull-right badge badge-danger">' + data.data.refundCount + '</span>');
            }
            if (data.data.refundCount == 0) {
                $('#12').find('span').remove();
            }*/
        },
        done: function(data) {},
        error: function(data) {
            console.log("====service-->get-->error====");
        }
    });
}
setInterval(getNum, 5 * 1000);
