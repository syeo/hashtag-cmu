_ = require('lodash')

makeTest = makeDevelopment = makeStaging = makeProduction = (registry) ->
  registry = _.extend(registry, require('../../domain/models/sequelize'))

  registry.posterRepository = new (require(
    '../../infrastructure/persistence/sequelize/poster.repository'
  ))()
  registry.posterImageRepository = new (require(
    '../../infrastructure/persistence/sequelize/poster_image.repository'
  ))()
  registry.tagRepository = new (require(
    '../../infrastructure/persistence/sequelize/tag.repository'
  ))()
  registry.posterTagRepository = new (require(
    '../../infrastructure/persistence/sequelize/poster_tag.repository'
  ))()

  registry.posterDehydrator = new (require(
    '../../presenter/dehydrator/shared/poster.dehydrator'
  ))()
  registry.posterImageDehydrator = new (require(
    '../../presenter/dehydrator/shared/poster_image.dehydrator'
  ))()
  registry.tagDehydrator = new (require(
    '../../presenter/dehydrator/shared/tag.dehydrator'
  ))()

module.exports = (registry, config) ->
  switch config.NODE_ENV
    when 'test'
      makeTest(registry)
    when 'development'
      makeDevelopment(registry)
    when 'staging'
      makeStaging(registry)
    when 'production'
      makeProduction(registry)
    else
      throw new Error("Cannot make registry for '#{process.env.NODE_ENV}'.")

  return registry
