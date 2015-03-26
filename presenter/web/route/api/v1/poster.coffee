posters = require('../../../controller/api/v1/poster')

module.exports = (app) ->
  # Root routing
  app.route('/api/v1/posters').get(posters.list)
