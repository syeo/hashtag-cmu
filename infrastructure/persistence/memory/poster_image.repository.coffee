_ = require('lodash')

FixtureRepository = require('./fixture.repository')

class PosterImageRepository extends FixtureRepository
  constructor: (@registry) ->
    super(@registry, '../../../fixtures/poster_images.json')

  factory: (data) =>
    new @registry.domain.models.PosterImage(data)

  findAllByPoster: (poster) =>
    posterId = poster.get('id')
    @findAll().then((posterImages) ->
      _.filter(posterImages, (posterImage) ->
        posterImage.get('posterId') == posterId
      )
    )

module.exports = (registry) -> new PosterImageRepository(registry)
