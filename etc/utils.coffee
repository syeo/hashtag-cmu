_ = require('lodash')
glob = require('glob')

module.exports =
  getGlobbedFiles: (globPatterns, removeRoot) ->
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
      if urlRegex.test(globPatterns)
        output.push(globPatterns)
      else
        files = glob.sync(globPatterns)
        if removeRoot
          files = files.map((file) ->
            return file.replace(removeRoot, '')
          )
        output = _.union(output, files)

    return output
