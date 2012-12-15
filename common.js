// adopted from https://raw.github.com/felixge/faster-than-c/master/figures/common.js
var duration = 60 * 1000;

exports.run = function(name, benchmark, options) {
  options = options || {};
  var startup = Date.now();

  var number = 0;

  function run() {
    if (startup + duration < Date.now()) {
      process.exit(0);
      return;
    }

    var start = process.hrtime();
    benchmark(function (err, extra) {
      var duration = process.hrtime(start);
      duration = (duration[0] * 1e3) + duration[1] / 1e6;

      if (err) throw err;

      var memory   = process.memoryUsage();

      var results = {
        benchmark   : name,
        number      : ++number,
        duration    : duration,
        time        : Date.now(),
        rss         : memory.rss,
        heapUsed    : memory.heapUsed,
        heapTotal   : memory.heapTotal,
      };

      for (var key in extra) {
        results[key] = extra[key];
      }

      if (options.print !== false)
        print(results);

      process.nextTick(run);
    });
  }

  for (var i = 0; i < (options.concurrent || 1); i++)
    run();
};

var printedKeys = false;
function print(results) {
  var keys = Object.keys(results);
  if (!printedKeys) {
    console.log(keys.join('\t'));
    printedKeys = true;
  }

  var values = keys.map(function(key) {
    return results[key];
  });

  console.log(values.join('\t'));
};

