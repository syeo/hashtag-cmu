BaseDehydrator = require('../base_dehydrator')

class BaseSequelizeDehydrator extends BaseDehydrator
  whole: (obj) -> obj.get({plain: true})

module.exports = BaseSequelizeDehydrator