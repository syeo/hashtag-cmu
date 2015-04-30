React = require('react')
Lens = require('data-lens')
ReactBootstrap = require('react-bootstrap')

PosterMixin = require('./poster.component.mixin.cjsx')
PosterStore = require('./poster.store')
PosterService = require('./poster.service')
PosterForm = require('./poster.form.component.cjsx')
LoadingRow = require('../shared/loading.row.component.cjsx')
ForbiddenRow = require('../shared/forbidden.row.component.cjsx')
UserStore = require('../user/user.store')
Promise = require('../promise')
PosterImageService = require('../poster_image/poster_image.service')

debug = require('../debug')('poster:edit:component')

{ButtonToolbar, Button, Input} = ReactBootstrap

PosterEdit = React.createClass
  displayName: 'PosterEdit'

  statics:
    fetchData: (params, query) ->
      Promise.all([
        PosterService.loadPoster(params.posterId)
      ])

  propTypes:
    user: React.PropTypes.object.isRequired
    posterId: React.PropTypes.number.isRequired

  contextTypes:
    router: React.PropTypes.func

  getPosterFromStore: () -> PosterStore.getPoster(@props.posterId)

  getInitialState: ->
    {
      poster: @getPosterFromStore()
    }

  handlePosterChange: ->
    @setState(Lens.key('poster').set(@getPosterFromStore(), @state))

  componentDidMount: ->
    PosterStore.addChangeListener(@handlePosterChange)

  componentWillUnmount: ->
    PosterStore.removeChangeListener(@handlePosterChange)

  handleSubmit: (poster) ->
    PosterService.updatePoster(poster).bind(@).then(() ->
      @context.router.transitionTo('poster-show', {posterId: @props.posterId})
    )

  handleDeleteButtonClick: () ->
    PosterService.deletePoster(@state.poster).bind(@).then(() ->
      @context.router.transitionTo('home')
    )

  render: () ->
    if @state.poster
      poster = @state.poster
      user = @props.user

      if user.id == poster.owner.id
        props =
          poster: poster
          user: user
          onSubmit: @handleSubmit
          onDelete: @handleDeleteButtonClick

        row = <PosterForm {...props} />
      else
        row = <ForbiddenRow />
    else
      row = <LoadingRow />

    <div className="container single-poster">
      {row}
    </div>

module.exports = PosterEdit