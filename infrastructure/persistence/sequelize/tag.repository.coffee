BaseRepository = require('./base.repository')
BaseTagRepository = require('../shared/base.tag.repository')
Query = require('./query.builder')
Where = require('./where')
mixOf = require('../../../etc/mix_of')

debug = require('../../../etc/debug')('infra:persistence:TagRepository')

class TagRepository extends mixOf(BaseRepository,
                                  BaseTagRepository)
  getModel: () => @registry.domain.models.Tag

  findAllByPosterId: (posterId) =>
    posterId = Number(posterId)

    posterTagRepository =
      @registry.infrastructure.persistence.posterTagRepository

    posterTagRepository
      .findAllByPosterId(posterId)
      .map((posterTagRelation) -> posterTagRelation.get('tagId'))
      .then(@findAllByIds)

module.exports = (registry) ->
  return new TagRepository(registry)
