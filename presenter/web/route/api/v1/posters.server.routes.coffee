posters = require('../../../controller/api/v1/posters.server.controller')

module.exports = (app) ->
  # Root routing
  app.route('/api/v1/posters').get(posters.list)
