_ = require('lodash')

debug = require('../../../etc/debug')('view:dehydrator:poster')
Promise = require('../../../config/promise')
BaseDehydrator = require('./base_dehydrator')


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