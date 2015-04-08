BaseDehydrator = require('../base.dehydrator')
Promise = require('../../../config/promise')

class SequelizeBaseDehydrator extends BaseDehydrator
  skim: (obj) ->
    Promise.resolve(obj.get({plain: true}))

module.exports = SequelizeBaseDehydrator