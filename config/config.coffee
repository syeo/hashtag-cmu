require('./init')()

_ = require('lodash')
glob = require('glob')

debug = require('../etc/debug')('config:config')

module.exports = _.extend(
  {},
  require('./env/all'),
  require("./env/#{process.env.NODE_ENV}") || {}
)

module.exports.getGlobbedFiles = (globPatterns, removeRoot) ->
  debug("trying get blobbedfiles of pattern: #{globPatterns}")

  # For context switching
  that = this

  # URL paths regex
  urlRegex = new RegExp('^(?:[a-z]+:)?\/\/', 'i')

  # The output array
  output = []

  # If glob pattern is array so we use each pattern in a recursive way,
  # otherwise we use glob
  if _.isArray(globPatterns)
    globPatterns.forEach((globPattern) ->
      output = _.union(output, that.getGlobbedFiles(globPattern, removeRoot))
    )
  else if _.isString(globPatterns)
    debug("string matching")
    if urlRegex.test(globPatterns)
      output.push(globPatterns)
    else
      debug("looking for files")
      files = glob.sync(globPatterns)
      if removeRoot
        files = files.map((file) ->
          return file.replace(removeRoot, '')
        )
      output = _.union(output, files)

  return output
