QT = require('sequelize-qt')

BaseRepository = require('./base.repository')
BasePosterImageRepository = require('../shared/base.poster_image.repository')
mixOf = require('../../../etc/mix_of')
registry = require('../../../system/registry')

debug = require('../../../system/debug')('infra:persistence:PosterImageRepository')

Query = QT.Query
Condition = QT.Condition

class PosterImageRepository extends mixOf(BaseRepository,
                                          BasePosterImageRepository)
  getModel: () -> registry.instance().PosterImage

  findAllByPosterId: (posterId) =>
    posterId = Number(posterId)
    return @findAll(Query.where(Condition.eq('posterId', posterId)))

module.exports = PosterImageRepository
