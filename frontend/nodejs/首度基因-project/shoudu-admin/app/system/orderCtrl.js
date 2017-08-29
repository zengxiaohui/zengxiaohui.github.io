angular.module("adminApp").controller('orderCtrl', ['$scope', 'pageService', '$timeout', function($scope, pageService, $timeout) {
    $scope.liveCheck = -1;
    $scope.questionCheck = -1;
    $scope.liveRead = true;
    $scope.editLiveNum = true;
    $scope.liveNumDisable = false;
    $scope.questionRead = true;
    $scope.editQuestionNum = true;
    $scope.questionNumDisable = false;
    $scope.setLive = function(result) {
        $scope.live = result.data;
    };
    $scope.setQuestion = function(result) {
        $scope.question = result.data;
    };
    pageService.setBase();
    pageService.get("/config/get", {
        type: TYPE_HOT_LIVE_CONFIG_SWITCH
    }, $scope.setLive);
    pageService.get("/config/get", {
        type: TYPE_HOT_QUESTION_CONFIG_SWITCH
    }, $scope.setQuestion);
    $timeout(function() {
        $('#liveAuto').on('ifChecked', function(event) {
            $scope.liveCheck = VALUE1_SWITCH_AUTO;
            if ($scope.live.value1 == $scope.liveCheck) {
                $scope.saveLive = false;
            } else {
                $scope.saveLive = true;
            }
            $scope.$apply();
        });
        $('#liveManual').on('ifChecked', function(event) {
            $scope.liveCheck = VALUE1_SWITCH_HANDED;
            if ($scope.live.value1 == $scope.liveCheck) {
                $scope.saveLive = false;
            } else {
                $scope.saveLive = true;
            }
            $scope.$apply();
        });
        $('#questionAuto').on('ifChecked', function(event) {
            $scope.questionCheck = VALUE1_SWITCH_AUTO;
            if ($scope.question.value1 == $scope.questionCheck) {
                $scope.saveQuestion = false;
            } else {
                $scope.saveQuestion = true;
            }
            $scope.$apply();
        });
        $('#questionManual').on('ifChecked', function(event) {
            $scope.questionCheck = VALUE1_SWITCH_HANDED;
            if ($scope.question.value1 == $scope.questionCheck) {
                $scope.saveQuestion = false;
            } else {
                $scope.saveQuestion = true;
            }
            $scope.$apply();
        });
    }, 1200);
    $scope.liveCallback = function(result) {
        $scope.liveDisable = false;
        if (result.code == "200") {
            var text = "直播排序方式修改成功";
            pageService.notys(text, "", "", "", "success");
            $scope.saveLive = false;
        }
        $scope.$apply();
    };
    $scope.saveButton = function() {
        $scope.liveDisable = true;
        $scope.live.value1 = $scope.liveCheck;
        pageService.postJson("/config/save", JSON.stringify($scope.live), $scope.liveCallback);
    };

    $scope.questionCallback = function(result) {
        $scope.questionDisable = false;
        if (result.code == "200") {
            var text = "问禅排序方式修改成功";
            pageService.notys(text, "", "", "", "success");
            $scope.saveQuestion = false;
        }
        $scope.$apply();
    };
    $scope.saveQuestionButton = function() {
        $scope.questionDisable = true;
        $scope.question.value1 = $scope.questionCheck;
        pageService.postJson("/config/save", JSON.stringify($scope.question), $scope.questionCallback);
    };
    $scope.editLiveNumButton = function() {
        $scope.editLiveNum = false;
        $scope.saveLiveNum = true;
        $scope.liveRead = false;
        $scope.liveClass = "form-white";
    };
    $scope.liveNumCallback = function(result){
      $scope.liveNumDisable = false;
      if(result.code == "200"){
        var text = "直播自动排序限制设置成功";
        pageService.notys(text,"","","","success");
        $scope.liveClass = "";
        $scope.editLiveNum = true;
        $scope.saveLiveNum = false;
        $scope.liveRead = true;
      }else{
        pageService.serverError(result);
      }
      $scope.$apply();
    };
    $scope.saveLiveNumButton = function(){
      $scope.liveNumDisable = true;
      pageService.setBase();
      pageService.postJson("/config/save",JSON.stringify($scope.live),$scope.liveNumCallback);
    };

    $scope.editQuestionNumButton = function(){
      $scope.editQuestionNum = false;
      $scope.saveQuestionNum = true;
      $scope.questionRead = false;
      $scope.questionClass = "form-white";
    };

    $scope.questionNumCallback = function(result){
      $scope.questionNumDisable = false;
      if(result.code == "200"){
        var text = "问禅自动排序限制设置成功";
        pageService.notys(text,"","","","success");
        $scope.questionClass = "";
        $scope.editQuestionNum = true;
        $scope.saveQuestionNum = false;
        $scope.questionRead = true;
      }else{
        pageService.serverError(result);
      }
      $scope.$apply();
    };
    $scope.saveQuestionNumButton = function(){
      $scope.questionNumDisable = true;
      pageService.setBase();
      pageService.postJson("/config/save",JSON.stringify($scope.question),$scope.questionNumCallback);
    };
}]);
