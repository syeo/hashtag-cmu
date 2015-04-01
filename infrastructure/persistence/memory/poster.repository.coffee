_ = require('lodash')

FixtureRepository = require('./fixture.repository')

class PosterRepository extends FixtureRepository
  constructor: (@registry) ->
    super(@registry, '../../../fixtures/posters.json')

  factory: (data) =>
    new @registry.domain.models.Poster(data)

  getRecentPosts: (limit) ->
    @findAll().then((posters) ->
      _.takeRight(posters, limit).reverse()
    )

module.exports = (registry) -> new PosterRepository(registry)
