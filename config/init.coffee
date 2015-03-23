glob = require('glob')
_ = require('lodash')
chalk = require('chalk')

module.exports = _.once(() ->
  if not process.env.NODE_ENV
    console.log("NODE_ENV is not set. using 'development'...")
    process.env.NODE_ENV = 'development'

  envFiles = glob.sync("./config/env/#{process.env.NODE_ENV}.@(coffee|js)")

  if not envFiles.length
    throw new Error("No config file for '#{process.env.NODE_ENV}'.")
  else
    console.log("Application loaded using '#{process.env.NODE_ENV}'.")
)