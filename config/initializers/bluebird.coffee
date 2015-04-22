module.exports = (bluebird, config) ->
  unless config.NODE_ENV == 'production'
    bluebird.longStackTraces()

  return bluebird