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

  findAll: =>
    @getDictionary()
      .then(_.values)
      .then(_.partial(_.clone, _, true))

  findById: (id) =>
    @getDictionary()
      .then((dict) -> dict[id]).then(_.clone)

  findAllByIds: (ids) =>
    @getDictionary()
      .then(_.partial(_.pick, _, ids))
      .then(_.partial(_.clone, _, true))

  count: (options) =>
    @findAll()
      .filter(_.partial(@filterFunc, _, options))
      .then(_.size)

module.exports = BaseRepository