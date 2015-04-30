passport = require('passport')

Promise = require('../../../../../system/promise')
registry = require('../../../../../system/registry')

debug = require('../../../../../system/debug')('web:auth:api_v1')

userDehydrator = registry.instance().userDehydrator
userService = registry.instance().userService

module.exports =
  signUp: (req, res) ->
    debug(req.body)
    userService.signUp({
      email: req.body.email
      password: req.body.password
      firstName: req.body.firstName
      lastName: req.body.lastName
    })
      .then((user) ->
        Promise.all([
          userDehydrator.whole(user)
          Promise.promisify(req.logIn, req)(user)
        ])
      )
      .spread((user) -> res.json({user: user}))
      .done()

  logIn: (req, res, next) ->
    passport.authenticate('local', (err, user, info) ->
      if err?
        throw err

      if info?
        res.status(400).json(info)
      else
        Promise.all([
          userDehydrator.whole(user)
          Promise.promisify(req.logIn, req)(user)
        ])
          .spread((user) -> res.json({user: user}))
          .done()
    )(req, res, next)
