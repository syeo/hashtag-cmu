Promise = require('../../system/promise')

class BaseDehydrator
  whole: (obj) => @skim(obj)
  skim: (obj) -> Promise.resolve(obj.get({plain: true}))

  list: (objs) =>
    Promise.map(objs, @skim)

module.exports = BaseDehydrator