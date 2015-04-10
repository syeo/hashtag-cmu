Router = require('react-router')

App = require('./app.component.cjsx')
Home = require('./home/home.component.cjsx')

DefaultRoute = Router.DefaultRoute
Route = Router.Route

module.exports = (
  <Route name="home" path="/" handler={App}>
    <DefaultRoute handler={Home}/>
  </Route>
)