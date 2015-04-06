React = require('react')
MasonryMixin = require('react-masonry-mixin')

masonryOptions = {}

PosterStream = React.createClass
  displayName: 'PosterStream'

  mixins: [MasonryMixin('masonryContainer', masonryOptions)]

  render: ->
    <div className="container">
      <div className='row' ref='masonryContainer'>
        {@props.children}
      </div>
    </div>

module.exports = PosterStream