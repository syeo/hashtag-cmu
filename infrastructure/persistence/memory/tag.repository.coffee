_ = require('lodash')

FixtureRepository = require('./fixture.repository')
Promise = require('../../../config/promise')

class TagRepository extends FixtureRepository
  constructor: (@registry) ->
    super(@registry, '../../../fixtures/tags.json')
    @posterRelations = require('../../../fixtures/poster_tags.json')

  factory: (data) =>
    new @registry.domain.models.Tag(data)

  findAllByPoster: (poster) =>
    posterId = poster.get('id')
    tagIds = _.map(
      _.filter(@posterRelations, (posterRelation) ->
        posterRelation.poster_id == posterId
      )
      (posterRelation) -> posterRelation.tag_id
    )
    Promise.all(_.map(tagIds, @findById))

  exists: (options) =>
    _.any(@posterRelations, (posterRelation) ->
      ret = true

      if options.posterId?
        ret &= @filter(posterRelation.poster_id, options.posterId)

      if options.tagId?
        ret &= @filter(posterRelation.tag_id, options.tagId)

      return ret
    , @)

module.exports = (registry) -> new TagRepository(registry)
