React = require('react')
Lens = require('data-lens')
ReactBootstrap = require('react-bootstrap')
classNames = require('classnames')

PosterMixin = require('./poster.component.mixin.cjsx')
PosterService = require('./poster.service')
PosterSingleMixin = require('./poster.single.component.mixin.cjsx')
TagStore = require('../tag/tag.store')
UserStore = require('../user/user.store')
Promise = require('../promise')
PosterImageService = require('../poster_image/poster_image.service')

debug = require('../debug')('poster:form:component')

{ButtonToolbar, Button, Input} = ReactBootstrap

PosterForm = React.createClass
  displayName: 'PosterForm'

  statics:
    fetchData: (params, query) ->
      Promise.all([
        TagService.loadTagList()
      ])

  propTypes:
    poster: React.PropTypes.object.isRequired
    user: React.PropTypes.object.isRequired
    onSubmit: React.PropTypes.func.isRequired
    delete: React.PropTypes.bool

  getDefaultProps: () ->
    {
      delete: false
    }

  mixins: [PosterMixin, PosterSingleMixin]

  contextTypes:
    router: React.PropTypes.func

  getInitialState: ->
    {
      poster: @props.poster
      editing: true
    }

  handleTogglePreviewClick: () ->
    @setState(Lens.key('editing').set(!@state.editing, @state))

  handleSubmit: (e) ->
    e.preventDefault()
    @props.onSubmit(@state.poster)

  parseTagsInput: () ->
    tagsTextArr = _.map(
      @refs.tagsInput.getValue().split(",")
      (tagText) -> tagText.trim()
    )
    tagsArr = _.map(
      tagsTextArr
      (tagText) ->
        TagStore.getByName(tagText) || {
          name: tagText
        }
    )

  makePosterFromRefs: () ->
    poster = @state.poster
    poster = Lens.key('title').set(@refs.titleInput.getValue(), poster)
    poster = Lens.key('description').set(@refs.descriptionInput.getValue(), poster)
    poster = Lens.key('tags').set(@parseTagsInput(), poster)
    return poster

  handleInputChange: () ->
    @setState(Lens.key('poster').set(@makePosterFromRefs(), @state))

  handleCancelClick: () ->
    unless @context.router.goBack()
      @context.router.transitionTo('home')

  handleImageInputChange: (e) ->
    e.preventDefault()
    file = _.first(Array.prototype.slice.call(e.target.files))
    if file?
      debug(file)
      PosterImageService.upload(file).bind(@).then((posterImage) ->
        debug(posterImage)
        @setState(Lens.path('poster.images').set([posterImage], @state))
      )

  handleImageClick: () ->
    debug("image CLicked")
    if @state.editing
      debug("image CLicked")
      @refs.imageInput.getDOMNode().click()

  renderSaveControl: () ->
    user = @props.user
    poster = @state.poster
    <Button bsStyle='primary'
            bsSize='xsmall'
            onClick={@handleSubmit}>
      Save
    </Button>

  renderTogglePreviewControl: (user, poster, onClick, text) ->
    <Button className='preview'
            bsSize='xsmall'
            onClick={onClick}>
      {text}
    </Button>

  renderCancelControl: (user, poster, onClick) ->
    <Button className='cancel'
            bsSize='xsmall'
            onClick={@handleCancelClick}>
      Cancel
    </Button>

  renderControls: () ->
    poster = @state.poster
    user = @props.user

    buttons = []

    buttons.push(@renderSaveControl(user, poster, @handleSubmit))
    buttons.push(
      @renderTogglePreviewControl(
        user
        poster
        @handleTogglePreviewClick
        if @state.editing then 'Preview' else 'Edit'
      )
    )
    buttons.push(
      @renderCancelControl(user, poster, @handleCancelClick)
    )
    if @props.onDelete
      buttons.push(@renderDeleteControl(user, poster, @props.onDelete))

    <ButtonToolbar>
      {buttons}
    </ButtonToolbar>

  renderImageInputSection: () ->
    poster = @state.poster
    <div className="poster-image-section">
      <input className='hidden'
             type='file'
             ref='imageInput'
             onChange={@handleImageInputChange} />
      <img className="poster-image"
           src={@getImageUrl(poster)}
           onClick={@handleImageClick} />
    </div>

  renderTitleInputSection: () ->
    poster = @state.poster
    <div className="poster-content-section">
      <Input className="poster-title"
             value={poster.title}
             type='text'
             label='Title'
             ref='titleInput'
             onChange={@handleInputChange} />
    </div>

  renderTagsInputSection: () ->
    poster = @state.poster
    tagsText = _.map(poster.tags, (tag) -> tag.name).join(", ").trim()
    <div className="poster-content-section">
      <Input className="poster-tags"
             value={tagsText}
             type='text'
             name='tags'
             label='Tags'
             ref='tagsInput'
             onChange={@handleInputChange} />
    </div>

  renderDescriptionInputSection: () ->
    poster = @state.poster
    <div className="poster-content-section">
      <Input className="poster-description"
             value={poster.description}
             type='text'
             name='description'
             label='Description'
             ref='descriptionInput'
             onChange={@handleInputChange} />
    </div>

  render: ->
    rows = []

    debug("started rendering")

    poster = @state.poster
    user = @props.user

    if @state.editing
      delegates =
        poster: poster
        renderImageSection: @renderImageInputSection
        renderTitleSection: @renderTitleInputSection
        renderTagsSection: @renderTagsInputSection
        renderDescriptionSection: @renderDescriptionInputSection
        renderControls: @renderControls
    else
      delegates =
        poster: poster
        renderImageSection: _.partial(@renderImageSection, poster)
        renderTitleSection: _.partial(@renderTitleSection, poster)
        renderTagsSection: _.partial(@renderTagsSection, poster)
        renderDescriptionSection: _.partial(@renderDescriptionSection, poster)
        renderControls: _.partial(@renderControls, user, poster)

    <div className="container single-poster">

      <form className='poster-form'
            onSubmit={@props.onSubmit}>
        {@renderPoster(delegates)}
      </form>
    </div>

module.exports = PosterForm