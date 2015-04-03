Router = require('react-router')
React = require('react')

window.React = React

routes = require('./app.routes.cjsx')

Router.run(routes, Router.HistoryLocation, (Handler) ->
  React.render(<Handler/>, document.getElementById('app'))
)

# Router.run(routes, (Handler) ->
#   React.render(<Handler/>, document.body)
# )

# React.render(
#     <Home />,
#     document.getElementById('app')
# );
