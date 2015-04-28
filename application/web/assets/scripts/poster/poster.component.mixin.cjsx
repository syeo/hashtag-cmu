_ = require('lodash')
Router = require('react-router')
ReactBootstrap = require('react-bootstrap')

debug = require('../debug')('poster:component:mixin')

Input = ReactBootstrap.Input

Link = Router.Link

module.exports =
  renderImageSection: (poster) ->
    unless _.isEmpty(poster.images)
      firstImage = _.first(poster.images)
      imageSection = <div className="poster-image-section">
        <Link to="poster-show" params={{posterId: poster.id}}>
           <img className="poster-image" src={firstImage.url} />
        </Link>
      </div>
    else
      imageSection = []

    return imageSection

  renderTitleSection: (poster) ->
    <div className="poster-content-section">
      <Link to="poster-show" params={{posterId: poster.id}}>
        <h3 className="poster-title">
          {poster.title}
        </h3>
      </Link>
    </div>

  renderTitleEditSection: (poster, inputAttrs) ->
    <div className="poster-content-section">
      <Input className="poster-title"
             value={poster.title}
             {...inputAttrs} />
    </div>

  renderTagsSection: (poster) ->
    unless _.isEmpty(poster.tags)
      tagsSection = <div className="poster-content-section v-skinny">
        <div className="poster-tags">{
          _.map(poster.tags, (tag) ->
            <Link to="tag" params={{tagId: tag.id}} key={tag.id}>
              <span className="tag label">
                {tag.name}
              </span>
            </Link>
          )
        }</div>
      </div>
    else
      tagsSection = []

    return tagsSection

  renderTagsEditSection: (poster, inputAttrs) ->
    tagsText = _.map(poster.tags, (tag) -> tag.name).join(", ")
    debug(tagsText)
    <div className="poster-content-section">
      <Input className="poster-tags"
             value={tagsText}
             {...inputAttrs} />
    </div>

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

  renderDescriptionEditSection: (poster, inputAttrs) ->
    <div className="poster-content-section">
      <Input className="poster-description"
             value={poster.description}
             {...inputAttrs} />
    </div>
