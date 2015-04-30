Lens = require('data-lens')

tagsApiV1 = require('./tags.api_v1.controller')
tagsMiddlewares = require('./tags.middlewares')
authMiddlewares = require('../auth/auth.middlewares')

module.exports = (app) ->
  # Root routing
  app.route('/api/v1/tags')
    .all(authMiddlewares.loginRequired)
    .get(tagsApiV1.list)

  app.route('/api/v1/tags/:tagId(\\d+)')
    .all(
      authMiddlewares.loginRequired
      tagsMiddlewares.fetchTag(Lens.path('params.tagId'), 'tag')
    )
    .get(tagsApiV1.get)
