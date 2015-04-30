React = require('react')
Router = require('react-router')

RouteHandler = Router.RouteHandler
NavBar = require('../nav_bar.component.cjsx')
UserService = require('../user/user.service')
UserStore = require('../user/user.store')
debug = require('../debug')('authenticated-user-app')

AuthenticatedUserApp = React.createClass
  displayName: 'AuthenticatedUserApp'

  statics:
    fetchData: () ->
      UserService.loadMe()

  render: ->

    <div>
      <NavBar/>
      <div className="authenticated-content">
        <RouteHandler user={UserStore.getMe()} />
      </div>
    </div>

module.exports = AuthenticatedUserApp
