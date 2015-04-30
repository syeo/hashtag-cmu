React = require('react')
ReactBootstrap = require('react-bootstrap')

PosterMixin = require('./poster.component.mixin.cjsx')
PosterStore = require('./poster.store')
PosterService = require('./poster.service')
PosterSingleMixin = require('./poster.single.component.mixin.cjsx')
LoadingRow = require('../shared/loading.row.component.cjsx')
UserStore = require('../user/user.store')

debug = require('../debug')('poster:show:component')

{ButtonToolbar} = ReactBootstrap

PosterShow = React.createClass
  displayName: 'PosterShow'

  statics:
    fetchData: (params, query) ->
      PosterService.loadPoster(params.posterId)

  mixins: [PosterMixin, PosterSingleMixin]

  propTypes:
    user: React.PropTypes.object.isRequired
    posterId: React.PropTypes.number.isRequired

  contextTypes:
    router: React.PropTypes.func

  makeStateFromStore: ->
    {
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

  renderControls: () ->
    poster = @state.poster
    user = @props.user
    <ButtonToolbar>
      {@renderEditControl(user, poster, @handleEditButtonClick)}
      {@renderDeleteControl(user, poster, @handleDeleteButtonClick)}
    </ButtonToolbar>


  render: ->
    if @state.poster
      poster = @state.poster
      user = @props.user

      delegates =
        poster: poster
        renderImageSection: _.partial(@renderImageSection, poster)
        renderTitleSection: _.partial(@renderTitleSection, poster)
        renderTagsSection: _.partial(@renderTagsSection, poster)
        renderDescriptionSection: _.partial(@renderDescriptionSection, poster)

      if poster.owner.id == user.id
        delegates.renderControls = @renderControls

      row = @renderPoster(delegates)
    else
      row = <LoadingRow />

    <div className="container single-poster">
      {row}
    </div>

module.exports = PosterShow