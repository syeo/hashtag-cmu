'use strict'
module.exports =
  up: (migration, DataTypes, done) ->
    migration.createTable('Posters',
      id:
        allowNull: false
        autoIncrement: true
        primaryKey: true
        type: DataTypes.INTEGER
      title: type: DataTypes.STRING
      description: type: DataTypes.TEXT
      createdAt:
        allowNull: false
        type: DataTypes.DATE
      updatedAt:
        allowNull: false
        type: DataTypes.DATE).done done
    return
  down: (migration, DataTypes, done) ->
    migration.dropTable('Posters').done done
    return
