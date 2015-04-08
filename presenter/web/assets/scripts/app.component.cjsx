React = require('react')
Router = require('react-router')

RouteHandler = Router.RouteHandler
NavTopBar = require('./nav_top_bar.component.cjsx')

App = React.createClass
  displayName: 'App'

  render: ->
    <div>
      <NavTopBar/>
      <div className="content">
        <RouteHandler/>
      </div>
    </div>

module.exports = App
