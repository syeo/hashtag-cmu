debug = require('../../../etc/debug')('web:controller:home')

module.exports =
  index: (req, res) ->
    debug('home controller called')
    res.render('home', {
      request: req
    })

  showMockUp: (req, res) ->
    debug("show mockup called with params: #{req.param('t')}")
    if req.param('t')
      res.render(req.param('t'))
    else
      res.send("?")
