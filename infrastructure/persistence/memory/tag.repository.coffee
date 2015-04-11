_ = require('lodash')

FixtureRepository = require('./fixture.repository')
Promise = require('../../../config/promise')

debug = require('../../../etc/debug')('tag:repository')

class TagRepository extends FixtureRepository
  constructor: (@registry) ->
    super(@registry, '../../../fixtures/tags.json')

  factory: (data) =>
    new @registry.domain.models.Tag(data)

  findAllByPoster: (poster) =>
    posterTagRepository =
      @registry.infrastructure.persistence.posterTagRepository

    posterTagRepository
      .findAllByPoster(poster)
      .then((posterTagRelations) ->
        debug(posterTagRelations)
        return posterTagRelations
      )
      .map((posterTagRelation) -> posterTagRelation.get('tagId'))
      .map(@findById)

module.exports = (registry) -> new TagRepository(registry)
