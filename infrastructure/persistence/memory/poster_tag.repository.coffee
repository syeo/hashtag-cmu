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
    @findAll().filter((relation) ->
      relation.get('posterId') == posterId
    )

  count: (options) =>
    filterFunc = @filterFunc

    @findAll().reduce((ret, relation) ->
      if filterFunc(relation, options)
        ret++

      return ret
    , 0)

module.exports = (registry) -> new PosterTagRepository(registry)
