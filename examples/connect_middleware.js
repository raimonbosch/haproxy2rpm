/**
 * Profile the duration of a request.
 *
 * Example Output:
 *
 *      GET / 200 2
 *
 *
 * Example usage:
 *
 * npm install ain2
 *
 * var SysLogger = require('ain2');
 * var profiler = require('./connect_middleware.js');
 * app.use(profiler(new SysLogger({ tag : "newrelic", facility : 'local0' })));
 *
 *
 * @api public
 */
module.exports = function profiler(_logger){
    return function(req, res, next){
        var end = res.end
        , start = new Date()
        , logger = _logger || console;

    // proxy res.end()
    res.end = function(data, encoding){
        res.end = end;
        res.end(data, encoding);
        logger.log(req.method, req.url, res.statusCode, ((new Date) - start));
    };

    next();
  }
};
