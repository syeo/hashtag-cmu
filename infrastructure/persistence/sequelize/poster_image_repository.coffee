BaseRepository = require('./base_repository')

debug = require('../../../etc/debug')('infra:persistence:PosterImageRepository')

class PosterImageRepository extends BaseRepository
  getModel: () => @registry.domain.models.PosterImage

  bulkCreate: (dataArr) =>
    super(dataArr)

module.exports = (registry) ->
  return new PosterImageRepository(registry)
