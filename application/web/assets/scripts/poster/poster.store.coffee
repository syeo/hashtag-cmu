_ = require('lodash')

StoreBase = require('../shared/store.base')

ACTION = require('../constants').ACTION

debug = require('../debug')('poster:store')

class PosterStore extends StoreBase
  constructor: ->
    @posters = {}
    @homePosterList = []
    @tagPosterLists = {}
    super()

  getPoster: (id) =>
    return @posters[id]

  setPoster: (poster) =>
    @posters[poster.id] = poster
    return poster

  setHomePosterList: (posters) =>
    @homePosterList = _.map(posters, @setPoster)
    return @homePosterList

  getHomePosterList: () =>
    return @homePosterList

  setTagPosterList: (tagId, posters) =>
    @tagPosterLists[tagId] = _.map(posters, @setPoster)
    return @tagPosterLists[tagId]

  getTagPosterList: (tagId) =>
    return @tagPosterLists[tagId] || []

  actionHandler: (action) =>
    debug(action)
    switch action.type
      when ACTION.RECEIVE_HOME_POSTER_LIST
        @setHomePosterList(action.posters)
        @emitChange()
      when ACTION.RECEIVE_POSTER
        @setPoster(action.poster)
        @emitChange()
      when ACTION.RECEIVE_TAG_POSTER_LIST
        @setTagPosterList(action.tagId, action.posters)
        @emitChange()

module.exports = new PosterStore