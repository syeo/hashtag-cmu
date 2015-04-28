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
    deleted:
      type: DataTypes.BOOLEAN
      defaultValue: false
      notNull: true
  }, {
    classMethods:
      associate: (models) ->
        Poster.hasMany(models.PosterImage, {
          as: 'images'
          foreignKey: 'posterId'
        })
        Poster.belongsTo(models.User, {
          as: 'owner'
          foreignKey: 'ownerId'
        })
        Poster.belongsToMany(models.Tag, {
          as: 'tags'
          through: 'PosterTag'
          foreignKey: 'posterId'
        })
  })
  Poster
