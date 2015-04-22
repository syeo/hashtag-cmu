fs = require('fs')

config = require('../config/config')

web = require('../presenter/web')

web.listen(config.port)

console.log("#{config.app.title} started on port #{config.port}")
if config.NODE_ENV == 'development'
  fs.writeFileSync '.rebooted', 'rebooted'
