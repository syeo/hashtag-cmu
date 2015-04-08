_ = require('lodash')

class BaseMemoryModel
  constructor: (@dataValue = {}) ->

  get: (key) =>
    if _.isObject(key) and key.plain
      return _.cloneDeep(@dataValue)
    else
      return @dataValue[key]

  set: (key, value) => @dataValue[key] = value


module.exports = BaseMemoryModel