Query = require('./query.builder')
Where = require('./where')

debug = require('../../../etc/debug')('infra:persistence:BaseRepository')

class BaseRepository
  constructor: (@registry) ->

  getModel: () -> throw new Error("Must override getModel method")

  getSequelize: => @registry.infrastructure.presistence.sequelize

  findById: (id) => @getModel().find(id)

  findAll: (query = Query()) =>
    @getModel().findAll(query.end())

  findAllByIds: (ids, query = Query()) =>
    @findAll(
      query.and(Where({id: {$in: ids}}))
    )

  save: (obj) -> obj.save()

  bulkCreate: (dataArr) =>
    @getModel().bulkCreate(dataArr)

module.exports = BaseRepository