_ = require('lodash')

ApiService = require('../api/api.service')
Promise = require('../promise')

debug = require('../debug')('auth:service')

module.exports =
  userCanEditPoster: (user, poster) ->
    user.id == poster.owner.id

  userCanDeletePoster: (user, poster) ->
    user.id == poster.owner.id
