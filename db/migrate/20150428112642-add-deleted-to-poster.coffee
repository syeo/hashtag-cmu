'use strict'
module.exports =
  up: (migration, DataTypes, done) ->
    migration.addColumn(
      'Posters'
      'deleted'
      {
        type: DataTypes.BOOLEAN
        defaultValue: false
      }
    )
    .done(done)

  down: (migration, DataTypes, done) ->
    migration.removeColumn(
      'Posters'
      'deleted'
    )
    .done(done)
