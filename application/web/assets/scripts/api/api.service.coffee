superagent = require('superagent')

constant = require('../constants')
utils = require('../shared/utils')

debug = require('../debug')('api:service')

class ApiService
  makeApiUrl: (path) -> "#{constant.API.ROOT}#{path}"

  makeGetRequest: (path) =>
    superagent
      .get(@makeApiUrl(path))

  makePostRequest: (path, data) =>
    superagent
      .post(@makeApiUrl(path))
      .send(data)

  signUp: (data) =>
    utils.makePromiseWithSuperagentRequest(
      @makePostRequest(
        '/users',
        {
          email: data.email
          password: data.password
          firstName: data.firstName
          lastName: data.lastName
        }
      )
    ).then((res) ->
      res.body.user
    )

  getHomePosterList: () =>
    utils.makePromiseWithSuperagentRequest(
      @makeGetRequest("/posters")
    ).then((res) ->
      res.body.posters
    )

  getTagPosterList: (tagId) =>
    utils.makePromiseWithSuperagentRequest(
      @makeGetRequest("/tags/#{tagId}/posters")
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