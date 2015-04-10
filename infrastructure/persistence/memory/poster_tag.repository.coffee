_ = require('lodash')

FixtureRepository = require('./fixture.repository')
Promise = require('../../../config/promise')

class PosterTagRepository extends FixtureRepository
  constructor: (@registry) ->
    super(@registry, '../../../fixtures/poster_tags.json')

  factory: (data) =>
    new @registry.domain.models.PosterTag(data)

  findAllByPoster: (poster) =>
    posterId = poster.get('id')
    @findAll()
      .filter((relation) ->
        relation.get('posterId') == posterId
      )

  count: (options) =>
    @findAll()
      .filter(_.curry(@filterFunc)(_, options))
      .then(_.size)

module.exports = (registry) -> new PosterTagRepository(registry)
