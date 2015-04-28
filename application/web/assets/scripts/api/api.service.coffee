superagent = require('superagent')

constant = require('../constants')
utils = require('../shared/utils')
ApiError = require('./api.error')

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

  processApiError: (err) ->
    throw new ApiError(err.status, err.response?.body)

  getMe: () =>
    utils.makePromiseWithSuperagentRequest(
      @makeGetRequest(
        '/users/me',
      )
    ).then((res) ->
      res.body.user
    )
    .catch(@processApiError)


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
    .catch(@processApiError)

  logIn: (data) =>
    utils.makePromiseWithSuperagentRequest(
      @makePostRequest(
        '/users/log-in',
        {
          email: data.email
          password: data.password
        }
      )
    ).then((res) ->
      res.body.user
    )
    .catch(@processApiError)

  getHomePosterList: () =>
    utils.makePromiseWithSuperagentRequest(
      @makeGetRequest("/posters")
    ).then((res) ->
      res.body.posters
    )
    .catch(@processApiError)

  getTagPosterList: (tagId) =>
    utils.makePromiseWithSuperagentRequest(
      @makeGetRequest("/tags/#{tagId}/posters")
    ).then((res) ->
      res.body.posters
    )
    .catch(@processApiError)

  getTagList: () =>
    utils.makePromiseWithSuperagentRequest(
      @makeGetRequest("/tags")
    ).then((res) ->
      res.body.tags
    )
    .catch(@processApiError)

  getPoster: (id) =>
    utils.makePromiseWithSuperagentRequest(
      @makeGetRequest("/posters/#{id}")
    ).then((res) ->
      res.body.poster
    )
    .catch(@processApiError)

module.exports = new ApiService