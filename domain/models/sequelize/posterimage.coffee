'use strict'

module.exports = (sequelize, DataTypes) ->
  PosterImage = sequelize.define('PosterImage', {
    url:
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
