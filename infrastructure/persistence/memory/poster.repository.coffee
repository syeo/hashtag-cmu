_ = require('lodash')

FixtureRepository = require('./fixture.repository')
BasePosterRepository = require('../shared/base.poster.repository')
Promise = require('../../../config/promise')
mixOf = require('../../../etc/mix_of')

debug = require('../../../etc/debug')('poster:repository')

class PosterRepository extends mixOf(FixtureRepository, BasePosterRepository)
  constructor: (@registry) ->
    super(@registry, '../../../fixtures/posters.json')

  factory: (data) =>
    new @registry.domain.models.Poster(data)

  findRecent: (options = {}) =>
    posterTagRepository =
      @registry.infrastructure.persistence.posterTagRepository

    @findAll().then((posters) ->
      postersPromise = Promise.resolve(posters)

      if options.filter?.tag?
        tagIds = options.filter.tag

        tagIds = _.map(
          if _.isArray(tagIds) then tagIds else [tagIds]
          (tagId) -> Number(tagId)
        )

        postersPromise = postersPromise.filter((poster) ->
          posterTagRepository.count({
            posterId: poster.get('id')
            tagId:
              in: tagIds
          }).then((count) -> count == _.size(tagIds))
        )

      postersPromise
    ).then((posters) ->
      posters.reverse()
    )

  findRecentByTagId: (tagId) =>
    tagId = Number(tagId)

    posterTagRepository =
      @registry.infrastructure.persistence.posterTagRepository

    posterTagRepository.findAllByTagId(tagId)
      .map((posterTagRelation) -> posterTagRelation.get('posterId'))
      .then(@findAllByIds)
      .then(_.values)
      .then((posters) ->
        posters.reverse()
      )

module.exports = (registry) -> new PosterRepository(registry)
