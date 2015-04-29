'use strict'
module.exports =
  up: (migration, DataTypes, done) ->
    migration.addColumn(
      'PosterImages'
      'secureUrl'
      {
        type: DataTypes.STRING
      }
    )
    .done(done)

  down: (migration, DataTypes, done) ->
    migration.removeColumn(
      'PosterImages'
      'secureUrl'
    )
    .done(done)
