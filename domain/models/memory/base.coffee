_ = require('lodash')
changeCase = require('change-case')

class BaseMemoryModel
  constructor: (_dataValue = {}) ->
    @dataValue = {}
    _.each(_dataValue, (value, key) ->
      @dataValue[changeCase.camel(key)] = value
    @)

  get: (key) =>
    if _.isObject(key) and key.plain
      return _.cloneDeep(@dataValue)
    else
      return @dataValue[key]

  set: (key, value) => @dataValue[key] = value


module.exports = BaseMemoryModel