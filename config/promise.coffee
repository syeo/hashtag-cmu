require('./init')()

_ = require('lodash')
Promise = require('bluebird')

makeTest = makeDevelopment = makeStaging = ->
  Promise.longStackTraces()

makeProduction = _.noop

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
    throw new Error("Cannot initialize Promise for " +
      "'#{process.env.NODE_ENV}'.")

module.exports = Promise