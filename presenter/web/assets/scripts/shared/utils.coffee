_ = require('lodash')

Promise = require('../promise')

module.exports =
  makePromiseWithSuperagentRequest: (req) ->
    return Promise.promisify((cb) ->
      req.end((err, res) ->
        if err?
          cb(err, null)
        else
          if res.ok
            cb(null, res)
          else
            cb(res.error, null)
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