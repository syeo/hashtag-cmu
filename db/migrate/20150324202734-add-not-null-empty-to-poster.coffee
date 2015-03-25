'use strict'
module.exports =
  up: (migration, DataTypes, done) ->
    migration.changeColumn('Posters', 'title', {
      type: DataTypes.STRING
      notNull: true
      notEmpty: true
    }).then(() ->
      migration.changeColumn('Posters', 'description', {
        type: DataTypes.TEXT
        notNull: true
        notEmpty: true
      })
    ).done(done)
  down: (migration, DataTypes, done) ->
    migration.changeColumn('Posters', 'title', {
      type: DataTypes.STRING
    }).then(() ->
      migration.changeColumn('Posters', 'description', {
        type: DataTypes.TEXT
      })
    ).done(done)
    return
