_ = require('lodash')
passport = require('passport')

debug = require('../../../../../system/debug')('web:controller:api:v1:users')
Promise = require('../../../../../system/promise')
registry = require('../../../../../system/registry')

userRepository = registry.instance().userRepository
userDehydrator = registry.instance().userDehydrator
userService = registry.instance().userService

module.exports =
  list: (req, res) ->
    # TODO(stan): dev only? or admin only?
    debug('api.v1.user.list called')

    userRepository.findAll()
      .then(userDehydrator.list)
      .then((users) -> res.json({users: users}))
      .done()

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

  me: (req, res) ->
    if req.user?
      userDehydrator.whole(req.user)
        .then((user) -> res.json({user: user}))
        .done()
    else
      res.status(401).json({
        user: undefined,
        message: 'Log-in required.'
      })