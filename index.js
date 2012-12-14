var common = require('./common');

var limit = 1 * 1e3;
var mod = 'master';
var mongodb;
if (process.argv[2]) {
    var split = process.argv[2].split('-');
    mod = split[0];
    limit = parseInt(split[1], 10);
    mongodb = require('./' + mod);
}

new mongodb.Db('test', new mongodb.Server("127.0.0.1", 27017, {auto_reconnect: true}), {native_parser: true, safe: true}).open(function (error, client) {
    var c = new mongodb.Collection(client, 'tests');
    common.run(mod + '-' + limit, function (cb) {
        c.find().limit(limit).toArray(function (err, objs) {
            cb(err, {results: objs.length});
        });
    });
});
