_ = require('lodash')

Promise = require('../../../config/promise')
BaseDehydrator = require('./base.dehydrator')

debug = require('../../../etc/debug')('view:dehydrator:poster')

class PosterDehydrator extends BaseDehydrator
  whole: (obj) =>
    Promise.all([
      super(obj)
      @registry.presenter.dehydrator.posterImageDehydrator.list(obj.getImages())
    ]).spread((res, images) ->
      _.extend(res, {
        images: images
      })
    )

module.exports = (registry) -> new PosterDehydrator(registry)