_ = require('lodash')

BaseDehydrator = require('../shared/base.dehydrator')
Promise = require('../../system/promise')

class UserDehydrator extends BaseDehydrator
  skim: (obj, context = {}) =>
    super(obj, context).then(
      (res) -> _.omit(res, ['password', 'salt'])
    )

module.exports = UserDehydrator