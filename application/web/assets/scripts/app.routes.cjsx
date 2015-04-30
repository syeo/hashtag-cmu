Router = require('react-router')

AuthenticatedUserApp = require('./app/authenticated_user.app.component.cjsx')
AnonymousUserApp = require('./app/anonymous_user.app.component.cjsx')
HomePage = require('./page/home_page.component.cjsx')
TagPage = require('./page/tag_page.component.cjsx')
PosterShowPage = require('./page/poster_show_page.component.cjsx')
PosterEditPage = require('./page/poster_edit_page.component.cjsx')
PosterNewPage = require('./page/poster_new_page.component.cjsx')
LogInPage = require('./page/log_in_page.component.cjsx')
SignUpPage = require('./page/sign_up_page.component.cjsx')

DefaultRoute = Router.DefaultRoute
Route = Router.Route

module.exports = (
  <Route name="app">
    <Route name="authenticated-user-app" path="/" handler={AuthenticatedUserApp}>
      <Route name="home" path="/" handler={HomePage} />
      <Route name="tag" path="tags/:tagId" handler={TagPage} />
      <Route name="poster-new" path="posters/new" handler={PosterNewPage}/>
      <Route name="poster-show" path="posters/:posterId" handler={PosterShowPage}/>
      <Route name="poster-edit" path="posters/:posterId/edit" handler={PosterEditPage}/>
      <DefaultRoute handler={HomePage} />
    </Route>
    <Route name="anonymous-user-app" path="/" handler={AnonymousUserApp}>
      <Route name="log-in" path="log-in" handler={LogInPage} />
      <Route name="sign-up" path="sign-up" handler={SignUpPage} />
    </Route>
  </Route>
)