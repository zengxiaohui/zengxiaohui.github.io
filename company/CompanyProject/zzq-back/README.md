# zzq-back
This is for Zhang Ziqing students developed an accounting management background, but also my first complete project

打包命令：
mvn clean package -Pproduction -Dmaven.test.skip=true -Dgulp.build=production

gulp插件需要修改的地方：
gulp-rev:index.js
if(normPath.indexOf("${ctx}") === 0){
	dependencyPath="src/main/webapp/"+normPath.replace("${ctx}", "");
}else{
	if (normPath.indexOf(path.sep) === 0) {
        dependencyPath = path.join(file.base, normPath);
    }
    else {
       dependencyPath = path.resolve(path.dirname(file.path), normPath);
    }
}

gulp-asset-rev:index.js
//src = src.replace(verStr, '').replace(/(\.[^\.]+)$/, verStr + "$1");
src=src+"?v="+verStr;


