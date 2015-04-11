Router = require('react-router')

App = require('./app.component.cjsx')
HomePage = require('./pages/home_page.component.cjsx')
TagPage = require('./pages/tag_page.component.cjsx')

DefaultRoute = Router.DefaultRoute
Route = Router.Route

module.exports = (
  <Route handler={App}>
    <Route name="home" path="/" handler={HomePage} />
    <Route name="tag" path="tags/:tagId" handler={TagPage} />
    <DefaultRoute handler={HomePage} />
  </Route>
)