_ = require('lodash')

debug = require('../../../etc/debug')('web:controller:api:v1:tags')
registry = require('../../../config/registry')()
Promise = ('../../../config/promise')

posterRepository = registry.infrastructure.persistence.posterRepository

tagRepository = registry.infrastructure.persistence.tagRepository
tagDehydrator = registry.presenter.dehydrator.tagDehydrator

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
