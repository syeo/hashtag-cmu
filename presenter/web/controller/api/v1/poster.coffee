_ = require('lodash')

debug = require('../../../../../etc/debug')('web:controller:api:v1:posters')
registry = require('../../../../../config/registry')()

PAGE_SIZE = 30

posterRepository = registry.infrastructure.persistence.posterRepository
posterDehydrator = registry.presenter.dehydrator.posterDehydrator

module.exports =
  list: (req, res) ->
    debug('api.v1.poster.list called')
    posterRepository.getRecentPosts(PAGE_SIZE)
      .then(_.bind(posterDehydrator.list, posterDehydrator))
      .then((posters) ->
        res.json(
          posters: posters
        )
      )
