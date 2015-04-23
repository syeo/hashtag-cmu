QT = require('sequelize-qt')

registry = require('../../../system/registry')

debug = require('../../../system/debug')('infra:persistence:BaseRepository')

Query = QT.Query
Condition = QT.Condition

class BaseRepository
  getModel: () -> throw new Error("Must override getModel method")

  getSequelize: -> registry.instance().sequelize

  findById: (id) => @getModel().find(id)

  find: (query = Query()) =>
    @getModel().find(query.end())

  findAll: (query = Query()) =>
    @getModel().findAll(query.end())

  findAllByIds: (ids, query = Query()) =>
    @findAll(
      query.and(Condition.in('id', ids))
    )

  save: (obj) -> obj.save()

  bulkCreate: (dataArr) =>
    @getModel().bulkCreate(dataArr)

module.exports = BaseRepository