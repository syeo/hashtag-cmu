Lens = require('data-lens')

postersApiV1 = require('./posters.api_v1.controller')
postersMiddlewares = require('./posters.middlewares')
authMiddlewares = require('../auth/auth.middlewares')

module.exports = (app) ->
  # Root routing
  app.route('/api/v1/posters')
    .all(authMiddlewares.loginRequired)
    .get(postersApiV1.list)

  app.route('/api/v1/posters/:posterId(\\d+)')
    .all(
      authMiddlewares.loginRequired
      postersMiddlewares.fetchPoster(Lens.path('params.posterId'), 'poster')
    )
    .get(postersApiV1.get)
    .delete(postersApiV1.delete)
    .put(postersApiV1.update)
