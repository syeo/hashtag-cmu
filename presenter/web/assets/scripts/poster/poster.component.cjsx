React = require('react')

debug = require('../debug')('poster:component')

debug("here")

Poster = React.createClass
  displayName: 'Poster'

  render: ->
    debug("render")
    <div>
      <h1>{@props.poster.title}</h1>
      <div>{@props.poster.id}</div>
    </div>

module.exports = Poster