Router = require('react-router')

AuthenticatedUserApp = require('./app/authenticated_user.app.component.cjsx')
AnonymousUserApp = require('./app/anonymous_user.app.component.cjsx')
HomePage = require('./page/home_page.component.cjsx')
TagPage = require('./page/tag_page.component.cjsx')
PosterPage = require('./page/poster_page.component.cjsx')
LogInPage = require('./page/log_in_page.component.cjsx')
SignUpPage = require('./page/sign_up_page.component.cjsx')

DefaultRoute = Router.DefaultRoute
Route = Router.Route

module.exports = (
  <Route>
    <Route path="/" handler={AuthenticatedUserApp}>
      <Route name="home" path="/" handler={HomePage} />
      <Route name="tag" path="tags/:tagId" handler={TagPage} />
      <Route name="poster" path="posters/:posterId" handler={PosterPage} />
      <DefaultRoute handler={HomePage} />
    </Route>
    <Route path="/" handler={AnonymousUserApp}>
      <Route name="log-in" path="log-in" handler={LogInPage} />
      <Route name="sign-up" path="sign-up" handler={SignUpPage} />
    </Route>
  </Route>
)