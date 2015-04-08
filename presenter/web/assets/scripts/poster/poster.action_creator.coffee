Dispatcher = require('../dispatcher')
ACTION = require('../constants').ACTION

debug = require('../debug')('poster:action_creator')

module.exports =
  receivePoster: (poster) ->
    Dispatcher.dispatch({
      type: ACTION.RECEIVE_POSTER
      poster: poster
    })

  receivePosterList: (posterList) ->
    Dispatcher.dispatch({
      type: ACTION.RECEIVE_POSTER_LIST
      posterList: posterList
    })
