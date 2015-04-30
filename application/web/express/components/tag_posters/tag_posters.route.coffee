Lens = require('data-lens')

tagPostersApiV1 = require('./tag_posters.api_v1.controller')

authMiddlewares = require('../auth/auth.middlewares')
tagsMiddlewares = require('../tags/tags.middlewares')

module.exports = (app) ->
  app.route('/api/v1/tags/:tagId(\\d+)/posters')
    .get(
      authMiddlewares.loginRequired
      tagsMiddlewares.fetchTag(Lens.path('params.tagId'), 'tag')
      tagPostersApiV1.list
    )
