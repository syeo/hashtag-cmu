'use strict'
module.exports =
  up: (migration, DataTypes, done) ->
    migration.removeColumn('PosterImages', 'thumbnailUrl')
      .then(() ->
        migration.removeColumn('PosterImages', 'cardUrl')
      )
      .then(() ->
        migration.renameColumn('PosterImages', 'originalUrl', 'url')
      )
      .done(done)

  down: (migration, DataTypes, done) ->
    migration.addColumn('PosterImages', 'thumbnailUrl', DataTypes.STRING)
      .then(() ->
        migration.addColumn('PosterImages', 'cardUrl', DataTypes.STRING)
      )
      .then(() ->
        migration.renameColumn('PosterImages', 'url', 'originalUrl')
      )
      .done(done)
