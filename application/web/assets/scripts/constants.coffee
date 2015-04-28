keyMirror = require('keymirror')

module.exports =
  ACTION: keyMirror({
    RECEIVE_POSTER: null
    RECEIVE_HOME_POSTER_LIST: null
    RECEIVE_TAG_POSTER_LIST: null
    CHANGE_PAGE: null
    SIGN_UP_SUCCESS: null
    LOG_IN_SUCCESS: null
    RECEIVE_ME: null
    RECEIVE_TAG_LIST: null
    DELETE_POSTER: null
    UPDATE_POSTER: null
  })
  API:
    ROOT: '/api/v1'
