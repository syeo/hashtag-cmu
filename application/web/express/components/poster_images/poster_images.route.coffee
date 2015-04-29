posterImagesApiV1 = require('./poster_images.api_v1.controller')

module.exports = (app) ->
  # Root routing
  app.route('/api/v1/poster-images')
    .post(posterImagesApiV1.create)
