'use strict'
module.exports =
  up: (migration, DataTypes, done) ->
    migration.addColumn(
      'PosterImages'
      'PosterId'
      DataTypes.INTEGER
    ).done(done)

  down: (migration, DataTypes, done) ->
    migration.removeColumn(
      'PosterImages'
      'PosterId'
    ).done(done)
