// 引入gulp
var gulp = require('gulp'); // 基础库
var sftp = require('gulp-sftp');
// 引入gulp插件
var livereload = require('gulp-livereload'), // 网页自动刷新（服务器控制客户端同步刷新）
    webserver = require('gulp-webserver'); // 本地服务器
// 注册任务
gulp.task('webserver', function() {
    gulp.src('./') // 服务器目录（./代表根目录）
        .pipe(webserver({ // 运行gulp-webserver
            livereload: true, // 启用LiveReload
            open: true,
            open: '/app' // 服务器启动时自动打开网页
        }));
});
// TODO 处理HTML,CSS,JS
gulp.task('html', function() {});
gulp.task('scripts', function() {});
gulp.task('styles', function() {});
// 监听任务
gulp.task('watch', function() {
    gulp.watch('*.html', ['html']); // 监听根目录下所有.html文件
    gulp.watch('*.js', ['scripts']); //
    gulp.watch('*.css', ['styles']); //
});
//上传到远程服务器任务

gulp.task('upload-t', function() {
    return gulp.src(['./**', '!node_modules/**', '!global/**', '!plugins/**']).pipe(sftp({
        host: '139.224.104.67',
        user: 'root',
        port: '22',
        pass: 'fsplus*2016',
        remotePath: '/root/test/admin'
    }));
});
gulp.task('upload', function() {
    return gulp.src(['./**', '!node_modules/**', '!global/**', '!plugins/**']).pipe(sftp({
        host: '121.41.90.22',
        user: 'root',
        port: '22',
        pass: 'eva*2016',
        remotePath: '/home/evatest/admins/fsplus-admin'
    }));
});

gulp.task('upload-n', function() {
    return gulp.src(['./**', '!node_modules/**', '!global/**', '!plugins/**']).pipe(sftp({
        host: '139.224.104.67',
        user: 'root',
        port: '22',
        pass: 'fsplus*2016',
        remotePath: '/root/prod/admin'
    }));
});
// 默认任务
gulp.task('default', ['webserver', 'watch']);
