_ = require('lodash')

ApiService = require('../api/api.service')
UserActionCreator = require('./user.action_creator')
Promise = require('../promise')

debug = require('../debug')('user:service')

module.exports =
  signUp: (signUpData) ->
    ApiService.signUp(signUpData).then((user) ->
      UserActionCreator.signUp(user)
    )

  logIn: (logInData) ->
    ApiService.logIn(logInData).then((user) ->
      UserActionCreator.logIn(user)
    )

  loadMe: () ->
    ApiService.getMe().then((user) ->
      UserActionCreator.loadMe(user)
    )
