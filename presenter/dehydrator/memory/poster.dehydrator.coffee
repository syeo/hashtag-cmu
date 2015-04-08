_ = require('lodash')

debug = require('../../../etc/debug')('view:dehydrator:poster')
Promise = require('../../../config/promise')
BaseDehydrator = require('./base.dehydrator')


class PosterDehydrator extends BaseDehydrator
  skim: (obj) =>
    posterImageRepository =
      @registry.infrastructure.persistence.posterImageRepository
    posterImageDehydrator =
      @registry.presenter.dehydrator.posterImageDehydrator

    tagRepository = @registry.infrastructure.persistence.tagRepository
    tagDehydrator = @registry.presenter.dehydrator.tagDehydrator

    Promise.all([
      tagRepository.findAllByPoster(obj)
      posterImageRepository.findAllByPoster(obj)
    ]).spread((tags, posterImages) ->
      Promise.all([
        super(obj)
        posterImageDehydrator.list(posterImages)
        tagDehydrator.list(tags)
      ])
    ).spread((res, images, tags) ->
      _.extend(res, {
        images: images
        tags: tags
      })
    )

module.exports = (registry) -> new PosterDehydrator(registry)