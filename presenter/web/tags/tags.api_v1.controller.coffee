_ = require('lodash')

debug = require('../../../system/debug')('web:controller:api:v1:tags')
registry = require('../../../system/registry')
Promise = ('../../../system/promise')

posterRepository = registry.instance().posterRepository

tagRepository = registry.instance().tagRepository
tagDehydrator = registry.instance().tagDehydrator

module.exports =
  list: (req, res) ->
    debug('api.v1.tag.list called')

    tagRepository
      .findAll()
      .then(tagDehydrator.list)
      .then((tags) -> res.json({tags: tags}))
      .done()

  get: (req, res) ->
    debug('api.v1.tag.get called')

    tagRepository.findById(req.params.tagId)
      .then(tagDehydrator.whole)
      .then((tag) -> res.json({tag: tag}))
      .done()
