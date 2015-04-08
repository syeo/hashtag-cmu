_ = require('lodash')

FixtureRepository = require('./fixture.repository')
Promise = require('../../../config/promise')

class TagRepository extends FixtureRepository
  constructor: (@registry) ->
    super(@registry, '../../../fixtures/tags.json')
    @relations = require('../../../fixtures/poster_tags.json')

  factory: (data) =>
    new @registry.domain.models.Tag(data)

  findAllByPoster: (poster) =>
    posterId = poster.get('id')
    tagIds = _.map(
      _.filter(@relations, (relation) -> relation.poster_id == posterId)
      (relation) -> relation.tag_id
    )
    Promise.all(_.map(tagIds, @findById))

module.exports = (registry) -> new TagRepository(registry)
