home = require('../controller/home.server.controller')

module.exports = (app) ->
  # Root routing
  app.route('/').get(home.index)
