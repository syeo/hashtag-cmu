Where = require('./where')

debug = require('../../../etc/debug')('infra:persistence:query_builder')

class QueryBuilder
  constructor: (@where = Where(), @order = undefined) ->

  getWhere: () => @where
  setWhere: (where) => @where = where

  getOrder: () => @order
  setOrder: (order) => @order = order

  and: (wheres...) =>
    debug(@getWhere())
    debug(wheres)
    @setWhere(@getWhere().and(wheres...))
    return @

  or: (wheres...) =>
    @setWhere(@getWhere().or(wheres...))
    return @

  not: () =>
    @setWhere(@getWhere().not())
    return @

  orderBy: (order) =>
    @setOrder(order)
    return @

  end: () =>
    {
      where: @getWhere().end()
      order: @getOrder()
    }

factory = (where, order) -> new QueryBuilder(where, order)
factory.order = (order) -> factory(undefined, order)
factory.where = (where) -> factory(where, undefined)

module.exports = factory
