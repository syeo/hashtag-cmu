path = require('path')
fs = require('fs')
mkdirp = require('mkdirp')

BasePosterImageService = require('./base.poster_image.service')
Promise = require('../../system/promise')
registry = require('../../system/registry')

debug = require('../../system/debug')('local.poster_image:service')

writeFile = Promise.promisify(fs.writeFile)

class LocalPosterImageService extends BasePosterImageService
  constructor: (@location, @urlPrefix) ->
    mkdirp.sync(@location)
    super()

  uploadFile: (file, options) =>
    PosterImage = registry.instance().PosterImage
    posterImageRepository = registry.instance().posterImageRepository

    filename = @createFilename() + path.extname(file.filename)

    writeFile(
      path.join(@location, filename)
      file.buffer
    ).bind(@)
      .then(() ->
        posterImage = PosterImage.build({
          url: path.join(@urlPrefix, filename)
          secureUrl: path.join(@urlPrefix, filename)
          ownerId: options.ownerId || options.owner.get('id')
        })
        posterImageRepository.save(posterImage)
      )



module.exports = LocalPosterImageService