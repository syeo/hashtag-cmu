registry = require('../../system/registry')
debug = require('../../system/debug')('domain:user_service')

class UserService
  signUp: (data) ->
    debug(data)
    User = registry.instance().User
    user = User.build(data)
    debug(user)
    debug(user.get({plain: true}))
    registry.instance().userRepository.save(user)


module.exports = UserService