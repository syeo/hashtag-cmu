Router = require('react-router')

App = require('./app.component.cjsx')
Home = require('./home/home.component.cjsx')
NavTopBar = require('./nav_top_bar.component.cjsx')

DefaultRoute = Router.DefaultRoute
Route = Router.Route

module.exports = (
  <NavTopBar/>
)

# module.exports = (
#     <NavTopBar/>
#   <Route name="app" path="/" handler={App}>
#     <NavTopBar/>
#     <DefaultRoute handler={Home}/>
#   </Route>
# )