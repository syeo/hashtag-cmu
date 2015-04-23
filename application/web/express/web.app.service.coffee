config = require('../../../config/config')

class WebAppService
  run: (app) ->
    app.listen(config.webServer.port)

module.exports = WebAppService