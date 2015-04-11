tagsApiV1 = require('./tags.api_v1.controller')

module.exports = (app) ->
  # Root routing
  app.route('/api/v1/tags').get(tagsApiV1.list)
  app.route('/api/v1/tags/:tagId(\\d+)').get(tagsApiV1.get)
