'use strict'
module.exports =
  up: (migration, DataTypes, done) ->
    migration.removeColumn('PosterImages', 'path').then(() ->
      migration.addColumn('PosterImages', 'thumbnailUrl', {
        type: DataTypes.STRING
      })
    ).then(() ->
      migration.addColumn('PosterImages', 'cardUrl', {
        type: DataTypes.STRING
      })
    ).then(() ->
      migration.addColumn('PosterImages', 'originalUrl', {
        type: DataTypes.STRING
      })
    ).done(done)
  down: (migration, DataTypes, done) ->
    migration.addColumn('PosterImages', 'path', {
      type: DataTypes.STRING
      allowNull: false
      allowEmpty: false
    }).done(done)
