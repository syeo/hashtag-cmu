React = require('react')
Lens = require('data-lens')

PosterMixin = require('./poster.component.mixin.cjsx')
PosterStore = require('./poster.store')
PosterService = require('./poster.service')
TagService = require('../tag/tag.service')
Promise = require('../promise')

debug = require('../debug')('poster:edit:component')

PosterEdit = React.createClass
  displayName: 'PosterEdit'

  statics:
    fetchData: (params, query) ->
      Promise.all([
        PosterService.loadPoster(params.posterId)
        TagService.loadTagList()
      ])


  mixins: [PosterMixin]

  getPosterFromStore: () -> PosterStore.getPoster(@props.posterId)

  getInitialState: ->
    {
      poster: @getPosterFromStore()
      editing: true
    }

  componentDidMount: ->
    PosterStore.addChangeListener(@handlePosterChange)

  componentWillUnmount: ->
    PosterStore.removeChangeListener(@handlePosterChange)

  handlePosterChange: ->
    @setState(Lens.key('poster').set(@getPosterFromStore(), @state))

  toggleEditing: () ->
    @setState(Lens.key('editing').set(!@state.editing, @state))

  makePosterFromRefs: () ->
    {
      images: @state.poster.images
      title: @state.poster.title
      description: @state.poster.description
      tags: @state.poster.tags
    }

  updatePosterByRefs: () ->
    @setState(Lens.key('poster').set(@makePosterFromRefs(), @state))

  renderEdit: () ->

  renderPreview: () ->

  render: ->
    rows = []

    if @state.poster?
      if @state.editing
        titleSection = @renderTitleEditSection(
          @state.poster,
          {
            type: 'text'
            name: 'title'
            label: 'Title'
            ref: 'titleInput'
          }
        )
        tagsSection = @renderTagsEditSection(
          @state.poster,
          {
            type: 'text'
            name: 'tags'
            label: 'Tags'
            ref: 'tagsInput'
          }
        )
        descriptionSection = @renderDescriptionEditSection(
          @state.poster,
          {
            type: 'text'
            name: 'description'
            label: 'Description'
            ref: 'descriptionInput'
          }
        )
      else
        titleSection = @renderTitleSection(@state.poster)
        tagsSection = @renderTagsSection(@state.poster)
        descriptionSection = @renderDescriptionSection(@state.poster)

      rows.push(
        <div className='row' key="poster">
          <div className='col-lg-6 col-md-6 col-sm-12 col-xs-12'>
            <div className="poster">
              {@renderImageSection(@state.poster)}
            </div>
          </div>
          <div className='col-lg-6 col-md-6 col-sm-12 col-xs-12'>
            <div className="poster">
              {titleSection}
              {tagsSection}
              {descriptionSection}
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

    <div className="container single-poster">
      {rows}
    </div>

module.exports = PosterEdit