React = require('react')
Router = require('react-router')

RouteHandler = Router.RouteHandler
NavBar = require('../nav_bar.component.cjsx')

AuthenticatedUserApp = React.createClass
  displayName: 'AuthenticatedUserApp'

  render: ->
    <div>
      <NavBar/>
      <div className="authenticated-content">
        <RouteHandler/>
      </div>
    </div>

module.exports = AuthenticatedUserApp
