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

module.exports = (registry) -> new PosterTagRepository(registry)
