_ = require('lodash')
QT = require('sequelize-qt')

BaseRepository = require('./base.repository')
BasePosterRepository = require('../shared/poster.repository.mixin')

mixOf = require('../../../etc/mix_of')
registry = require('../../../system/registry')

debug = require('../../../system/debug')('infra:persistence:PosterRepository')

{Condition, Query} = QT

class PosterRepository extends mixOf(BaseRepository,
                                     BasePosterRepository)
  getModel: () -> registry.instance().Poster

  findRecent: (options = {}) =>
    @findAll(
      Query.where(Condition.eq('deleted', false)).order('"createdAt" DESC')
    )

  findRecentByTagId: (tagId) =>
    tagId = Number(tagId)
    debug("tagId = #{tagId}")

    posterTagRepository = registry.instance().posterTagRepository

    posterTagRepository.findAllByTagId(tagId)
      .map((posterTagRelation) -> posterTagRelation.get('posterId'))
      .then((posterIds) ->
        debug(posterIds)
        return posterIds
      )
      .then(_.partial(
        @findAllByIds
        _
        Query.where(Condition.eq('deleted', false)).order('"createdAt" DESC')
      ))


module.exports = PosterRepository
