React = require('react')
Router = require('react-router')

RouteHandler = Router.RouteHandler
NavBar = require('./nav_bar.component.cjsx')

App = React.createClass
  displayName: 'App'

  render: ->
    <div>
      <NavBar/>
      <div className="content">
        <RouteHandler/>
      </div>
    </div>

module.exports = App
