glob = require('glob')
debug = require('debug')('ean:config:init')
chalk = require('chalk')

module.exports = () ->
  if not process.env.NODE_ENV
    debug("NODE_ENV is not set. using 'development'...")
    process.env.NODE_ENV = 'development'

  glob(
    "./config/env/#{process.env.NODE_ENV}.@(coffee|js)",
    {},
    (err, envFiles) ->
      if not envFiles.length
        console.error(chalk.red(
          "No config file for '#{process.env.NODE_ENV}'."
        ))
      else
        debug("Application loaded using '#{process.env.NODE_ENV}'.")
  )
