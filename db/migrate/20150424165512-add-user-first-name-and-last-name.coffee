'use strict'
module.exports =
  up: (migration, DataTypes, done) ->
    migration.addColumn(
      'Users'
      'firstName'
      DataTypes.STRING
    )
    .then(() ->
      migration.addColumn(
        'Users'
        'lastName'
        DataTypes.STRING
      )
    )
    .done(done)

  down: (migration, DataTypes, done) ->
    migration.removeColumn(
      'Users'
      'firstName'
    )
    .then(() ->
      migration.removeColumn(
        'Users'
        'lastName'
      )
    )
    .done(done)
