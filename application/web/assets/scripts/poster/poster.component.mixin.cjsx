_ = require('lodash')
Router = require('react-router')
ReactBootstrap = require('react-bootstrap')

AuthService = require('../auth/auth.service')

{ButtonToolbar, Button, Input} = ReactBootstrap

debug = require('../debug')('poster:component:mixin')

Link = Router.Link

urlKey = if window.location.protocol == 'https:' then 'secureUrl' else 'url'

module.exports =
  renderImageSection: (poster) ->
    unless _.isEmpty(poster.images)
      firstImage = _.first(poster.images)
      imageSection = <div className="poster-image-section">
        <Link to="poster-show" params={{posterId: poster.id}}>
          <img className="poster-image" src={firstImage[urlKey]} />
        </Link>
      </div>
    else
      imageSection = []

    return imageSection

  renderImageEditSection: (poster, inputAttrs = {}, imageAttrs = {}) ->
    unless _.isEmpty(poster.images)
      firstImage = _.first(poster.images)
      imageSection = <div className="poster-image-section">
        <input {...inputAttrs} />
        <img className="poster-image"
             src={firstImage[urlKey]}
             {...imageAttrs} />
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

  renderTitleEditSection: (poster, inputAttrs = {}) ->
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
            content = <span className="tag label">
              {tag.name}
            </span>

            if tag.id
              content = <Link to="tag" params={{tagId: tag.id}} key={tag.id}>
                {content}
              </Link>

            return content
          )
        }</div>
      </div>
    else
      tagsSection = []

    return tagsSection

  renderTagsEditSection: (poster, inputAttrs = {}) ->
    tagsText = _.map(poster.tags, (tag) -> tag.name).join(", ").trim()
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

  renderDescriptionEditSection: (poster, inputAttrs = {}) ->
    <div className="poster-content-section">
      <Input className="poster-description"
             value={poster.description}
             {...inputAttrs} />
    </div>

  renderEditControl: (user, poster, onClick) ->
    if AuthService.userCanEditPoster(user, poster)
      <Button className='edit'
              bsSize='xsmall'
              onClick={onClick}>
        Edit
      </Button>

  renderDeleteControl: (user, poster, onClick) ->
    if AuthService.userCanDeletePoster(user, poster)
      <Button className='delete'
              bsSize='xsmall'
              bsStyle='link'
              onClick={onClick}>
        Delete
      </Button>

  renderSaveControl: (user, poster, onClick) ->
    if AuthService.userCanDeletePoster(user, poster)
      <Button bsStyle='primary'
              bsSize='xsmall'
              onClick={onClick}>
        Save
      </Button>

  renderTogglePreviewControl: (user, poster, onClick, text) ->
    if AuthService.userCanEditPoster(user, poster)
      <Button className='preview'
              bsSize='xsmall'
              onClick={onClick}>
        {text}
      </Button>

  renderCancelControl: (user, poster, onClick) ->
    if AuthService.userCanEditPoster(user, poster)
      <Button className='cancel'
              bsSize='xsmall'
              onClick={@handleCancelClick}>
        Cancel
      </Button>

  renderShowControls: (user, poster, options) ->
    <ButtonToolbar>
      {@renderEditControl(user, poster, options.onEditButtonClick)}
      {@renderDeleteControl(user, poster, options.onDeleteButtonClick)}
    </ButtonToolbar>
