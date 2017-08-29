'use strict';
/**
 * @ngdoc overview
 * @name adminApp
 * @description
 * # adminApp
 *
 * Main module of the application.
 */
var AdminApp = angular.module('adminApp', ['ngAnimate', 'ngCookies', 'ngResource', 'ngRoute', 'ngSanitize', 'ngTouch', 'ui.bootstrap', 'ImageCropper']).config(function($routeProvider) {
        $routeProvider
        //user-manage
            .when('/news/:type', {
                templateUrl: function($routeParams){
                  if($routeParams.type == "0"){
                      return "news/news.html";
                  }else{
                    return "news/industy.html";
                  }
                },
                controller: 'newsCtrl',
                allowAnonymous: false
            }).when('/news/:type/:operate', {
                templateUrl: 'news/newsEdit.html',
                controller: 'newsEditCtrl',
                allowAnonymous: false
            }).when('/news/:type/:operate/:id', {
                templateUrl: 'news/newsEdit.html',
                controller: 'newsEditCtrl',
                allowAnonymous: false
            })
            //adminManage
            .when('/science', {
                templateUrl: 'science/science.html',
                controller: 'scienceCtrl',
                allowAnonymous: false
            })
            .when('/science/:operate', {
                templateUrl: 'science/scienceEdit.html',
                controller: 'scienceEditCtrl',
                allowAnonymous: false
            })
            .when('/science/:operate/:id', {
                templateUrl: 'science/scienceEdit.html',
                controller: 'scienceEditCtrl',
                allowAnonymous: false
            })
            //banner
            .when('/boss', {
                templateUrl: 'boss/boss.html',
                controller: 'bossCtrl',
                allowAnonymous: false
            })
            .when('/boss/:id', {
                templateUrl: 'boss/bossEdit.html',
                controller: 'bossEditCtrl',
                allowAnonymous: false
            })
            //master
            .when('/master', {
                templateUrl: 'master/master.html',
                controller: 'masterCtrl',
                allowAnonymous: false
            })
            .when('/master/:operate', {
                templateUrl: 'master/masterAdd.html',
                controller: 'masterAddCtrl',
                allowAnonymous: false
            })
            .when('/master/:operate/:id', {
                templateUrl: 'master/masterAdd.html',
                controller: 'masterAddCtrl',
                allowAnonymous: false
            })
            .when('/masterExam', {
                templateUrl: 'master/masterExam.html',
                controller: 'masterExamCtrl',
                allowAnonymous: false
            })
            //question
            .when('/question', {
                templateUrl: 'question/question.html',
                controller: 'questionCtrl',
                allowAnonymous: false
            })
            .when('/answer/:id', {
                templateUrl: 'answer/answer.html',
                controller: 'answerCtrl',
                allowAnonymous: false
            })
            .when('/comment/:type/:id/:answerId', {
                templateUrl: 'comment/comment.html',
                controller: 'commentCtrl',
                allowAnonymous: false
            })
            .when('/helpContent', {
                templateUrl: 'helpContent/help.html',
                controller: 'helpCtrl',
                allowAnonymous: false
            })
            .when('/sensitive', {
                templateUrl: 'sensitive/sensitive.html',
                controller: 'sensitiveCtrl',
                allowAnonymous: false
            })
            //organization
            .when('/liveTip', {
                templateUrl: 'system/liveTip.html',
                controller: 'liveTipCtrl',
                allowAnonymous: false
            })
            .when('/ratio', {
                templateUrl: 'system/ratio.html',
                controller: 'ratioCtrl',
                allowAnonymous: false
            })
            .when('/edit/organization/:operate/:id', {
                templateUrl: 'organization/organizationAdd.html',
                controller: 'organizationAddCtrl',
                allowAnonymous: false
            })
            //master
            .when('/live', {
                templateUrl: 'live/live.html',
                controller: 'liveCtrl',
                allowAnonymous: false
            })
            .when('/feedback', {
                templateUrl: 'system/feedback.html',
                controller: 'feedbackCtrl',
                allowAnonymous: false
            })
            .when('/master/add/:type/:operate', {
                templateUrl: 'master/masterEdit.html',
                controller: 'masterEditCtrl',
                allowAnonymous: false
            })
            .when('/master/edit/:type/:operate/:id', {
                templateUrl: 'master/masterEdit.html',
                controller: 'masterEditCtrl',
                allowAnonymous: false
            })
            //专栏
            .when('/program', {
                templateUrl: 'column/column.html',
                controller: 'columnCtrl',
                allowAnonymous: false
            })
            .when('/program/:operate', {
                templateUrl: 'column/columnEdit.html',
                controller: 'columnEditCtrl',
                allowAnonymous: false
            })
            .when('/program/:operate/:id', {
                templateUrl: 'column/columnEdit.html',
                controller: 'columnEditCtrl',
                allowAnonymous: false
            })
            //product
            .when('/product', {
                templateUrl: 'product/product.html',
                controller: 'productCtrl',
                allowAnonymous: false
            })
            .when('/product/:operate', {
                templateUrl: 'product/productEdit.html',
                controller: 'productEditCtrl',
                allowAnonymous: false
            })
            .when('/product/:operate/:id', {
                templateUrl: 'product/productEdit.html',
                controller: 'productEditCtrl',
                allowAnonymous: false
            })
            //tag
            .when('/tag/:type', {
                templateUrl: function($routeParams) {
                    if ($routeParams.type == TAG_TYPE_QUESTION)
                        return "tag/questionTag.html";
                    else if ($routeParams.type == TAG_TYPE_LIVE)
                        return "tag/liveTag.html";
                    else if ($routeParams.type == TAG_TYPE_LIVE_TOPIC)
                        return "tag/liveTopicTag.html";
                    else if ($routeParams.type == TAG_TYPE_HELP)
                        return "tag/helpTag.html";
                },
                controller: 'tagCtrl',
                allowAnonymous: false
            }).when('/orderPreview/:id', {
                templateUrl: 'order/preview.html',
                controller: 'previewCtrl',
                allowAnonymous: false
            })
            .when('/io', {
                templateUrl: 'chart/io.html',
                controller: 'ioCtrl',
                allowAnonymous: false
            })
            .when('/recharge', {
                templateUrl: 'chart/recharge.html',
                controller: 'rechargeCtrl',
                allowAnonymous: false
            })
            .when('/withdraw', {
                templateUrl: 'chart/withdraw.html',
                controller: 'withdrawCtrl',
                allowAnonymous: false
            })
            .when('/f2g', {
                templateUrl: 'convert/F2G.html',
                controller: 'F2GCtrl',
                allowAnonymous: false
            })
            .when('/f2c', {
                templateUrl: 'convert/F2C.html',
                controller: 'F2CCtrl',
                allowAnonymous: false
            })
            .when('/g2f', {
                templateUrl: 'convert/G2F.html',
                controller: 'G2FCtrl',
                allowAnonymous: false
            })
            .when('/c2t', {
                templateUrl: 'convert/C2T.html',
                controller: 'C2TCtrl',
                allowAnonymous: false
            })
            .when('/c2g', {
                templateUrl: 'convert/C2G.html',
                controller: 'C2GCtrl',
                allowAnonymous: false
            })
            .when('/masters', {
                templateUrl: 'artificial/artist.html',
                controller: 'mastersCtrl',
                allowAnonymous: false
            })
            .when('/masters/:operate', {
                templateUrl: 'artificial/artistEdit.html',
                controller: 'mastersEditCtrl',
                allowAnonymous: false
            })
            .when('/masters/:operate/:id', {
                templateUrl: 'artificial/artistEdit.html',
                controller: 'mastersEditCtrl',
                allowAnonymous: false
            })
            .when('/user', {
                templateUrl: 'artificial/user.html',
                controller: 'userCtrl',
                allowAnonymous: false
            })
            .when('/user/:operate', {
                templateUrl: 'artificial/userEdit.html',
                controller: 'userEditCtrl',
                allowAnonymous: false
            })
            .when('/user/:operate/:id', {
                templateUrl: 'artificial/userEdit.html',
                controller: 'userEditCtrl',
                allowAnonymous: false
            })
            .when('/push', {
                templateUrl: 'system/push.html',
                controller: 'pushCtrl',
                allowAnonymous: false
            })
            .when('/order', {
                templateUrl: 'system/order.html',
                controller: 'orderCtrl',
                allowAnonymous: false
            })
            .otherwise({
                redirectTo: '/news/0',
                allowAnonymous: false
            });
    })
    .config(function() {
        //正式
        // AV.initialize('9Liu9FBupwQdidz5GKxVi5i8-gzGzoHsz', 'sM6KSY1OSYusHfrQ1vajoHct');
        //测试
        AV.initialize('9Liu9FBupwQdidz5GKxVi5i8-gzGzoHsz', 'sM6KSY1OSYusHfrQ1vajoHct');
    });
AdminApp.controller('menuCtrl', ['$scope', 'pageService', function($scope, pageService) {}]);
AdminApp.controller('cropCtrl', ['$scope', '$uibModal', '$uibModalInstance', function($scope, $modal, $modalInstance) {
    $scope.fileChanged = function(e) {
        var files = e.target.files;
        var fileReader = new FileReader();
        fileReader.readAsDataURL(files[0]);
        fileReader.onload = function(e) {
            $scope.imgSrc = this.result;
            console.log($scope.imgSrc);
            $scope.$apply();
        };
    };
    $scope.clear = function() {
        $scope.imageCropStep = 1;
        delete $scope.imgSrc;
        delete $scope.result;
        delete $scope.resultBlob;
    };
    $scope.close = function() {
        $modalInstance.close("normal");
    };
    $scope.submit = function() {
        if ($scope.result == null) {} else {

            var file = new AV.File('crop.jpeg', {
                base64: $scope.result
            });
            file.save().then(function(obj) {
                // 数据保存成功
                console.log(obj.url());
                $modalInstance.close(obj.url());
            }, function(err) {
                // 数据保存失败
                console.log(err);
            });
        }
    };
}]);
// Route State Load Spinner(used on page or content load)
AdminApp.directive('ngSpinnerLoader', ['$rootScope',
    function($rootScope) {
        return {
            link: function(scope, element, attrs) {
                // by defult hide the spinner bar
                element.addClass('hide'); // hide spinner bar by default
                // display the spinner bar whenever the route changes(the content part started loading)
                $rootScope.$on('$routeChangeStart', function() {
                    element.removeClass('hide'); // show spinner bar
                });
                // hide the spinner bar on rounte change success(after the content loaded)
                $rootScope.$on('$routeChangeSuccess', function() {
                    setTimeout(function() {
                        element.addClass('hide'); // hide spinner bar
                    }, 500);
                    $("html, body").animate({
                        scrollTop: 0
                    }, 500);
                });
            }
        };
    }
]);
