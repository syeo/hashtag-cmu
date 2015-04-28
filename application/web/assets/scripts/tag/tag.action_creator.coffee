Dispatcher = require('../dispatcher')
ACTION = require('../constants').ACTION

debug = require('../debug')('poster:action_creator')

module.exports =
  receiveTagList: (tags) ->
    Dispatcher.dispatch({
      type: ACTION.RECEIVE_TAG_LIST
      tags: tags
    })
