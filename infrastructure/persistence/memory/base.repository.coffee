_ = require('lodash')

class BaseRepository
  constructor: (@registry) ->

  factory: -> throw new Error("Method not implemented")
  getDictionary: -> throw new Error("Method not implemented")
  save: -> throw new Error("Method not implemented")

  findAll: => @getDictionary().then(_.values)
  findById: (id) => @getDictionary().then((dict) -> dict[id])

module.exports = BaseRepository