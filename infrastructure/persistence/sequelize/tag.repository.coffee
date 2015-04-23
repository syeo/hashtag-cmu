QT = require('sequelize-qt')

BaseRepository = require('./base.repository')
BaseTagRepository = require('../shared/tag.repository.mixin')
mixOf = require('../../../etc/mix_of')
registry = require('../../../system/registry')

debug = require('../../../system/debug')('infra:persistence:TagRepository')

Query = QT.Query
Condition = QT.Condition

class TagRepository extends mixOf(BaseRepository,
                                  BaseTagRepository)
  getModel: () -> registry.instance().Tag

  findAllByPosterId: (posterId) =>
    posterId = Number(posterId)

    posterTagRepository = registry.instance().posterTagRepository

    posterTagRepository
      .findAllByPosterId(posterId)
      .map((posterTagRelation) -> posterTagRelation.get('tagId'))
      .then(@findAllByIds)

module.exports = TagRepository
