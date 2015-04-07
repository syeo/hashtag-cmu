_ = require('lodash')

debug = require('../../../etc/debug')('view:dehydrator:poster')
Promise = require('../../../config/promise')
BaseDehydrator = require('./base.dehydrator')


class PosterDehydrator extends BaseDehydrator
  default: (obj) =>
    posterImageRepository =
      @registry.infrastructure.persistence.posterImageRepository
    posterImageDehydrator =
      @registry.presenter.dehydrator.posterImageDehydrator

    tagRepository = @registry.infrastructure.persistence.tagRepository

    Promise.all([
      tagRepository.findAllByPoster(obj)
      posterImageRepository.findAllByPoster(obj)
    ]).spread((tags, posterImages) ->
      debug(tags)
      Promise.all([
        super(obj)
        posterImageDehydrator.list(
          posterImages
        )
      ])
    ).spread((res, images) ->
      _.extend(res, {
        images: images
      })
    )

module.exports = (registry) -> new PosterDehydrator(registry)