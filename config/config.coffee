require('./init')()

_ = require('lodash')
glob = require('glob')

module.exports = _.extend(
  {},
  require('./env/all'),
  require("./env/#{process.env.NODE_ENV}") || {}
)
