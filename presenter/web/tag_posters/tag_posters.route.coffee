tagPostersApiV1 = require('./tag_posters.api_v1.controller')

module.exports = (app) ->
  # Root routing
  app.route('/api/v1/tags/:tagId(\\d+)/posters').get(tagPostersApiV1.list)
