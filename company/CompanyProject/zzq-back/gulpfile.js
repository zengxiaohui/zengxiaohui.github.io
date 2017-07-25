"use strict";
var gulp = require('gulp'),
	sourcemaps = require('gulp-sourcemaps'),
	sass = require('gulp-sass'),
	autoprefixer = require('gulp-autoprefixer'), //autoprefixer要和es6-promise一起才能使用
	base64 = require('gulp-base64'),
	cssnano = require('gulp-cssnano'),
	replace = require('gulp-replace'),
	gp_if = require('gulp-if'),
	gp_uglify = require('gulp-uglify'),
	gulp_rev = require('gulp-rev-append'),
	assetRev = require('gulp-asset-rev'),
	cleanhtml = require('gulp-cleanhtml'),
	useref = require('gulp-useref');
require('es6-promise').polyfill();

var paths = {
  webapp : 'src/main/webapp/',
  src_html : 'src/main/webapp/WEB-INF/template/**/*.jsp',
  src_sass : 'src/main/webapp/static/sass/**/*.scss',
  src_js : 'src/main/webapp/static/javascript/',
  plugin : 'src/main/webapp/static/plugin/',
  target_html : 'src/main/webapp/WEB-INF/view/',
  target_css : 'src/main/webapp/static/css/',
  target_js : 'src/main/webapp/static/js/'
};

/*js 合并管理*/
gulp.task('html', function () {
    return gulp.src(paths.src_html)
    	.pipe(gp_if('*.jsp', gulp_rev()))
    	.pipe(replace('replace="gulp" src="${ctx}','src="'))
        .pipe(useref({
            searchPath: paths.webapp
        }))
        .pipe(gp_if('*.jsp', cleanhtml()))
        .pipe(gp_if('*.js', gp_uglify()))
        .pipe(gulp.dest(paths.target_html));
});

/*测试环境下对sass进行编译*/
gulp.task('sass-test', function () {
  return gulp.src(paths.src_sass)//编译的文件
  	.pipe(sourcemaps.init())//开始注入前缀
	.pipe(sass()) //编译scss文件
	.pipe(autoprefixer()) //加入前缀
	.pipe(sourcemaps.write('.')) //加入源方便调试
    .pipe(gulp.dest(paths.target_css));//输出到css文件夹
});

/*生产环境下对sass进行编译*/
gulp.task('sass-production', function () {
  return gulp.src(paths.src_sass)//编译的文件
	.pipe(sass()) //编译scss文件
	.pipe(base64({
        //baseDir: paths.src_static,绝对路径时设置
        extensions: ['svg', 'png', /\.jpg#datauri$/i],
        // exclude:    [/\.server\.(com|net)\/dynamic\//, '--live.jpg'], 跳过具有与这些模式匹配的网址的文件
        maxImageSize: 8*1024, // 小于等于8kb的图片进行改为base64的格式
        deleteAfterEncoding: false, //是否保留原来的图片false表示保留
        debug: true //启用日志到控制台。
    })) //将图片编辑为base64
    .pipe(assetRev())
	.pipe(autoprefixer()) //加入前缀
	.pipe(cssnano()) //Minify CSS with cssnano
    .pipe(gulp.dest(paths.target_css));//输出到css文件夹
});

gulp.task('test', ['sass-test']);
gulp.task('production', ['sass-production','html']);
gulp.task('default', ['test']);
