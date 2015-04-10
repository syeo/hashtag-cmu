Router = require('react-router')

App = require('./app.component.cjsx')
Home = require('./home/home.component.cjsx')

DefaultRoute = Router.DefaultRoute
Route = Router.Route

module.exports = (
  <Route handler={App}>
    <Route name="home" path="/" handler={Home} />
    <Route name="tag" path="tags/:tagId" handler={Home} />
    <DefaultRoute handler={Home} />
  </Route>
)