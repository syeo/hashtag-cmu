Promise = require('../../config/promise')

class BaseDehydrator
  constructor: (@registry) ->

  whole: (obj) => @skim(obj)
  skim: (obj) => @default(obj)

  list: (objs) =>
    Promise.map(objs, @skim)

module.exports = BaseDehydrator