React = require('react')

PosterMixin = require('./poster.component.mixin.cjsx')
PosterStore = require('./poster.store')
PosterService = require('./poster.service')
UserStore = require('../user/user.store')

debug = require('../debug')('poster:show:component')

PosterShow = React.createClass
  displayName: 'PosterShow'

  statics:
    fetchData: (params, query) ->
      PosterService.loadPoster(params.posterId)

  mixins: [PosterMixin]

  contextTypes:
    router: React.PropTypes.func

  makeStateFromStore: ->
    {
      me: UserStore.getMe()
      poster: PosterStore.getPoster(@props.posterId)
    }

  getInitialState: -> @makeStateFromStore()

  componentDidMount: ->
    PosterStore.addChangeListener(@handlePosterChange)

  componentWillUnmount: ->
    PosterStore.removeChangeListener(@handlePosterChange)

  handlePosterChange: ->
    @setState(@makeStateFromStore())

  handleEditButtonClick: ->
    @context.router.transitionTo('poster-edit', {posterId: @props.posterId})

  handleDeleteButtonClick: ->
    PosterService.deletePoster(@state.poster).bind(@).then(() ->
      @context.router.transitionTo('home')
    )

  render: ->
    rows = []

    if @state.poster?
      {me, poster} = @state
      rows.push(
        <div className='row' key="poster">
          <div className='col-lg-6 col-md-6 col-sm-12 col-xs-12'>
            <div className="poster">
              {@renderImageSection(poster)}
            </div>
          </div>
          <div className='col-lg-6 col-md-6 col-sm-12 col-xs-12'>
            <div className="poster">
              {@renderTitleSection(poster)}
              {@renderTagsSection(poster)}
              {@renderDescriptionSection(poster)}
            </div>
            <div className="poster-controls">
              {@renderShowControls(me, poster, {
                onEditButtonClick: @handleEditButtonClick
                onDeleteButtonClick: @handleDeleteButtonClick
              })}
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

module.exports = PosterShow