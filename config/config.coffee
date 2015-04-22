_ = require('lodash')
glob = require('glob')

if not process.env.NODE_ENV
  console.log("NODE_ENV is not set. using 'development'...")
  process.env.NODE_ENV = 'development'

NODE_ENV = process.env.NODE_ENV

envFiles = glob.sync("./config/env/#{NODE_ENV}.@(coffee|js)")

if not envFiles.length
  throw new Error("No config file for '#{NODE_ENV}'.")
else
  console.log("Config loaded using '#{NODE_ENV}'.")

module.exports = _.extend(
  { NODE_ENV: NODE_ENV },
  require('./env/all'),
  require("./env/#{NODE_ENV}") || {}
)
