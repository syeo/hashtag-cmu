_ = require('lodash')
Router = require('react-router')

Link = Router.Link

module.exports =
  renderImageSection: (poster) ->
    unless _.isEmpty(poster.images)
      firstImage = _.first(poster.images)
      imageSection = <div className="poster-image-section">
        <img className="poster-image" src={firstImage.url} />
      </div>
    else
      imageSection = []

    return imageSection

  renderTitleSection: (poster) ->
    <div className="poster-content-section">
      <Link to="poster" params={{posterId: poster.id}}>
        <h3 className="poster-title">
          {poster.title}
        </h3>
      </Link>
    </div>

  renderTagsSection: (poster) ->
    unless _.isEmpty(poster.tags)
      tagsSection = <div className="poster-content-section v-skinny">
        <div className="poster-tags">{
          _.map(poster.tags, (tag) ->
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

  renderDescriptionSection: (poster) ->
    unless _.isEmpty(poster.description)
      descriptionSection = <div className="poster-content-section">
        <div className="poster-description">
          {poster.description}
        </div>
      </div>
    else
      descriptionSection = []

    return descriptionSection

  renderPoster: (poster) ->
    <div className="poster">
      {@renderImageSection(poster)}
      {@renderTitleSection(poster)}
      {@renderTagsSection(poster)}
      {@renderDescriptionSection(poster)}
    </div>
