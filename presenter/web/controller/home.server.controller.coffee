debug = require('../../../etc/debug')('web:controller:home')

module.exports =
  index: (req, res) ->
    debug('home controller called')
    res.render('home.index.server.view.jade', {
      request: req
    })
