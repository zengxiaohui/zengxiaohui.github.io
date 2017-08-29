/**
 * 权限认证服务
 */
angular.module('adminApp').factory('authService', ['$scope', '$http', '$q', function ($scope, $http, $q) {
    var auth = {};
    auth.login = function (username, password) {
        var deferred = $q.defer();

        $http.post("http://localhost:9000/api/auth", {
            userName: username,
            password: password
        }).then(function(result) {
            auth.userInfo = {
                token: result.data.token
            };
            $window.sessionStorage["userInfo"] = JSON.stringify(userInfo);
            deferred.resolve(userInfo);
        }, function(error) {
            deferred.reject(error);
        });
    };

    return auth;
}]);