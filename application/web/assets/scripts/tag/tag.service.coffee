_ = require('lodash')

ApiService = require('../api/api.service')
TagActionCreator = require('./tag.action_creator')
Promise = require('../promise')

debug = require('../debug')('tag:service')

module.exports =
  loadTagList: () ->
    ApiService.getTagList().then((tagList) ->
      TagActionCreator.receiveTagList(tagList)
    )
