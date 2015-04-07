React = require('react')
_ = require('lodash')

PosterStore = require('../poster/poster.store')
PosterService = require('../poster/poster.service')

debug = require('../debug')('poster:component')

PosterListItem = React.createClass
  displayName: 'PosterListItem'

  makeStateFromStore: ->
    {
      poster: PosterStore.getPoster(@props.poster.id)
    }

  getInitialState: -> @makeStateFromStore()

  render: ->
    poster = @state.poster

    firstImage = _.first(poster.images)

    if firstImage
      image = <img className="poster-image" src={firstImage.url} />
    else
      image = null

    tags = _.map(poster.tags, (tag) ->
      <span className="tag badge">
        {tag.text}
      </span>
    )

    <div className="poster poster-list-item">
      {image}
      <div className="poster-content">
        <h3 className="poster-title">{@props.poster.title}</h3>
        <div className="sep"/>
        <div className="poster-tags">
          {tags}
        </div>
        <div className="sep"/>
        <div className="poster-description">
          {@props.poster.description}
        </div>
      </div>
    </div>

module.exports = PosterListItem