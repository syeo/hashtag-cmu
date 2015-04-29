_ = require('lodash')
path = require('path')

makeCommon = (registry) ->
  registry = _.extend(registry, require('../../domain/models/sequelize'))

  registry.syncDb = (options = {}) ->
    registry.sequelize.sync(options)

  registry.webAppFactory = new (require(
    '../../application/web/express/web.app.factory'
  ))()

  registry.sessionStoreFactory = new (require(
    '../../application/web/express/sequelize/session.store.factory'
  ))()

  registry.userRepository = new (require(
    '../../infrastructure/persistence/sequelize/user.repository'
  ))()
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

  registry.userDehydrator = new (require(
    '../../domain/user/user.dehydrator'
  ))()
  registry.posterDehydrator = new (require(
    '../../domain/poster/poster.dehydrator'
  ))()
  registry.posterImageDehydrator = new (require(
    '../../domain/poster_image/poster_image.dehydrator'
  ))()
  registry.tagDehydrator = new (require(
    '../../domain/tag/tag.dehydrator'
  ))()

  registry.userService = new (require(
    '../../domain/user/user.service'
  ))()
  registry.posterImageService = new (require(
    '../../domain/poster_image/local.poster_image.service'
  ))(path.resolve('./upload/poster-images'), '/static/poster-images')

makeTest = makeDevelopment = makeStaging = (registry) ->
  makeCommon(registry)
  registry.webAppService = new (require(
    '../../application/web/express/development.web.app.service'
  ))()

makeProduction = (registry) ->
  makeCommon(registry)
  registry.webAppService = new (require(
    '../../application/web/express/web.app.service'
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
