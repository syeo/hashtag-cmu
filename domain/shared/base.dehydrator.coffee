Promise = require('../../system/promise')

class BaseDehydrator
  whole: (obj, context = {}) => @skim(obj, context)
  skim: (obj, context = {}) -> Promise.resolve(obj.get({plain: true}))

  list: (objs, context = {}) =>
    that = @
    Promise.map(objs, (obj) ->
      that.skim(obj, context)
    )

module.exports = BaseDehydrator