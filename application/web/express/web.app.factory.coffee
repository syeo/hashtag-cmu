express = require('express')
session = require('express-session')
passport = require('passport')

registry = require('../../../system/registry')
initializers = require('../../../config/initializers')
config = require('../../../config/config')

class WebAppFactory
  create: () ->
    sessionStore = registry.instance().sessionStoreFactory.create()

    initializers.passport(passport, registry)
    initializers.express(
      express(),
      passport,
      sessionStore,
      config
    )

module.exports = WebAppFactory