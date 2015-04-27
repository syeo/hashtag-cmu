_ = require('lodash')

Promise = require('../promise')
debug = require('../debug')('utils')

module.exports =
  makePromiseWithSuperagentRequest: (req) ->
    return Promise.promisify((cb) ->
      req.end((err, res) ->
        if err?
          cb(err, null)
        else
          cb(null, res)
      )
    )()

  getProperty: (obj, fullPath) ->
    return _.reduce(
      fullPath.split('.')
      (obj, key) ->
        if obj
          return obj[key]
        else
          return undefined
      obj
    )