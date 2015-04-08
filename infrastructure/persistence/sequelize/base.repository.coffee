class BaseRepository
  constructor: (@registry) ->

  getModel: () -> throw new Error("Must override getModel method")

  getSequelize: => @registry.infrastructure.presistence.sequelize

  findById: (id) => @getModel().find(id)

  findAll: (options = {}) => @getModel().findAll(options)

  save: (obj) -> obj.save()

  bulkCreate: (dataArr) =>
    @getModel().bulkCreate(dataArr)

module.exports = BaseRepository