"use strict";
var gulp = require('gulp'),
    sourcemaps = require('gulp-sourcemaps'),
    sass = require('gulp-sass'),
    autoprefixer = require('gulp-autoprefixer'), //autoprefixer要和es6-promise一起才能使用
    base64 = require('gulp-base64'),
    cssnano = require('gulp-cssnano'),
    connect = require('gulp-connect');
require('es6-promise').polyfill();

var paths = {
    src:'src',
    src_sass : 'src/sass/**/*.scss',
    src_js : 'src/js/**/*.js',
    src_html:'src/html/**/*.html',
    plugin : 'src/plugin/',
    target:'dist/',
    target_css : 'dist/css/',
    target_js : 'dist/js/',
    target_html:'dist/html'
};
gulp.task('sass', function () {
    return gulp.src(paths.src_sass)//编译的文件
        .pipe(sourcemaps.init())//开始注入前缀
        .pipe(sass()) //编译scss文件
        .pipe(autoprefixer()) //加入前缀
        .pipe(cssnano()) //Minify CSS with cssnano
        .pipe(base64({
            //baseDir: paths.src_static,绝对路径时设置
            extensions: ['svg', 'png', /\.jpg#datauri$/i],
            // exclude:    [/\.server\.(com|net)\/dynamic\//, '--live.jpg'], 跳过具有与这些模式匹配的网址的文件
            maxImageSize: 8*1024, // 小于等于8kb的图片进行改为base64的格式
            deleteAfterEncoding: false, //是否保留原来的图片false表示保留
            debug: true //启用日志到控制台。
        })) //将图片编辑为base64
        .pipe(sourcemaps.write('.')) //加入源方便调试
        .pipe(gulp.dest(paths.target_css));//输出到css文件夹
});

gulp.task('indexHtml', function() {
    return gulp.src(paths.src+"/index.html")
        .pipe(gulp.dest(paths.target));
});
gulp.task('html', function() {
    return gulp.src(paths.src_html)
        .pipe(gulp.dest(paths.target_html));
});

/*js 合并管理*/
gulp.task('connect', function() {
    connect.server({
        root: paths.target,
        livereload: true, //启用实时刷新的功能
        port: 8081
    });
});
gulp.task('watch', function () {
    gulp.watch(paths.src + '/**/*', ['build']);
});
gulp.task('build', ['sass','indexHtml','html']);
gulp.task('default', ['build']);
gulp.task('run', ['connect','watch','default']);

