'use strict'
module.exports =
  up: (migration, DataTypes, done) ->
    migration.createTable('PosterTags',
      id:
        allowNull: false
        autoIncrement: true
        primaryKey: true
        type: DataTypes.INTEGER
      posterId: type: DataTypes.INTEGER
      tagId: type: DataTypes.INTEGER
      createdAt:
        allowNull: false
        type: DataTypes.DATE
      updatedAt:
        allowNull: false
        type: DataTypes.DATE).done done
    return
  down: (migration, DataTypes, done) ->
    migration.dropTable('PosterTags').done done
    return
