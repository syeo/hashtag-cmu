_ = require('lodash')

BaseDehydrator = require('../shared/base.dehydrator')
Promise = require('../../system/promise')

class UserDehydrator extends BaseDehydrator
  skim: (obj) =>
    super(obj).then(
      (res) -> _.omit(res, ['password', 'salt'])
    )

module.exports = UserDehydrator