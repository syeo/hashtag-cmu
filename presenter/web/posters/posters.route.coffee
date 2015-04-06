postersApiV1 = require('./posters.api_v1.controller')

module.exports = (app) ->
  # Root routing
  app.route('/api/v1/posters').get(postersApiV1.list)
