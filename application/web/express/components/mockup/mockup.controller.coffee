debug = require('../../../../../system/debug')('web:controller:home')

module.exports =
  index: (req, res) ->
    debug("show mockup called with params: #{req.query.t}")
    if req.query.t
      res.render(req.query.t)
    else
      res.send("?")
