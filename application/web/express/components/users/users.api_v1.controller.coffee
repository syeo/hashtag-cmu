_ = require('lodash')
passport = require('passport')

Promise = require('../../../../../system/promise')
registry = require('../../../../../system/registry')

debug = require('../../../../../system/debug')('web:controller:api:v1:users')

# userRepository = registry.instance().userRepository
userDehydrator = registry.instance().userDehydrator
userService = registry.instance().userService

module.exports =
  # list: (req, res) ->
  #   # TODO(stan): dev only? or admin only?
  #   debug('api.v1.user.list called')

  #   userRepository.findAll()
  #     .then(userDehydrator.list)
  #     .then((users) -> res.json({users: users}))
  #     .done()

  me: (req, res) ->
    userDehydrator.whole(req.user)
      .then((user) -> res.json({user: user}))
      .done()
