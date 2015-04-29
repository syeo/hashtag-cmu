registry = require('../../../../../system/registry')

debug = require('../../../../../system/debug')('poster_images:api_v1:controller')

posterImageService = registry.instance().posterImageService

module.exports =
  create: (req, res) ->
    posterImageService.uploadFile(req.files['image'], {owner: req.user})
      .then((posterImage) ->
        res.json({posterImage: posterImage.get({plain: true})})
      )

