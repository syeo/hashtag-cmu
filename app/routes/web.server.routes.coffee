web = require('../controllers/web.server.controller')

module.exports = (app) ->
  # Root routing
  app.route('/').get(web.index)
