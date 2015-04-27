'use strict'
module.exports =
  up: (migration, DataTypes, done) ->
    migration.addColumn(
      'Posters'
      'ownerId'
      DataTypes.INTEGER
    )
    .done(done)

  down: (migration, DataTypes, done) ->
    migration.removeColumn(
      'Posters'
      'ownerId'
    )
    .done(done)
