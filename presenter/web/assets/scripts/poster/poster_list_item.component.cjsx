React = require('react')
_ = require('lodash')
Router = require('react-router')

PosterStore = require('../poster/poster.store')
PosterService = require('../poster/poster.service')
Link = Router.Link

debug = require('../debug')('poster:component')

PosterListItem = React.createClass
  displayName: 'PosterListItem'

  renderImageSection: ->
    unless _.isEmpty(@props.poster.images)
      firstImage = _.first(@props.poster.images)
      imageSection = <div className="poster-image-section">
        <img className="poster-image" src={firstImage.url} />
      </div>
    else
      imageSection = []

    return imageSection

  renderTitleSection: ->
    <div className="poster-content-section">
      <h3 className="poster-title">{@props.poster.title}</h3>
    </div>

  renderTagsSection: ->
    unless _.isEmpty(@props.poster.tags)
      tagsSection = <div className="poster-content-section v-skinny">
        <div className="poster-tags">{
          _.map(@props.poster.tags, (tag) ->
            <Link to="tag" params={{tagId: tag.id}} key={tag.id}>
              <span className="tag label">
                {tag.text}
              </span>
            </Link>
          )
        }</div>
      </div>
    else
      tagsSection = []

    return tagsSection

  renderDescriptionSection: ->
    <div className="poster-content-section">
      <div className="poster-description">
        {@props.poster.description}
      </div>
    </div>

  render: ->
    <div className="poster poster-list-item">
      {@renderImageSection()}
      {@renderTitleSection()}
      {@renderTagsSection()}
      {@renderDescriptionSection()}
    </div>

module.exports = PosterListItem