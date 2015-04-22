_ = require('lodash')

BaseDehydrator = require('./base.dehydrator')
Promise = require('../../../system/promise')
registry = require('../../../system/registry')

class PosterImageDehydrator extends BaseDehydrator
  whole: (obj) ->
    posterRepository = registry.instance().posterRepository
    posterDehydrator = registry.instance().posterDehydrator

    posterRepository.findById(obj.get('posterId')).then((poster) ->
      Promise.all([
        super(obj)
        posterDehydrator.skim(poster)
      ])
    ).spread((res, poster) ->
      res.poster = poster
      return res
    )

  skim: (obj) =>
    super(obj).then((res) ->
      res = _.omit(res, 'posterId')
      res.poster = {id: obj.get('posterId') }
      return res
    )

module.exports = () -> new PosterImageDehydrator()