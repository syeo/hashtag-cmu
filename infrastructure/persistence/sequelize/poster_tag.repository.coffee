QT = require('sequelize-qt')

BaseRepository = require('./base.repository')
BasePosterTagRepository = require('../shared/base.poster_tag.repository')
mixOf = require('../../../etc/mix_of')

debug = require('../../../etc/debug')('infra:persistence:PosterTagRepository')

Query = QT.Query
Condition = QT.Condition

class PosterTagRepository extends mixOf(BaseRepository,
                                        BasePosterTagRepository)
  getModel: () => @registry.domain.models.PosterTag

  findAllByPosterId: (posterId) =>
    posterId = Number(posterId)
    @findAll(Query.where(Condition.eq('posterId', posterId)))

  findAllByTagId: (tagId) =>
    tagId = Number(tagId)
    @findAll(Query.where(Condition.eq('tagId', tagId)))

module.exports = (registry) ->
  return new PosterTagRepository(registry)
