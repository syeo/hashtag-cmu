'use strict'
module.exports =
  up: (migration, DataTypes, done) ->
    migration.createTable('Users',
      id:
        allowNull: false
        autoIncrement: true
        primaryKey: true
        type: DataTypes.INTEGER
      email: type: DataTypes.STRING
      password: type: DataTypes.STRING
      salt: type: DataTypes.STRING
      createdAt:
        allowNull: false
        type: DataTypes.DATE
      updatedAt:
        allowNull: false
        type: DataTypes.DATE).done done
    return
  down: (migration, DataTypes, done) ->
    migration.dropTable('Users').done done
    return
