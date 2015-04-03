React = require('react')
Router = require('react-router')

RouteHandler = Router.RouteHandler
Link = Router.Link

App = React.createClass
  displayName: 'App'

  render: ->
    <div>
      <header>
        <ul>
          <li><Link to="app">Home</Link></li>
        </ul>
      </header>

      <RouteHandler/>
    </div>

module.exports = App
