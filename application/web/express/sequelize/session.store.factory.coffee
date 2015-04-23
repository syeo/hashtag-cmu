_ = require('lodash')
session = require('express-session')
connectSequelize = require('connect-sequelize')

registry = require('../../../../system/registry')
config = require('../../../../config/config')

class SessionStoreFactory
  create: () ->
    sessioStoreClass = connectSequelize(session)

    new (sessioStoreClass)(
      registry.instance().sequelize,
      config.session.modelName
    )


module.exports = SessionStoreFactory