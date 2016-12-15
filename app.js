/**
 * Expressサーバ
 */

var http = require('http');
var express = require('express');
var routes = require('./routes');
var morgan = require('morgan'); // logger
var bodyParser = require('body-parser');
var multer = require('multer');
var methodOverride = require('method-override');
var errorhandler = require('errorhandler');
var serveStatic = require('serve-static'); // 静的ファイルを提供
var basicAuthConnect = require('basic-auth-connect');

var app = express();
var server = http.createServer(app);


// ==================== サーバー構成 ====================
app.use(bodyParser());
app.use(methodOverride());
app.use(basicAuthConnect('jill', 'pandora'));
app.use(serveStatic(__dirname + '/public', {'index': ['index.html']})); // __dirnameはnodeで実行したファイルパス

// local or heroku
// app.set('mode', 'local');
app.set('mode', 'heroku');
if (app.get('mode') === 'local') {
    app.set('port', 3000);
} else {
    app.set('port', process.env.PORT || 5000);
}

// 開発モードのみ
if (app.get('env') === 'development') {
    app.use(morgan('combined'));
    app.use(errorhandler({
        dumpExceptions: true,
        showStack: true
    }));
}

// 製品モードのみ
if (app.get('env') === 'production') {
    app.use(errorhandler());
}

routes.configRoutes(app, server);

// ==================== サーバー起動 ====================
//指定したポートでリクエスト待機状態にする
app.listen(app.get('port'), function () {
    console.log('Express server listening on port %d in %s mode', app.get('port'), app.settings.env);
});
