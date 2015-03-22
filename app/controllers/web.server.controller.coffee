debug = require('debug')('watchmen:controller:web')

module.exports =
  index: (req, res) ->
    debug('web controller called')
    res.render('index', {
      request: req
    })
