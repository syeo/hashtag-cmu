Router = require('react-router')

App = require('./app.component.cjsx')
HomePage = require('./page/home_page.component.cjsx')
TagPage = require('./page/tag_page.component.cjsx')
PosterPage = require('./page/poster_page.component.cjsx')

DefaultRoute = Router.DefaultRoute
Route = Router.Route

module.exports = (
  <Route handler={App}>
    <Route name="home" path="/" handler={HomePage} />
    <Route name="tag" path="tags/:tagId" handler={TagPage} />
    <Route name="poster" path="posters/:posterId" handler={PosterPage} />
    <DefaultRoute handler={HomePage} />
  </Route>
)