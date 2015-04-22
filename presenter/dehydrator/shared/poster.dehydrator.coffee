_ = require('lodash')

debug = require('../../../system/debug')('view:dehydrator:poster')
Promise = require('../../../system/promise')
registry = require('../../../system/registry')
BaseDehydrator = require('./base.dehydrator')

class PosterDehydrator extends BaseDehydrator
  skim: (obj) ->
    posterImageRepository = registry.instance().posterImageRepository
    posterImageDehydrator = registry.instance().posterImageDehydrator

    tagRepository = registry.instance().tagRepository
    tagDehydrator = registry.instance().tagDehydrator

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

module.exports = () -> new PosterDehydrator()