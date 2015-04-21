QT = require('sequelize-qt')

BaseRepository = require('./base.repository')
BasePosterImageRepository = require('../shared/base.poster_image.repository')
mixOf = require('../../../etc/mix_of')

debug = require('../../../etc/debug')('infra:persistence:PosterImageRepository')

Query = QT.Query
Condition = QT.Condition

class PosterImageRepository extends mixOf(BaseRepository,
                                          BasePosterImageRepository)
  getModel: () => @registry.domain.models.PosterImage

  findAllByPosterId: (posterId) =>
    posterId = Number(posterId)
    return @findAll(Query.where(Condition.eq('posterId', posterId)))

module.exports = (registry) ->
  return new PosterImageRepository(registry)
