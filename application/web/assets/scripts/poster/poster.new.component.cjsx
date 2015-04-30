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

PosterNew = React.createClass
  displayName: 'PosterNew'

  contextTypes:
    router: React.PropTypes.func

  propTypes:
    user: React.PropTypes.object.isRequired

  handleSubmit: (poster) ->
    debug("handle submit")
    PosterService.createPoster(poster).bind(@).then((poster) ->
      @context.router.transitionTo('poster-show', {posterId: poster.id})
    )

  render: () ->
    props =
      poster:
        title: ''
        description: ''
        owner: @props.user
        images: []
        tags: []
      user: @props.user
      onSubmit: @handleSubmit

    <div className="container single-poster">
      <PosterForm {...props} />
    </div>

module.exports = PosterNew