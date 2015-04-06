debug = require('../../../etc/debug')('web:controller:home')

module.exports =
  index: (req, res) ->
    debug('home controller called')
    res.render('home/home.template.swig', {
      request: req
    })
