'use strict';
angular.module('adminApp').controller('tipCtrl', ['$scope', '$rootScope', '$uibModal', '$uibModalInstance', '$sce', '$window', '$timeout', 'pageService', 'datas', 'status', 'operate', function($scope, $rootScope, $modal, $modalInstance, $sce, $window, $timeout, pageService, datas, status, operate) {
    var url = "";
    var path = "";
    var data = {};
    var open = "animated fadeInDown";
    var close = "animated fadeOutUp";
    var text = " 操作成功！";
    var position = "topRight";
    $scope.con = true;
    $scope.setContent = function(result) {
        if (result.code == "200") {
            console.log(result.data);
            var content = "";
            content = "<p>" + result.data.content + "</p>";
            if (datas.type == TYPE_ACTIVITY) {
                content += "<p>活动限制人数：" + result.data.maxNumber + "人</p>";
                content += "<p>活动费用：" + result.data.fee + "元</p>";
                content += "<p>活动时间：" + new Date(result.data.startTime).format("yyyy-MM-dd hh:mm") + "</p>";
                content += "<p>活动地点：" + result.data.address + "</p>";
            }
            if (result.data.authorType == AUTHOR_TYPE_SYSTEM) {
                if (result.data.user.avatar == null || result.data.user.avatar == "") {
                    content += "<p>出处：<img src='../../global/images/100z.png' style='width:70px !important;height:70px !important;' class='img-circle'></img>  " + result.data.user.nickname + "</p>";
                } else
                    content += "<p>出处：<img src='" + result.data.user.avatar + "' style='width:70px !important;height:70px !important;' class='img-circle'></img>  " + result.data.user.nickname + "</p>";
            } else {
                if (result.data.profile.avatar == null || result.data.profile.avatar == "") {
                    content += "<p>出处：<img src='../../global/images/100z.png' style='width:70px !important;height:70px !important;' class='img-circle'></img>  " + result.data.profile.nickname + "</p>";
                } else
                    content += "<p>出处：<img src='" + result.data.profile.avatar + "' style='width:70px !important;height:70px !important;' class='img-circle'></img>  " + result.data.profile.nickname + "</p>";
            }
            if (result.data.contentVideo != null) {
                $timeout(function() {
                    var playerInstances = jwplayer("videos");
                    playerInstances.setup({
                        file: result.data.contentVideo,
                        skin: {
                            name: "bekle"
                        }
                    });
                });
            }
            $timeout(function() {
                $scope.myHTML = $sce.trustAsHtml(content);
            });
        } else {
            pageService.serverError(result);
        }
    };
    //一般确认信息，点击确认按钮触发操作，取消按钮关闭窗口
    if (operate == "news-content") {
        $scope.title = "新闻内容详情";
        $scope.con = false;
        $scope.myHTML = $sce.trustAsHtml(datas.content);
    } else if (operate == "del_news") { //初始化管理员密码
        $scope.title = "确认信息";
        url = "/delete";
        if (datas.type == 1)
            $scope.type = "行业动态";
        else
            $scope.type = "新闻";
        text = $scope.type + "内容删除成功";
        data = {
            id: datas.id,
            obj: "news"
        };
        $scope.msg = "您确认删除您选中的‘" + $scope.type + "’信息吗？"
    } else if (operate == "science_content") { //冻结/激活管理员账号
        $scope.title = "科学顾问简介";
        $scope.con = false;
        var content = datas.introduce1 + "<br>" + datas.introduce2;
        $scope.myHTML = $sce.trustAsHtml(content);
    } else if (operate == "del_science") {
        $scope.title = "确认信息";
        url = "/delete";
        text = "科学顾问信息删除成功";
        data = {
            id: datas.id,
            obj: "science"
        };
        $scope.msg = "您确认删除您选中的的科学顾问信息吗？"
    } else if (operate == "boss_content") {
        $scope.title = "老板信息简介";
        $scope.con = false;
        var content = "教育背景：<br>"+datas.education + "<br><br>" +"工作经历：<br>"+ datas.work+"<br><br>创业经历：<br>"+datas.business+"<br><br>科研成就：<br>"+datas.science;
        $scope.myHTML = $sce.trustAsHtml(content);
    } else if (operate == "banner_content") {
        $scope.title = "banner内容详情";
        $scope.con = false;
        pageService.setBase();
        pageService.get('/banner/content', {
            id: datas.id
        }, $scope.setContent);
    } else if (operate == "del_banner") { //订单操作
        text = "banner删除成功！";
        $scope.title = "确认信息";
        $scope.msg = "您确认要删除选中的Banner信息吗？";
        url = "/banner/update-status";
        data = {
            id: datas.id,
            status: status
        };
    } else if (operate == "banner_effect") { //订单操作
        $scope.title = "确认信息";
        if (status == STATUS_EFFECT_NO) {
            $scope.msg = "您确认您要设置选中的Banner失效吗？";
            text = "Banner失效设置成功";
        } else {
            $scope.msg = "您确认要设置选中的Banner生效吗?";
            text = "Banner生效设置成功";
        }
        url = "/banner/update-status";
        data = {
            id: datas.id,
            status: status
        };
    } else if (operate == "hot_set") {
        $scope.title = "确认信息";
        if (status == HOT_YES) {
            $scope.msg = "您确认推荐法号为‘" + datas.profile.nickname + "’的法师到搜索推荐列表中吗？";
            text = "法师搜索推荐设置成功";
        } else {
            $scope.msg = "您确认将法号为‘" + datas.profile.nickname + "’的法师从搜索推荐列表中移除吗？";
            text = "法师搜索推荐取消成功";
        }
        data = {
            id: datas.id,
            type: TYPE_HOT,
            status: status
        };
        url = "/account/hot";
    } else if (operate == "recommend_set") {
        $scope.title = "确认信息";
        if (status == HOT_YES) {
            $scope.msg = "您确认推荐法号为‘" + datas.profile.nickname + "’的法师到首次登录和提问推荐列表中吗？";
            text = "法师首次登录和提问推荐设置成功";
        } else {
            $scope.msg = "您确认将法号为‘" + datas.profile.nickname + "’的法师从首次登录和提问推荐列表中移除吗？";
            text = "法师首次登录和提问推荐取消成功";
        }
        data = {
            id: datas.id,
            type: TYPE_REC,
            status: status
        };
        url = "/account/hot";
    } else if (operate == "banner_set") {
        $scope.title = "确认信息";
        if (status == HOT_YES) {
            if (datas.type == ROLE_TYPE_FS)
                $scope.msg = "您确认设置法号为‘" + datas.profile.nickname + "’的法师到首页Banner列表中吗？";
            else
                $scope.msg = "您确认设置昵称为‘" + datas.profile.nickname + "’的用户到首页Banner列表中吗？";
            text = "设置成功";
        } else {
            if (datas.type == ROLE_TYPE_FS)
                $scope.msg = "您确认将法号为‘" + datas.profile.nickname + "’的法师从首页Banner列表中移除吗？";
            else
                $scope.msg = "您确认将昵称为‘" + datas.profile.nickname + "’的用户从首页Banner列表中移除吗？";
            text = "取消设置成功";
        }
        data = {
            id: datas.id,
            type: TYPE_BANNER,
            status: status
        };
        url = "/account/hot";
    } else if (operate == "master_exam") { //预览视频，视频插件jwplayer
        $scope.title = "确认信息";
        if (status == STATUS_APPLY_OK) {
            $scope.msg = "您确定要审核通过法号为‘" + datas.profile.nickname + "’的法师的申请吗？";
            text = "法师申请通过成功";
        } else {
            $scope.msg = "您确定要拒绝法号为‘" + datas.profile.nickname + "’的法师的申请吗？";
            text = "法师申请拒绝成功";
        }
        data = {
            id: datas.id,
            status: status
        };
        url = "/account/exam";
    } else if (operate == "question_content") {
        $scope.title = "问题详情";
        $scope.con = false;
        $scope.myHTML = $sce.trustAsHtml(datas.content);
    } else if (operate == "question_hot_set") {
        $scope.title = "确认信息";
        if (status == HOT_YES) {
            $scope.msg = "您确认设置您选中的问答为热门问答吗？";
            text = "热门问答设置成功";
        } else {
            $scope.msg = "您确认要取消您选中的问答的热门设置吗？";
            text = "热门问答取消成功";
        }
        data = {
            id: datas.id,
            type: TYPE_HOT,
            status: status
        };
        url = "/question/hot";
    } else if (operate == "question_recommend_set") {
        $scope.title = "确认信息";
        if (status == HOT_YES) {
            $scope.msg = "您确认设置您选中的问答为推荐问答吗？";
            text = "推荐问答设置成功";
        } else {
            $scope.msg = "您确认要取消您选中的问答的推荐设置吗？";
            text = "推荐问答取消成功";
        }
        data = {
            id: datas.id,
            type: TYPE_REC,
            status: status
        };
        url = "/question/hot";
    } else if (operate == "shield_set") {
        // console.log(datas.id);
        $scope.title = "确认信息";
        if (status == STATUS_SHIELD) {
            $scope.msg = "您确定要屏蔽选中的问题吗？屏蔽该问答后，该问题的热门和推荐设置都将被取消，请知悉！";
            text = "问答屏蔽成功";
        } else {
            $scope.msg = "您确定要取消您选中的问题的屏蔽设置吗？";
            text = "问答屏蔽取消成功";
        }
        data = {
            id: datas.id,
            status: status
        };
        url = "/question/update-status";
    } else if (operate == "shield_answer") {
        // console.log(datas.id);
        $scope.title = "确认信息";
        if (status == STATUS_SHIELD) {
            $scope.msg = "您确定要屏蔽选中的回答吗？";
            text = "回答屏蔽成功";
        } else {
            $scope.msg = "您确定要取消您选中的回答的屏蔽设置吗？";
            text = "回答屏蔽取消成功";
        }
        data = {
            id: datas.id,
            status: status
        };
        url = "/answer/update-status";
    } else if (operate == "answer_content") {
        $scope.title = datas.respondent.nickname + "大师回答内容信息";
        $scope.con = false;
        $scope.myHTML = $sce.trustAsHtml(datas.content);
    } else if (operate == "comment_content") {
        $scope.title = "评论信息";
        $scope.con = false;
        $scope.myHTML = $sce.trustAsHtml(datas.content);
    } else if (operate == "del_comment") {
        $scope.title = "确认信息";
        if (datas.type == TYPE_QUESTION) {
            $scope.msg = "您确认要删除选中的问题评论吗？";
            text = "问题评论删除成功";
        } else {
            $scope.msg = "您确定要删除您选中的回答评论吗？";
            text = "回答评论删除成功";
        }
        url = "/comment/delete";
        data = {
            id: datas.id,
        };
    } else if (operate == "del_tag") {
        $scope.title = "确认信息";
        if (datas.type == TAG_TYPE_HELP) {
            pageService.setBase();
            pageService.post("/tag/help/check", {
                id: datas.id
            }, $scope.check);
        } else {
            $scope.msg = "您确认要删除标签名称为‘" + datas.name + "’的标签吗？";
            text = "标签删除成功";
            data = {
                id: datas.id
            };
            url = "/tag/delete";
        }
    } else if (operate == "master_content") {
        $scope.con = false;
        $scope.title = datas.realName + "个人简介";
        $scope.myHTML = $sce.trustAsHtml(datas.contentInfo);
    } else if (operate == "del_master") {
        pageService.setBase();
        pageService.get("/master/check", {
            id: datas.id
        }, $scope.masterCheck);
    } else if (operate == "del_help") {
        $scope.title = "确认信息";
        $scope.msg = "您确定要删除标题为‘" + datas.title + "’的帮助内容吗？";
        text = "帮助内容删除成功";
        data = {
            id: datas.id
        };
        url = "/help/delete";

    } else if (operate == "del_sensitive") {
        $scope.title = "确认信息";
        $scope.msg = "您确认要删除‘" + datas.word + "’敏感词吗？";
        text = "敏感词删除成功";
        data = {
            id: datas.id
        };
        url = "/sensitive/delete";
    } else if (operate == "live_hot_set") {
        $scope.title = "确认信息";
        if (status == HOT_NO) {
            $scope.msg = "您确认取消选择的直播信息的热门设置吗？";
            text = "热门取消成功";
        } else {
            $scope.msg = "您确认要设置选择的直播信息为热门吗？";
            text = "热门设置成功";
        }
        data = {
            id: datas.id,
            status: status,
            type: TYPE_HOT
        };
        url = "/live/set";
    } else if (operate == "live_recommend_set") {
        $scope.title = "确认信息";
        if (status == HOT_NO) {
            $scope.msg = "您确认取消选择的直播信息的推荐设置吗？";
            text = "推荐取消成功";
        } else {
            $scope.msg = "您确认要设置选择的直播信息为推荐吗？";
            text = "推荐设置成功";
        }
        data = {
            id: datas.id,
            status: status,
            type: TYPE_REC
        };
        url = "/live/set";
    } else if (operate == "live_banner_set") {
        $scope.title = "确认信息";
        if (status == HOT_NO) {
            $scope.msg = "您确认将选中的直播信息从Banner直播推荐列表中移除吗？";
            text = "设置取消成功";
        } else {
            $scope.msg = "您确认要将选中的直播信息设置到Banner直播推荐列表中吗？";
            text = "设置成功";
        }
        data = {
            id: datas.id,
            status: status,
            type: TYPE_BANNER
        };
        url = "/live/set";
    } else if (operate == "buy_info") {
        $scope.title = "产品购买信息";
        $scope.con = false;
        var content = "";
        content += "<p>微信：" + datas.buyWechat + "</p>";
        content += "<p>QQ：" + datas.buyQq + "</p>";
        content += "<p>手机号：" + datas.buyPhone + "</p>";
        content += "<p>联系人：" + datas.buyContant + "</p>";
        $scope.myHTML = $sce.trustAsHtml(content);
    } else if (operate == "del_product") {
        $scope.title = "确认信息";
        $scope.msg = "您确认您要删除标题为：" + datas.title + "的产品信息吗？";
        url = "/product/delete";
        data = {
            id: datas.id
        };
        text = "产品删除成功";
    } else if (operate == "help_content") {
        $scope.title = "帮助内容";
        $scope.con = false;
        $scope.myHTML = $sce.trustAsHtml(datas.content);
    } else if (operate == "del_account") {
        $scope.title = "确认信息";
        if (datas.profile.type == ROLE_TYPE_FS)
            $scope.msg = "您确定要删除ID为" + datas.uid + "的法师账号信息吗？";
        else
            $scope.msg = "您确定要删除ID为" + datas.uid + "的用户账号信息吗？";
        text = "删除成功";
        data = {
            id: datas.id
        };
        url = "/account/delete";
    }
    /*
    点击关闭按钮
     */
    $scope.close = function() {
        $modalInstance.close("normal");
    };
    /*
    点击提交按钮
     */
    $scope.submit = function() {
        $scope.disable = true;
        $scope.operate = function operate(result) {
            if (result.errno == 0) {
                $scope.disable = false;
                $scope.$apply();
                pageService.notys(text, open, close, position, "success");
                $modalInstance.close("success");
            } else {
                $scope.disable = false;
                $scope.$apply();
                pageService.serverError(result);
            }
        };
        pageService.setBase();
        pageService.post(url, data, $scope.operate);
    };
}]);
