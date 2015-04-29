_ = require('lodash')

BaseDehydrator = require('../shared/base.dehydrator')
Promise = require('../../system/promise')
registry = require('../../system/registry')

class PosterImageDehydrator extends BaseDehydrator
  whole: (obj, context = {}) =>
    posterRepository = registry.instance().posterRepository
    posterDehydrator = registry.instance().posterDehydrator

    posterRepository.findById(obj.get('posterId'))
      .bind(@)
      .then((poster) ->
        Promise.all([
          super(obj, context)
          posterDehydrator.skim(poster, context)
        ])
      )
      .spread((res, poster) ->
        res.poster = poster
        return res
      )

  skim: (obj, context = {}) =>
    super(obj, context).then((res) ->
      res = _.omit(res, ['posterId', 'ownerId'])
      res.poster = {id: obj.get('posterId') }
      res.owner = {id: obj.get('ownerId') }
      return res
    )

module.exports = PosterImageDehydrator