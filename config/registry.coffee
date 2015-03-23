require('../config/init')()

_ = require('lodash')

registry =
  application: {}
  infrastructure: {}
  domain: {}

makeTest = makeDevelopment = makeStaging = makeProduction = _.noop

module.exports = _.once(() ->
  switch process.env.NODE_ENV
    when 'test'
      makeTest()
    when 'development'
      makeDevelopment()
    when 'staging'
      makeStaging()
    when 'production'
      makeProduction()
    else
      throw new Error("Cannot make registry for '#{process.env.NODE_ENV}'.")

  return registry
)