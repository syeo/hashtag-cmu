_ = require('lodash')

class BaseRepository
  constructor: (@registry) ->

  factory: -> throw new Error("Method not implemented")
  getDictionary: -> throw new Error("Method not implemented")
  save: -> throw new Error("Method not implemented")

  filterFunc: (obj, options) ->
    _.all(options, (option, key) ->
      val = obj.get(key)

      ret = false

      if _.isObject(option)
        if option.in?
          ret = _.contains(option.in, val)

      else
        ret = val == option

      return ret
    )

  findAll: => @getDictionary().then(_.values)
  findById: (id) => @getDictionary().then((dict) -> dict[id])

module.exports = BaseRepository