debug = require('debug')

config = require('../config/config')

module.exports = (arg) ->
  return debug("#{config.debugPrefix}:#{arg}")
