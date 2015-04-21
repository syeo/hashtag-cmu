_ = require('lodash')
QT = require('sequelize-qt')

BaseRepository = require('./base.repository')
BasePosterRepository = require('../shared/base.poster.repository')

mixOf = require('../../../etc/mix_of')

debug = require('../../../etc/debug')('infra:persistence:PosterRepository')

Query = QT.Query

class PosterRepository extends mixOf(BaseRepository,
                                     BasePosterRepository)
  getModel: () => @registry.domain.models.Poster

  findRecent: (options = {}) =>
    @findAll(Query.order('"createdAt" DESC'))

  findRecentByTagId: (tagId) =>
    tagId = Number(tagId)
    debug("tagId = #{tagId}")

    posterTagRepository =
      @registry.infrastructure.persistence.posterTagRepository

    posterTagRepository.findAllByTagId(tagId)
      .map((posterTagRelation) -> posterTagRelation.get('posterId'))
      .then((posterIds) ->
        debug(posterIds)
        return posterIds
      )
      .then(_.partial(@findAllByIds, _, Query.order('"createdAt" DESC')))


module.exports = (registry) ->
  return new PosterRepository(registry)
