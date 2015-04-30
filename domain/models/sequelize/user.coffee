crypto = require('crypto')

registry = require('../../../system/registry')

SALT_PASSWORD_ENCODING = 'base64'

module.exports = (sequelize, DataTypes) ->
  User = sequelize.define('User', {
    email: DataTypes.STRING
    password: DataTypes.STRING
    salt: DataTypes.STRING
    firstName: DataTypes.STRING
    lastName: DataTypes.STRING
  }, {
    setterMethods:
      password: (password) ->
        @resetSalt()
        @setDataValue('password', @getEncryptedPassword(password))

    instanceMethods:
      resetSalt: () ->
        @set('salt', User.makeSalt())

      getEncryptedPassword: (password) ->
        return crypto.pbkdf2Sync(
          password,
          new Buffer(@get('salt'), SALT_PASSWORD_ENCODING),
          10000,
          64
        ).toString(SALT_PASSWORD_ENCODING)

      authenticate: (password) ->
        @getEncryptedPassword(password) is @get('password')

      createNewPosterWithData: (data) ->
        {Poster, posterRepository} = registry.instance()

        poster = Poster.build(data)
        poster.set('ownerId', @get('id'))

        posterRepository.save(poster)

    classMethods:
      makeSalt: () ->
        return crypto.randomBytes(16).toString(SALT_PASSWORD_ENCODING)

      associate: (models) ->
  })

  return User
