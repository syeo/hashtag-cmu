Promise = require('../../config/promise')

class BaseDehydrator
  constructor: (@registry) ->

  whole: (obj) -> obj
  skim: (obj) => @whole(obj)
  list: (objs) =>
    that = this
    Promise.map(objs, that.skim)

module.exports = BaseDehydrator