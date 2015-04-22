debug = require('debug')

debug.enable('*')

module.exports = (arg) -> debug("#cmu:#{arg}")
