require('./init')()

_ = require('lodash')

registry =
  domain:
    models: {}
  infrastructure:
    persistence: {}
    cache: {}
  presenter:
    dehydrator: {}
  application: {}

makeTest = makeStaging = makeProduction = () ->
  db = require('../domain/models/sequelize')

  sequelize = db.sequelize
  Poster = db.Poster
  PosterImage = db.PosterImage

  registry.domain.models.Poster = Poster
  registry.domain.models.PosterImage = PosterImage

  registry.infrastructure.persistence.sequelize = sequelize
  registry.infrastructure.persistence.posterRepository = require(
    '../infrastructure/persistence/sequelize/poster.repository'
  )(registry)
  registry.infrastructure.persistence.posterImageRepository = require(
    '../infrastructure/persistence/sequelize/poster_image.repository'
  )(registry)

  registry.presenter.dehydrator.posterDehydrator = require(
    '../presenter/dehydrator/sequelize/poster.dehydrator'
  )(registry)
  registry.presenter.dehydrator.posterImageDehydrator = require(
    '../presenter/dehydrator/sequelize/poster_image.dehydrator'
  )(registry)

makeDevelopment = () ->
  db = require('../domain/models/memory')

  Poster = db.Poster
  PosterImage = db.PosterImage

  registry.domain.models.Poster = Poster
  registry.domain.models.PosterImage = PosterImage

  registry.infrastructure.persistence.posterRepository = require(
    '../infrastructure/persistence/memory/poster.repository'
  )(registry)
  registry.infrastructure.persistence.posterImageRepository = require(
    '../infrastructure/persistence/memory/poster_image.repository'
  )(registry)

  registry.presenter.dehydrator.posterDehydrator = require(
    '../presenter/dehydrator/memory/poster.dehydrator'
  )(registry)
  registry.presenter.dehydrator.posterImageDehydrator = require(
    '../presenter/dehydrator/memory/poster_image.dehydrator'
  )(registry)

module.exports = _.once(() ->
  switch process.env.NODE_ENV
    when 'test'
      makeTest()
    when 'development'
      makeDevelopment()
    when 'staging'
      makeStaging()
    when 'production'
      makeProduction()
    else
      throw new Error("Cannot make registry for '#{process.env.NODE_ENV}'.")

  return registry
)