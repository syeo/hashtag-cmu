_ = require('lodash')

debug = require('../../../../../system/debug')('web:controller:api:v1:posters')
registry = require('../../../../../system/registry')

PAGE_SIZE = 30

posterRepository = registry.instance().posterRepository
posterDehydrator = registry.instance().posterDehydrator

module.exports =
  list: (req, res) ->
    debug('api.v1.poster.list called')
    debug(req.query)

    options =
      pageSize: PAGE_SIZE

    if req.query.filter?
      options.filter = _.pick(req.query.filter, ['tag'])

    posterRepository
      .findRecent(options)
      .then(posterDehydrator.list)
      .then((posters) -> res.json({posters: posters}))
      .done()

  get: (req, res) ->
    debug('api.v1.poster.get called')
    debug(req.query)

    posterRepository
      .findById(req.params.posterId)
      .then(posterDehydrator.whole)
      .then((poster) -> res.json({poster: poster}))
      .done()
