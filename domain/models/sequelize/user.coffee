crypto = require('crypto')

SALT_PASSWORD_ENCODING = 'base64'

module.exports = (sequelize, DataTypes) ->
  User = sequelize.define('User', {
    email: DataTypes.STRING
    password: DataTypes.STRING
    salt: DataTypes.STRING
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

    classMethods:
      makeSalt: () ->
        return crypto.randomBytes(16).toString(SALT_PASSWORD_ENCODING)

      associate: (models) ->
  })

  return User
