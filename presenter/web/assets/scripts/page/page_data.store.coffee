_ = require('lodash')

StoreBase = require('../shared/store.base')

ACTION = require('../constants').ACTION

debug = require('../debug')('page_data:store')

class PageDataStore extends StoreBase
  constructor: ->
    @params = {}
    @query = {}
    super()

  getParams: () ->
    @params

  setParams: (params) ->
    @params = params
    return params

  getQuery: () ->
    @query

  setQuery: (query) ->
    @query = query
    return query

  actionHandler: (action) =>
    debug(action)
    switch action.type
      when ACTION.CHANGE_PAGE
        @setParams(action.params)
        @setQuery(action.query)
        @emitChange()

module.exports = new PageDataStore