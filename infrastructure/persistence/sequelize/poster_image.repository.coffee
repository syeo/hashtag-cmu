BaseRepository = require('./base.repository')
BasePosterImageRepository = require('../shared/base.poster_image.repository')
Query = require('./query.builder')
Where = require('./where')
mixOf = require('../../../etc/mix_of')

debug = require('../../../etc/debug')('infra:persistence:PosterImageRepository')

class PosterImageRepository extends mixOf(BaseRepository,
                                          BasePosterImageRepository)
  getModel: () => @registry.domain.models.PosterImage

  findAllByPosterId: (posterId) =>
    posterId = Number(posterId)
    return @findAll(Query.where(Where({ posterId: posterId })))

module.exports = (registry) ->
  return new PosterImageRepository(registry)
