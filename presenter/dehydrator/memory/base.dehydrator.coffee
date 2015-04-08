BaseDehydrator = require('../base.dehydrator')
Promise = require('../../../config/promise')

class MemoryBaseDehydrator extends BaseDehydrator
  skim: (obj) -> Promise.resolve(obj.get({plain: true}))

module.exports = MemoryBaseDehydrator