_ = require('lodash')
React = require('react')

PosterNew = require('../poster/poster.new.component.cjsx')

debug = require('../debug')('poster_page:component')

# LIST_KEY = 'HOME'

PosterPage = React.createClass({
  displayName: 'PosterPage'

  contextTypes:
    router: React.PropTypes.func

  propTypes:
    user: React.PropTypes.object.isRequired

  render: ->
    <div className='poster-page'>
      <PosterNew user={@props.user} />
    </div>

})

module.exports = PosterPage
