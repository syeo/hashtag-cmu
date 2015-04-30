authApiV1 = require('./auth.api_v1.controller')

module.exports = (app) ->
  app.route('/api/v1/auth/sign-up')
    .post(authApiV1.signUp)
  app.route('/api/v1/auth/log-in')
    .post(authApiV1.logIn)
