_ = require('lodash')

debug = require('../../../../../system/debug')('web:controller:api:v1:tag_posters')
registry = require('../../../../../system/registry')

posterRepository = registry.instance().posterRepository
posterDehydrator = registry.instance().posterDehydrator

module.exports =
  list: (req, res) ->
    debug('api.v1.tag.list called')

    posterRepository.findRecentByTag(req.tag)
      .then(posterDehydrator.list)
      .then((posters) -> res.json({posters: posters}))
      .done()
