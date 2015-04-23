QT = require('sequelize-qt')

BaseRepository = require('./base.repository')
BasePosterTagRepository = require('../shared/poster_tag.repository.mixin')
mixOf = require('../../../etc/mix_of')
registry = require('../../../system/registry')

debug = require('../../../system/debug')('infra:persistence:PosterTagRepository')

Query = QT.Query
Condition = QT.Condition

class PosterTagRepository extends mixOf(BaseRepository,
                                        BasePosterTagRepository)
  getModel: () -> registry.instance().PosterTag

  findAllByPosterId: (posterId) =>
    posterId = Number(posterId)
    @findAll(Query.where(Condition.eq('posterId', posterId)))

  findAllByTagId: (tagId) =>
    tagId = Number(tagId)
    @findAll(Query.where(Condition.eq('tagId', tagId)))

module.exports = PosterTagRepository
