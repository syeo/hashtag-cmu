Promise = require('../../config/promise')

class BaseDehydrator
  constructor: (@registry) ->

  default: (obj) -> throw new Error("Method not implemented")
  whole: (obj) => @default(obj)
  skim: (obj) => @default(obj)

  list: (objs) =>
    Promise.map(objs, @skim)

module.exports = BaseDehydrator