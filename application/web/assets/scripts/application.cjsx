_ = require('lodash')
Router = require('react-router')
React = require('react')

window.React = React

PosterActionCreator = require('./page/page_data.action_creator')
routes = require('./app.routes.cjsx')

Router.run(routes, Router.HistoryLocation, (Handler, state) ->
  PosterActionCreator.changePageData(state.params, state.query)

  React.render(<Handler/>, document.getElementById('app'))
)
