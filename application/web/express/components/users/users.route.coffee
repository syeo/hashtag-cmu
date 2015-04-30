usersApiV1 = require('./users.api_v1.controller')

authMiddlewares = require('../auth/auth.middlewares')

module.exports = (app) ->
  app.route('/api/v1/users/me')
    .all(authMiddlewares.loginRequired)
    .get(usersApiV1.me)
