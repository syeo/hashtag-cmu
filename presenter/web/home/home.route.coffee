home = require('./home.controller.coffee')

module.exports = (app) ->
  # Root routing
  app.route('/').get(home.index)
