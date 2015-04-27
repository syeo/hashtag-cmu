Dispatcher = require('../dispatcher')
ACTION = require('../constants').ACTION

debug = require('../debug')('user:action_creator')

module.exports =
  signUp: (user) ->
    Dispatcher.dispatch({
      type: ACTION.SIGN_UP_SUCCESS
      user: user
    })

  logIn: (user) ->
    Dispatcher.dispatch({
      type: ACTION.LOG_IN_SUCCESS
      user: user
    })

  loadMe: (user) ->
    Dispatcher.dispatch({
      type: ACTION.RECEIVE_ME
      user: user
    })