QT = require('sequelize-qt')

debug = require('../../../etc/debug')('infra:persistence:BaseRepository')

Query = QT.Query
Condition = QT.Condition

class BaseRepository
  constructor: (@registry) ->

  getModel: () -> throw new Error("Must override getModel method")

  getSequelize: => @registry.infrastructure.presistence.sequelize

  findById: (id) => @getModel().find(id)

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