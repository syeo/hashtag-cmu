BaseRepository = require('./base_repository')

debug = require('../../../etc/debug')('infra:persistence:PosterRepository')

class PosterRepository extends BaseRepository
  getModel: () => @registry.domain.models.Poster

  getRecentPosts: (limit) ->
    @findAll({
      order: 'createdAt DESC'
      limit: limit
    })


module.exports = (registry) ->
  return new PosterRepository(registry)
