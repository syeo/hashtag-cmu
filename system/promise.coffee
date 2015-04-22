bluebird = require('bluebird')

config = require('../config/config')

module.exports = require('../config/initializers').bluebird(bluebird, config)