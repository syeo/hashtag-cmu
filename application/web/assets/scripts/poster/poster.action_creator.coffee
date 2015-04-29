Dispatcher = require('../dispatcher')
ACTION = require('../constants').ACTION

debug = require('../debug')('poster:action_creator')

module.exports =
  receivePoster: (poster) ->
    Dispatcher.dispatch({
      type: ACTION.RECEIVE_POSTER
      poster: poster
    })

  receiveHomePosterList: (posters) ->
    Dispatcher.dispatch({
      type: ACTION.RECEIVE_HOME_POSTER_LIST
      posters: posters
    })

  receiveTagPosterList: (tagId, posters) ->
    Dispatcher.dispatch({
      type: ACTION.RECEIVE_TAG_POSTER_LIST
      tagId: tagId
      posters: posters
    })

  deletePoster: (poster) ->
    Dispatcher.dispatch({
      type: ACTION.DELETE_POSTER
      poster: poster
    })

  updatePoster: (poster) ->
    Dispatcher.dispatch({
      type: ACTION.UPDATE_POSTER
      poster: poster
    })
