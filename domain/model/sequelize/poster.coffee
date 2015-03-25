'use strict'

module.exports = (sequelize, DataTypes) ->
  Poster = sequelize.define('Poster', {
    title:
      type: DataTypes.STRING
      notNull: true
      notEmpty: true
    description:
      type: DataTypes.TEXT
      notNull: true
      notEmpty: true
  }, {
    classMethods:
      associate: (models) ->
        Poster.hasMany(models.PosterImage, {
          as: 'images'
          foreignKey: 'posterId'
        })
  })
  Poster
