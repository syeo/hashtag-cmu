'use strict'

module.exports = (sequelize, DataTypes) ->
  Tag = sequelize.define('Tag', { name: DataTypes.STRING }, classMethods: associate: (models) ->
    # associations can be defined here
    return
  )
  Tag
