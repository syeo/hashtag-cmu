BaseRepository = require('./base.repository')
BasePosterTagRepository = require('../shared/base.poster_tag.repository')
Query = require('./query.builder')
Where = require('./where')
mixOf = require('../../../etc/mix_of')

debug = require('../../../etc/debug')('infra:persistence:PosterTagRepository')

class PosterTagRepository extends mixOf(BaseRepository,
                                        BasePosterTagRepository)
  getModel: () => @registry.domain.models.PosterTag

  findAllByPosterId: (posterId) =>
    posterId = Number(posterId)
    @findAll(Query.where(Where({ posterId: posterId })))

  findAllByTagId: (tagId) =>
    tagId = Number(tagId)
    @findAll(Query.where(Where({ tagId: tagId })))

module.exports = (registry) ->
  return new PosterTagRepository(registry)
