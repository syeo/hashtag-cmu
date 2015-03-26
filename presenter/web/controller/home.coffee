debug = require('../../../etc/debug')('web:controller:home')

module.exports =
  index: (req, res) ->
    debug('home controller called')
    res.render('home', {
      request: req
    })

  showMockUp: (req, res) ->
    debug("show mockup called with params: #{req.query.t}")
    if req.query.t
      res.render(req.query.t)
    else
      res.send("?")
