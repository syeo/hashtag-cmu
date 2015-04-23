Dispatcher = require('../dispatcher')
ACTION = require('../constants').ACTION

debug = require('../debug')('page_data:action_creator')

module.exports =
  changePageData: (params, query) ->
    Dispatcher.dispatch({
      type: ACTION.CHANGE_PAGE
      params: params
      query: query
    })
