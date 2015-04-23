QT = require('sequelize-qt')

BaseRepository = require('./base.repository')
UserRepositoryMixin = require('../shared/user.repository.mixin')
mixOf = require('../../../etc/mix_of')
registry = require('../../../system/registry')

debug = require('../../../system/debug')('infra:persistence:UserRepository')

Query = QT.Query
Condition = QT.Condition

class UserRepository extends mixOf(BaseRepository,
                                  UserRepositoryMixin)
  getModel: () -> registry.instance().User

  findByEmail: (email) =>
    @find(Query.where(Condition.eq('email', email)))


module.exports = UserRepository
