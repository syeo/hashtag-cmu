_ = require('lodash')

ApiService = require('../api/api.service')
Promise = require('../promise')

debug = require('../debug')('poster_image:service')

module.exports =
  upload: (file) ->
    ApiService.uploadPosterImage(file)
