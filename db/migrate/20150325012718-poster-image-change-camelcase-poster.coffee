'use strict'
module.exports =
  up: (migration, DataTypes, done) ->
    migration.renameColumn('PosterImages', 'PosterId', 'posterId').done(done)

  down: (migration, DataTypes, done) ->
    migration.renameColumn('PosterImages', 'posterId', 'PosterId').done(done)
