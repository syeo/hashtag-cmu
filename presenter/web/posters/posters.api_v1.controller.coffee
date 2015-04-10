_ = require('lodash')

debug = require('../../../etc/debug')('web:controller:api:v1:posters')
registry = require('../../../config/registry')()

PAGE_SIZE = 30

posterRepository = registry.infrastructure.persistence.posterRepository
posterDehydrator = registry.presenter.dehydrator.posterDehydrator

module.exports =
  list: (req, res) ->
    debug('api.v1.poster.list called')
    debug(req.query)

    options =
      pageSize: PAGE_SIZE

    if req.query.filter?
      options.filter = _.pick(req.query.filter, ['tag'])

    posterRepository.getRecentPostsWithOptions(options)
      .then(posterDehydrator.list)
      .then((posters) ->
        res.json(
          posters: posters
        )
      ).done()
