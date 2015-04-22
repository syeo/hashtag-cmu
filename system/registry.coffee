_ = require('lodash')

config = require('../config/config')
initializers = require('../config/initializers')

module.exports =
  instance: _.once(() -> initializers.registry({}, config))
