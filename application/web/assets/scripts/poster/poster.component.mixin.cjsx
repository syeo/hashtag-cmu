_ = require('lodash')
Router = require('react-router')
ReactBootstrap = require('react-bootstrap')

{ButtonToolbar, Button, Input} = ReactBootstrap

debug = require('../debug')('poster:component:mixin')

Link = Router.Link

module.exports =
  getUrlKey: () ->
    if window.location.protocol == 'https:' then 'secureUrl' else 'url'

  getImageUrl: (poster) ->
    unless _.isEmpty(poster.images)
      image = _.first(poster.images)
    else
      image = {
        url: 'http://placehold.it/700x400'
        secureUrl: 'https://placehold.it/700x400'
      }

    return image[@getUrlKey()]

  renderImageSection: (poster) ->
    content = <img className="poster-image" src={@getImageUrl(poster)} />

    if poster.id
      content = <Link to="poster-show" params={{posterId: poster.id}}>
        {content}
      </Link>

    <div className="poster-image-section">
      {content}
    </div>

  renderTitleSection: (poster) ->
    content = <h3 className="poster-title">
      {poster.title}
    </h3>

    if poster.id
      content = <Link to="poster-show" params={{posterId: poster.id}}>
        {content}
      </Link>

    <div className="poster-content-section">
      {content}
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
    <Button className='edit'
            bsSize='xsmall'
            onClick={onClick}>
      Edit
    </Button>

  renderDeleteControl: (user, poster, onClick) ->
    <Button className='delete'
            bsSize='xsmall'
            bsStyle='link'
            onClick={onClick}>
      Delete
    </Button>
