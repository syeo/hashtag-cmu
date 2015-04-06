React = require('react')
Router = require('react-router')

RouteHandler = Router.RouteHandler
Link = Router.Link

App = React.createClass
  displayName: 'App'

  render: ->
    <div>
      <RouteHandler/>
    </div>

module.exports = App
