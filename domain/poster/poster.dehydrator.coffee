_ = require('lodash')

Promise = require('../../system/promise')
registry = require('../../system/registry')
BaseDehydrator = require('../shared/base.dehydrator')

debug = require('../../system/debug')('view:dehydrator:poster')

class PosterDehydrator extends BaseDehydrator
  skim: (obj, context = {}) ->
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
        super(obj, context)
        userDehydrator.skim(user, context)
        tagDehydrator.list(tags, context)
        posterImageDehydrator.list(posterImages, context)
      ])
    ).spread((res, user, tags, images) ->
      _.extend(
        _.omit(res, 'ownerId')
        {
          owner: user
          images: images
          tags: tags
        }
      )
    )

module.exports = PosterDehydrator