'use strict'

module.exports = (sequelize, DataTypes) ->
  PosterTag = sequelize.define('PosterTag', {
  }, {
    classMethods:
      associate: (models) ->
        PosterTag.belongsTo(models.Poster, {
          as: 'poster'
          foreignKey: 'posterId'
        })
        PosterTag.belongsTo(models.Tag, {
          as: 'tag'
          foreignKey: 'tagId'
        })
  })
  PosterTag
