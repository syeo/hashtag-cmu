superagent = require('superagent')

constant = require('../constants')
utils = require('../shared/utils')

debug = require('../debug')('api:service')

class ApiService
  makeApiUrl: (path) -> "#{constant.API.ROOT}#{path}"

  makeGetRequest: (path) =>
    superagent
      .get(@makeApiUrl(path))

  getPosterList: () =>
    utils.makePromiseWithSuperagentRequest(
      @makeGetRequest("/posters")
    ).then((res) ->
      res.body.posters
    )

  getPoster: (id) =>
    utils.makePromiseWithSuperagentRequest(
      @makeGetRequest("/posters/#{id}")
    ).then((res) ->
      res.body.poster
    )

module.exports = new ApiService