fs = require('fs')

config = require('../../../config/config')
WebAppService = require('./web.app.service')

debug = require('../../../system/debug')

class DevelopmentWebAppService extends WebAppService
  run: (webServer) =>
    super(webServer)
    debug("#{config.app.title} started on port #{config.webServer.port}")
    fs.writeFileSync '.rebooted', 'rebooted'

module.exports = DevelopmentWebAppService