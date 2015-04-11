_ = require('lodash')

debug = require('../../../etc/debug')('web:controller:api:v1:tag_posters')
registry = require('../../../config/registry')()
Promise = ('../../../config/promise')

posterRepository = registry.infrastructure.persistence.posterRepository
posterDehydrator = registry.presenter.dehydrator.posterDehydrator

module.exports =
  list: (req, res) ->
    debug('api.v1.tag.list called')

    posterRepository.findRecentByTagId(req.params.tagId)
      .then(posterDehydrator.list)
      .then((posters) -> res.json({posters: posters}))
      .done()
