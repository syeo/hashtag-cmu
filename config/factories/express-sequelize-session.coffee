connectSequelize = require('connect-sequelize')

module.exports = (registry, config) ->
  new (connectSequelize(session))(registry.instance().sequelize, config.session.modelName)

  session(
    secret: config.session.secret
    store: new SequelizeSessionStore(sequelize, config.session.modelName)
    proxy: config.session.config
  )