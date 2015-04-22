mockup = require('./mockup.controller')

module.exports = (app) ->
  # Root routing
  app.route('/mockup').get(mockup.index)
