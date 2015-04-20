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

# makeTest = makeStaging = makeProduction = () ->
#   db = require('../domain/models/sequelize')

#   sequelize = db.sequelize
#   Poster = db.Poster
#   PosterImage = db.PosterImage

#   registry.domain.models.Poster = Poster
#   registry.domain.models.PosterImage = PosterImage
#   registry.domain.models.Tag = Tag

#   registry.infrastructure.persistence.sequelize = sequelize
#   registry.infrastructure.persistence.posterRepository = require(
#     '../infrastructure/persistence/sequelize/poster.repository'
#   )(registry)
#   registry.infrastructure.persistence.posterImageRepository = require(
#     '../infrastructure/persistence/sequelize/poster_image.repository'
#   )(registry)

#   registry.infrastructure.persistence.tagRepository = require(
#     '../infrastructure/persistence/sequelize/tag.repository.repository'
#   )(registry)

#   registry.presenter.dehydrator.posterDehydrator = require(
#     '../presenter/dehydrator/sequelize/poster.dehydrator'
#   )(registry)
#   registry.presenter.dehydrator.posterImageDehydrator = require(
#     '../presenter/dehydrator/sequelize/poster_image.dehydrator'
#   )(registry)
#   registry.presenter.dehydrator.tagDehydrator = require(
#     '../presenter/dehydrator/sequelize/tag.dehydrator'
#   )(registry)

makeTest = makeDevelopment = makeStaging = makeProduction = () ->
  db = require('../domain/models/memory')

  sequelize = db.sequelize
  sequelizeDb = require('../domain/models/sequelize')

  ########## Sequelize
  registry.domain.models.Poster = sequelizeDb.Poster
  registry.domain.models.PosterImage = sequelizeDb.PosterImage
  registry.domain.models.Tag = sequelizeDb.Tag
  registry.domain.models.PosterTag = sequelizeDb.PosterTag

  registry.infrastructure.persistence.sequelize = sequelize

  registry.infrastructure.persistence.posterRepository = require(
    '../infrastructure/persistence/sequelize/poster.repository'
  )(registry)
  registry.infrastructure.persistence.posterImageRepository = require(
    '../infrastructure/persistence/sequelize/poster_image.repository'
  )(registry)
  registry.infrastructure.persistence.tagRepository = require(
    '../infrastructure/persistence/sequelize/tag.repository'
  )(registry)
  registry.infrastructure.persistence.posterTagRepository = require(
    '../infrastructure/persistence/sequelize/poster_tag.repository'
  )(registry)



  ########## Memory
  # registry.domain.models.Poster = db.Poster
  # registry.domain.models.PosterImage = db.PosterImage

  # registry.infrastructure.persistence.posterRepository = require(
  #   '../infrastructure/persistence/memory/poster.repository'
  # )(registry)
  # registry.infrastructure.persistence.posterImageRepository = require(
  #   '../infrastructure/persistence/memory/poster_image.repository'
  # )(registry)


  # registry.domain.models.Tag = db.Tag
  # registry.domain.models.PosterTag = db.PosterTag

  # registry.infrastructure.persistence.tagRepository = require(
  #   '../infrastructure/persistence/memory/tag.repository'
  # )(registry)
  # registry.infrastructure.persistence.posterTagRepository = require(
  #   '../infrastructure/persistence/memory/poster_tag.repository'
  # )(registry)

  registry.presenter.dehydrator.posterDehydrator = require(
    '../presenter/dehydrator/memory/poster.dehydrator'
  )(registry)
  registry.presenter.dehydrator.posterImageDehydrator = require(
    '../presenter/dehydrator/memory/poster_image.dehydrator'
  )(registry)
  registry.presenter.dehydrator.tagDehydrator = require(
    '../presenter/dehydrator/memory/tag.dehydrator'
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