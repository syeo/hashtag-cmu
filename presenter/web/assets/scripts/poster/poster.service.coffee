_ = require('lodash')

ApiService = require('../api/api.service')
PosterActionCreator = require('./poster.action_creator')
Promise = require('../promise')

debug = require('../debug')('watchboard:query:result:service')

module.exports =
  loadPosterList: () ->
    ApiService.getPosterList().then((posterList) ->
      PosterActionCreator.receivePosterList(posterList)
    )

  loadPoster: (id) ->
    ApiService.getPoster(id).then((poster) ->
      PosterActionCreator.receivePoster(poster)
    )
