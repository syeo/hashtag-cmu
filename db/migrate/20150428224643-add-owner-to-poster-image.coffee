'use strict'
module.exports =
  up: (migration, DataTypes, done) ->
    migration.addColumn(
      'PosterImages'
      'ownerId'
      {
        type: DataTypes.INTEGER
      }
    )
    .done(done)

  down: (migration, DataTypes, done) ->
    migration.removeColumn(
      'PosterImages'
      'ownerId'
    )
    .done(done)
