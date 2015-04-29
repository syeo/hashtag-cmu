path = require('path')
CombinedStream = require('combined-stream')

BasePosterImageService = require('./base.poster_image.service')
Promise = require('../../system/promise')
registry = require('../../system/registry')

debug = require('../../system/debug')('cloudinary.poster_image:service')

class LocalPosterImageService extends BasePosterImageService
  constructor: (config) ->
    @cloudinary = require('cloudinary')
    if config?
      @cloudinary.config(config)

    super()

  uploadFile: (file, options) =>
    cloudinary = @cloudinary

    PosterImage = registry.instance().PosterImage
    posterImageRepository = registry.instance().posterImageRepository

    Promise.promisify((cb) ->
      stream = CombinedStream.create()
      stream.append(file.buffer)
      stream.pipe(cloudinary.uploader.upload_stream((res) ->
        cb(null, res)
      ))
    )()
      .then((res) ->
        debug(res)
        posterImage = PosterImage.build({
          url: res.url
          secureUrl: res.secure_url
          ownerId: options.ownerId || options.owner.get('id')
        })
        posterImageRepository.save(posterImage)
      )

module.exports = LocalPosterImageService