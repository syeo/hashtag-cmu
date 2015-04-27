class ApiError extends Error
  constructor: (@code, @data = {}) ->

module.exports = ApiError