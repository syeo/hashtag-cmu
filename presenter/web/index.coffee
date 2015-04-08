chalk = require('chalk')
fs = require('fs')

config = require('../../config/config')
app = require('../../config/express')()

if not module.parent
  app.listen(config.port)
  console.log("#{config.app.title} started on port #{config.port}")
  if process.env.NODE_ENV == 'development'
    fs.writeFileSync '.rebooted', 'rebooted'

exports = module.exports = app
