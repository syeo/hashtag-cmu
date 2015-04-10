_ = require('lodash')

FixtureRepository = require('./fixture.repository')
Promise = require('../../../config/promise')

debug = require('../../../etc/debug')('poster:repository')

class PosterRepository extends FixtureRepository
  constructor: (@registry) ->
    super(@registry, '../../../fixtures/posters.json')

  factory: (data) =>
    new @registry.domain.models.Poster(data)

  getRecentPosts: (limit) =>
    @getRecentPostsWithOptions({
      pageSize:limit
    })

  getRecentPostsWithOptions: (options) =>
    tagRepository = @registry.infrastructure.persistence.tagRepository

    @findAll().then((posters) ->
      postersPromise = Promise.resolve(posters)

      if options.filter?.tag?
        tagIds = options.filter.tag

        tagIds = _.map(
          if _.isArray(tagIds) then tagIds else [tagIds]
          (tagId) -> Number(tagId)
        )

        postersPromise = postersPromise.filter((poster) ->
          tagRepository.exists({
            posterId: poster.get('id')
            tagId:
              in: tagIds
          })
        )

      postersPromise
    ).then((posters) ->
      _.takeRight(posters, options.pageSize).reverse()
    )

module.exports = (registry) -> new PosterRepository(registry)
