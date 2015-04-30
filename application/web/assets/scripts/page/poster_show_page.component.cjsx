_ = require('lodash')
React = require('react')

PosterShow = require('../poster/poster.show.component.cjsx')

debug = require('../debug')('poster_page:component')

# LIST_KEY = 'HOME'

PosterPage = React.createClass({
  displayName: 'PosterPage'

  statics:
    fetchData: (params, query) ->
      PosterShow.fetchData(params, query)

  contextTypes:
    router: React.PropTypes.func

  propTypes:
    user: React.PropTypes.object.isRequired

  render: ->
    params = @context.router.getCurrentParams()
    posterId = Number(params.posterId)
    <div className='poster-page'>
      <PosterShow user={@props.user} posterId={posterId} />
    </div>

})

module.exports = PosterPage