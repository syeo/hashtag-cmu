'use strict'
module.exports =
  up: (migration, DataTypes, done) ->
    migration.changeColumn('Posters', 'path', {
      type: DataTypes.STRING
      notNull: true
      notEmpty: true
    }).done(done)
  down: (migration, DataTypes, done) ->
    migration.changeColumn('Posters', 'path', {
      type: DataTypes.STRING
    }).done(done)
