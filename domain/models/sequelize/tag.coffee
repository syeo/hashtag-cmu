'use strict'

module.exports = (sequelize, DataTypes) ->
  Tag = sequelize.define('Tag', {
    name: DataTypes.STRING
  }, {
    classMethods:
      associate: (models) ->
        Tag.belongsToMany(models.Poster, {
          as: 'posters'
          through: 'PosterTag'
          foreignKey: 'tagId'
        })
  })
  Tag
