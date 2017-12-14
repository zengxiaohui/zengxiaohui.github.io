var express = require('express')
var ejs = require('ejs')
var path = require('path')
var port = process.env.PORT || 3000
var app = express()
app.engine('html', ejs.__express);
app.set('views','./')
app.set('view engine', 'html')
//__dirname当前目录
app.use(express.static(path.join(__dirname)))
app.listen(port)
console.log('imooc started on port'+port)

