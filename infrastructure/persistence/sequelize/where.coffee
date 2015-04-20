_ = require('lodash')

debug = require('../../../etc/debug')('infra:persistence:where')

class Where
  @and: (wheres...) ->
    debug(wheres)
    new Where({$and: _.map(wheres, (where) -> where.end())})

  @or: (wheres...) ->
    new Where({$or: _.map(wheres, (where) -> where.end())})

  @not: (where) ->
    new Where({$not: [where.end()]})

  constructor: (@innerValue = {})->

  and: (wheres...) => Where.and(@, wheres...)

  or: (wheres...) => Where.or(@, wheres...)

  not: () => Where.not(@)

  end: => @innerValue

factory = (value) -> new Where(value)
factory.and = (wheres...) -> Where.and(wheres...)
factory.or = (wheres...) -> Where.or(wheres...)
factory.not = (where) -> Where.not(where)

module.exports = factory