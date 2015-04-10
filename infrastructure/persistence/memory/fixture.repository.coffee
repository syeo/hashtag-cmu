_  = require('lodash')
moment = require('moment')

BaseRepository = require('./base.repository')
Promise = require('../../../config/promise')

debug = require('../../../etc/debug')('infra:persist:fixture_repo')

class FixtureRepository extends BaseRepository
  constructor: (@registry, file) ->
    super(@registry)
    @objDict = {}
    @loadFromFile(file)

  loadFromFile: (file) =>
    dataArr = require(file)
    _.map(_.map(dataArr, @factory), @save)

  getDictionary: =>
    Promise.resolve(@objDict)

  save: (obj) =>
    if not obj.get('createdAt')
      debug('setting createdAt')
      obj.set('createdAt', moment().format())

    debug('setting updatedAt')
    obj.set('updatedAt', moment().format())

    if not obj.get('id')
      obj.set('id', @getNextId())

    debug(obj)

    @objDict[obj.get('id')] = obj
    Promise.resolve(obj)

  getNextId: () =>
    maxId = _.max(_.map(_.values(@objDict), (obj) -> obj.get('id')))
    if _.isFinite(maxId)
      return maxId + 1
    else
      return 1

module.exports = FixtureRepository