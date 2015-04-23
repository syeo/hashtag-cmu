express = require('express')
session = require('express-session')
passport = require('passport')

registry = require('../../../system/registry')
initializers = require('../../../config/initializers')
config = require('../../../config/config')

class WebAppFactory
  create: () ->
    sessionStore = registry.instance().sessionStoreFactory.create()

    webApp = initializers.express(
      express(),
      passport,
      sessionStore,
      config
    )
    initializers.passport(passport, registry)

    return webApp

module.exports = WebAppFactory