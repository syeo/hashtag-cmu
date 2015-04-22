_ = require('lodash')

debug = require('../../../system/debug')('web:controller:api:v1:tag_posters')
registry = require('../../../system/registry')
Promise = ('../../../system/promise')

posterRepository = registry.instance().posterRepository
posterDehydrator = registry.instance().posterDehydrator

module.exports =
  list: (req, res) ->
    debug('api.v1.tag.list called')

    posterRepository.findRecentByTagId(req.params.tagId)
      .then(posterDehydrator.list)
      .then((posters) -> res.json({posters: posters}))
      .done()
