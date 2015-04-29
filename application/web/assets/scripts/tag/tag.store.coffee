_ = require('lodash')

StoreBase = require('../shared/store.base')

ACTION = require('../constants').ACTION

debug = require('../debug')('user:store')

class TagStore extends StoreBase
  constructor: ->
    @tags = {}
    super()

  getByName: (name) => _.find(@tags, {name: name})
  getById: (id) => @tags[id]

  setTags: (tags) =>
    _.each(tags, ((tag) -> @tags[tag.id] = tag), @)

  actionHandler: (action) =>
    debug(action)
    switch action.type
      when ACTION.RECEIVE_TAG_LIST
        @setTags(action.tags)
        @emitChange()

module.exports = new TagStore