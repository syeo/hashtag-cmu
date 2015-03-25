'use strict'

module.exports = (sequelize, DataTypes) ->
  PosterImage = sequelize.define('PosterImage', {
    thumbnailUrl:
      type: DataTypes.STRING
    cardUrl:
      type: DataTypes.STRING
    originalUrl:
      type: DataTypes.STRING
  }, {
    classMethods:
      associate: (models) ->
        PosterImage.belongsTo(models.Poster, {
          as: 'poster'
          foreignKey: 'posterId'
        })
  })
  PosterImage
