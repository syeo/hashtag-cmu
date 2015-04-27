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

    userRepository = registry.instance().userRepository
    userDehydrator = registry.instance().userDehydrator

    Promise.all([
      userRepository.findById(obj.get('ownerId'))
      tagRepository.findAllByPoster(obj)
      posterImageRepository.findAllByPoster(obj)
    ]).spread((user, tags, posterImages) ->
      Promise.all([
        super(obj)
        userDehydrator.skim(user)
        tagDehydrator.list(tags)
        posterImageDehydrator.list(posterImages)
      ])
    ).spread((res, user, tags, images) ->
      _.extend(res, {
        user: user
        images: images
        tags: tags
      })
    )

module.exports = PosterDehydrator