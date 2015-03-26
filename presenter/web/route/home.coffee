home = require('../controller/home')

module.exports = (app) ->
  # Root routing
  app.route('/').get(home.index)
  app.route('/mockup').get(home.showMockUp)
