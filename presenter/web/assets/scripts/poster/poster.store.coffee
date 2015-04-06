_ = require('lodash')

StoreBase = require('../shared/store.base')

ACTION = require('../constants').ACTION

debug = require('../debug')('poster:store')

class PosterStore extends StoreBase
  constructor: ->
    @posters = {}
    @posterList = null
    super()

  getPoster: (id) =>
    return @posters[id]

  setPoster: (poster) =>
    @posters[poster.id] = poster
    return poster

  setPosterList: (posterList) =>
    @posterList = _.map(posterList, @setPoster)
    return @posterList

  getPosterList: () =>
    return @posterList

  actionHandler: (action) =>
    debug(action)
    switch action.type
      when ACTION.RECEIVE_POSTER_LIST
        @setPosterList(action.posterList)
        @emitChange()
      when ACTION.RECEIVE_POSTER
        @setPoster(action.poster)
        @emitChange()

module.exports = new PosterStore