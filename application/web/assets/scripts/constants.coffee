keyMirror = require('keymirror')

module.exports =
  ACTION: keyMirror({
    RECEIVE_POSTER: null
    RECEIVE_HOME_POSTER_LIST: null
    RECEIVE_TAG_POSTER_LIST: null
    CHANGE_PAGE: null
  })
  API:
    ROOT: '/api/v1'
