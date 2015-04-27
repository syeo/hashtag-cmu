_ = require('lodash')
Router = require('react-router')
React = require('react')

window.React = React

PosterActionCreator = require('./page/page_data.action_creator')
routes = require('./app.routes.cjsx')
Promise = require('./promise')
ApiError = require('./api/api.error')

debug = require('./debug')('application')

Router.run(routes, Router.HistoryLocation, (Handler, state) ->
  fetchers = _.compact(_.map(state.routes, (route) -> route.handler.fetchData))
  promises = _.map(fetchers, (fetcher) -> fetcher(state.params, state.query))

  Promise.all(promises)
    .then(() ->
      React.render(<Handler/>, document.getElementById('app'))
    )
    .catch((error) ->
      if error instanceof ApiError
        if error.code == 401
          window.location.pathname = "/sign-up"
          return

      throw error
    )
)
