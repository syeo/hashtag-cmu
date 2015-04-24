_ = require('lodash')

StoreBase = require('../shared/store.base')

ACTION = require('../constants').ACTION

debug = require('../debug')('user:store')

class UserStore extends StoreBase
  constructor: ->
    @me = null
    @params = {}
    @query = {}
    super()

  getMe: () -> @me
  setMe: (user) -> @me = user

  actionHandler: (action) =>
    debug(action)
    switch action.type
      when ACTION.SIGN_UP_SUCCESS
        @setMe(action.user)
        @emitChange()
      when ACTION.LOG_IN_SUCCESS
        @setMe(action.user)
        @emitChange()

module.exports = new UserStore