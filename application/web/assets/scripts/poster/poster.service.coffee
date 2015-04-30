_ = require('lodash')

ApiService = require('../api/api.service')
PosterActionCreator = require('./poster.action_creator')
Promise = require('../promise')

debug = require('../debug')('poster:service')

PosterService =
  loadHomePosterList: () ->
    ApiService.getHomePosterList().then((posterList) ->
      PosterActionCreator.receiveHomePosterList(posterList)
      return posterList
    )

  loadPoster: (id) ->
    ApiService.getPoster(id).then((poster) ->
      PosterActionCreator.receivePoster(poster)
      return poster
    )

  loadTagPosterList: (tagId) ->
    ApiService.getTagPosterList(tagId).then((posterList) ->
      PosterActionCreator.receiveTagPosterList(tagId, posterList)
      return posterList
    )

  deletePoster: (id) ->
    ApiService.deletePoster(id).then(() ->
      PosterActionCreator.deletePoster(id)
    )

  updatePoster: (poster) ->
    ApiService.updatePoster(poster).then((poster) ->
      PosterActionCreator.updatePoster(poster)
      return poster
    )

  createPoster: (poster) ->
    ApiService.createPoster(poster).then((poster) ->
      PosterActionCreator.receivePoster(poster)
      return poster
    )

module.exports = PosterService