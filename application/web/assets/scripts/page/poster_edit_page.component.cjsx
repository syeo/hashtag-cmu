_ = require('lodash')
React = require('react')

PosterEdit = require('../poster/poster.edit.component.cjsx')

debug = require('../debug')('poster_page:component')

# LIST_KEY = 'HOME'

PosterPage = React.createClass({
  displayName: 'PosterPage'

  statics:
    fetchData: (params, query) ->
      PosterEdit.fetchData(params, query)

  contextTypes:
    router: React.PropTypes.func

  render: ->
    params = @context.router.getCurrentParams()
    posterId = params.posterId
    <div className='poster-page'>
      <PosterEdit posterId={posterId} />
    </div>

})

module.exports = PosterPage
