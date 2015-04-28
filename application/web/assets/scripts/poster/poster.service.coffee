_ = require('lodash')

ApiService = require('../api/api.service')
PosterActionCreator = require('./poster.action_creator')
Promise = require('../promise')

debug = require('../debug')('poster:service')

module.exports =
  loadHomePosterList: () ->
    ApiService.getHomePosterList().then((posterList) ->
      PosterActionCreator.receiveHomePosterList(posterList)
    )

  loadPoster: (id) ->
    ApiService.getPoster(id).then((poster) ->
      PosterActionCreator.receivePoster(poster)
    )

  loadTagPosterList: (tagId) ->
    ApiService.getTagPosterList(tagId).then((posterList) ->
      PosterActionCreator.receiveTagPosterList(tagId, posterList)
    )

  # deletePoster: (id) ->
  #   ApiService.deletePoster(id).then(() ->
  #     PosterActionCreator.
  #   )