_ = require('lodash')
React = require('react')

Poster = require('../poster/poster.component.cjsx')

debug = require('../debug')('poster_page:component')

# LIST_KEY = 'HOME'

PosterPage = React.createClass({
  displayName: 'PosterPage'

  contextTypes:
    router: React.PropTypes.func

  render: ->
    <div className='poster-page'>
      <Poster />
    </div>

})

module.exports = PosterPage
