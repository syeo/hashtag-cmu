posterImagesApiV1 = require('./poster_images.api_v1.controller')

authMiddlewares = require('../auth/auth.middlewares')

module.exports = (app) ->
  # Root routing
  app.route('/api/v1/poster-images')
    .all(authMiddlewares.loginRequired)
    .post(posterImagesApiV1.create)
