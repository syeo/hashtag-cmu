React = require('react')
_ = require('lodash')

PosterStore = require('../poster/poster.store')
PosterService = require('../poster/poster.service')

debug = require('../debug')('poster:component')

PosterListItem = React.createClass
  displayName: 'PosterListItem'

  getDefaultProps: ->
    {
      load: true
    }

  makeStateFromStore: ->
    {
      poster: PosterStore.getPoster(@props.poster.id)
    }

  getInitialState: -> @makeStateFromStore()

  componentDidMount: ->
    PosterStore.addChangeListener(@_onChange)
    if @props.load
      PosterService.loadPoster(@props.poster.id)

  renderContent: ->
    poster = @state.poster

    image = _.first(poster.images)

    if image
      imageContent = <img className="poster-image" src={image.url} />
    else
      imageContent = null

    [
      {imageContent}
      <div className="poster-content">
        <div className="poster-title">{@props.poster.title}</div>
        <div>{@props.poster.description}</div>
      </div>
    ]

  renderLoading: ->
    <div>
      loading
    </div>

  renderInner: ->
    if @state.poster
      return @renderContent()
    else
      return @renderLoading()

  render: ->
    <div className="poster poster-list-item">
      {@renderInner()}
    </div>

  _onChange: -> @setState(@makeStateFromStore())

module.exports = PosterListItem