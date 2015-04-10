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

      if _.has(options.filter, 'tag')
        tagIds = options.filter.tag

        if not _.isArray(tagIds)
          tagIds = [tagIds]

        postersPromise = postersPromise.then((posters) ->
          Promise
            .all(_.map(posters, tagRepository.findAllByPoster))
            .then((tagsArray) ->
              _.map(
                _.filter(
                  _.zip(posters, tagsArray),
                  (posterTagsTuple) ->
                    poster = posterTagsTuple[0]
                    tags = posterTagsTuple[1]
                    _.any(tags, (tag) -> _.contains(tagIds, tag.get('id')))
                )
                _.first
              )
            )
        )

      postersPromise
    ).then((posters) ->
      _.takeRight(posters, options.pageSize).reverse()
    )

module.exports = (registry) -> new PosterRepository(registry)
