posters = require('../../../controllers/api/v1/posters')

module.exports = (app) ->
  # Root routing
  app.route('/api/v1/posters').get(posters.list)
