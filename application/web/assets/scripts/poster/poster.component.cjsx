React = require('react')

PosterMixin = require('./poster.component.mixin.cjsx')
PosterStore = require('./poster.store')
PosterService = require('./poster.service')

debug = require('../debug')('poster:component')

Poster = React.createClass
  displayName: 'Poster'

  statics:
    fetchData: (params, query) ->
      PosterService.loadPoster(params.posterId)

  mixins: [PosterMixin]

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

  render: ->
    rows = []

    if @state.poster?
      rows.push(
        <div className='row' key="poster">
          <div className='col-lg-6 col-md-6 col-sm-12 col-xs-12'>
            <div className="poster">
              {@renderImageSection(@state.poster)}
            </div>
          </div>
          <div className='col-lg-6 col-md-6 col-sm-12 col-xs-12'>
            <div className="poster">
              {@renderTitleSection(@state.poster)}
              {@renderTagsSection(@state.poster)}
              {@renderDescriptionSection(@state.poster)}
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

module.exports = Poster