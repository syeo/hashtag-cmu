usersApiV1 = require('./users.api_v1.controller')

module.exports = (app) ->
  app.route('/api/v1/users')
    .get(usersApiV1.list)
    .post(usersApiV1.signUp)
  app.route('/api/v1/users/log-in')
    .post(usersApiV1.logIn)
  app.route('/api/v1/users/me')
    .get(usersApiV1.me)
