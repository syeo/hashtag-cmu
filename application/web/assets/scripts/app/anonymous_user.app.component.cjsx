React = require('react')
Router = require('react-router')

RouteHandler = Router.RouteHandler

AnonymousUserApp = React.createClass
  displayName: 'AnonymousUserApp'

  render: ->
    <div>
      <div className="anonymous-content">
        <RouteHandler/>
      </div>
    </div>

module.exports = AnonymousUserApp
