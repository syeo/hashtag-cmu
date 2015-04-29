React = require('react')
Lens = require('data-lens')
ReactBootstrap = require('react-bootstrap')

PosterMixin = require('./poster.component.mixin.cjsx')
PosterStore = require('./poster.store')
PosterService = require('./poster.service')
TagService = require('../tag/tag.service')
TagStore = require('../tag/tag.store')
UserStore = require('../user/user.store')
Promise = require('../promise')
AuthService = require('../auth/auth.service')
PosterImageService = require('../poster_image/poster_image.service')

debug = require('../debug')('poster:edit:component')

{ButtonToolbar, Button, Input} = ReactBootstrap

PosterEdit = React.createClass
  displayName: 'PosterEdit'

  statics:
    fetchData: (params, query) ->
      Promise.all([
        PosterService.loadPoster(params.posterId)
        TagService.loadTagList()
      ])


  mixins: [PosterMixin]

  contextTypes:
    router: React.PropTypes.func

  getPosterFromStore: () -> PosterStore.getPoster(@props.posterId)

  getInitialState: ->
    {
      me: UserStore.getMe()
      poster: @getPosterFromStore()
      editing: true
    }

  componentDidMount: ->
    PosterStore.addChangeListener(@handlePosterChange)

  componentWillUnmount: ->
    PosterStore.removeChangeListener(@handlePosterChange)

  handlePosterChange: ->
    @setState(Lens.key('poster').set(@getPosterFromStore(), @state))

  handleTogglePreviewClick: () ->
    @setState(Lens.key('editing').set(!@state.editing, @state))

  handleSubmit: (e) ->
    e.preventDefault()
    PosterService.updatePoster(@state.poster).bind(@).then(() ->
      @context.router.transitionTo('poster-show', {posterId: @props.posterId})
    )

  handleDeleteButtonClick: () ->
    PosterService.deletePoster(@state.poster).bind(@).then(() ->
      @context.router.transitionTo('home')
    )

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

  renderControls: () ->
    me = @state.me
    poster = @state.poster
    <ButtonToolbar>
      {@renderSaveControl(me, poster, @handleSubmit)}
      {
        @renderTogglePreviewControl(
          me
          poster
          @handleTogglePreviewClick
          if @state.editing then 'Preview' else 'Edit'
        )
      }
      {@renderCancelControl(me, poster, @handleCancelClick)}
      {@renderDeleteControl(me, poster, @handleDeleteButtonClick)}
    </ButtonToolbar>

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

  render: ->
    rows = []

    debug("started rendering")

    if @state.poster?
      if @state.editing
        imageSection = @renderImageEditSection(
          @state.poster
          {
            className: 'hidden'
            type: 'file'
            ref: 'imageInput'
            onChange: @handleImageInputChange
          }
          {
            onClick: @handleImageClick
          }
        )
        titleSection = @renderTitleEditSection(
          @state.poster,
          {
            type: 'text'
            name: 'title'
            label: 'Title'
            ref: 'titleInput'
            onChange: @handleInputChange
          }
        )
        tagsSection = @renderTagsEditSection(
          @state.poster,
          {
            type: 'text'
            name: 'tags'
            label: 'Tags'
            ref: 'tagsInput'
            onChange: @handleInputChange
          }
        )
        descriptionSection = @renderDescriptionEditSection(
          @state.poster,
          {
            type: 'text'
            name: 'description'
            label: 'Description'
            ref: 'descriptionInput'
            onChange: @handleInputChange
          }
        )
      else
        imageSection = @renderImageSection(@state.poster)
        titleSection = @renderTitleSection(@state.poster)
        tagsSection = @renderTagsSection(@state.poster)
        descriptionSection = @renderDescriptionSection(@state.poster)

      rows.push(
        <div className='row' key="poster">
          <div className='col-lg-6 col-md-6 col-sm-12 col-xs-12'>
            <div className="poster">
              {imageSection}
            </div>
          </div>
          <div className='col-lg-6 col-md-6 col-sm-12 col-xs-12'>
            <div className="poster">
              {titleSection}
              {tagsSection}
              {descriptionSection}
            </div>
            <div className='controls'>
              {@renderControls()}
            </div>
          </div>
        </div>
      )
    else
      rows.push(
        <div className='row' key="poster-loading">
          <div className='col-lg-12 col-md-12 col-sm-12 col-xs-12'>
            LOADING
          </div>
        </div>
      )

    debug("ending rendering")

    <div className="container single-poster">
      <form className='poster-form' onSubmit={@handleSubmit}>
        {rows}
      </form>
    </div>

module.exports = PosterEdit