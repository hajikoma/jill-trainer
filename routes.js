/**
 * ルーティングを提供するモジュール
 */


var configRoutes;
var mongodb = require('mongodb').MongoClient;
var assert = require('assert');

// Connection URL
var url = 'mongodb://heroku_8js0d6lr:7uk0ufmgqrq4fof1pbsmn56d6u@ds133398.mlab.com:33398/heroku_8js0d6lr';
// var url = 'mongodb://localhost:27017/jill-trainer';


configRoutes = function (app, server) {
    // // ルーティング
    app.all('/api/:collection_name/*?')
        .get(function () {
            res.contentType('json');
            next(); // ルーティング処理継続
        });

    // 月単位
    app.route('/api/:collection_name/:year([0-9]{4})/:month([0-9]{1,2})')
        .get(function (req, res) {
            mongodb.connect(url, function (err, db) {
                assert.equal(null, err);
                console.log("Connected correctly to server");

                // Get documents that match the query
                db.collection(req.params.collection_name)
                    .find({
                        day: new RegExp('^' + req.params.year + '/' + req.params.month).toString()
                    })
                    .toArray(function (err, docs) {
                        assert.equal(null, err);
                        res.send(docs);
                        db.close();
                    });
            });
        });

    // コレクション全体
    app.route('/api/:collection_name')
        .get(function (req, res) {
            mongodb.connect(url, function (err, db) {
                assert.equal(null, err);
                // Get all documents
                db.collection(req.params.collection_name)
                    .find()
                    .toArray(function (err, docs) {
                        assert.equal(null, err);
                        res.send(docs);
                        db.close();
                    });
            });
        })
        .post(function (req, res) {
            var data = req.body;
            mongodb.connect(url, function (err, db) {
                assert.equal(null, err);
                // Insert a single document
                //noinspection JSCheckFunctionSignatures
                db.collection(req.params.collection_name).insertOne(
                    data,
                    function (err, r) {
                        assert.equal(null, err);
                        assert.equal(1, r.insertedCount);
                        db.close();
                        res.send();
                    }
                );
            });
        });

    app.route('*')
        .get(function (req, res) {
            res.sendFile(__dirname + '/public/index.html');
        });
};

// nodeモジュール内では、var変数はそのモジュール内スコープになる（自己実行型無名関数は不要）
// エクスポートするには↓
module.exports = {configRoutes: configRoutes};