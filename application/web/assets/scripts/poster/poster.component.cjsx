React = require('react')

PosterMixin = require('./poster.component.mixin.cjsx')
PosterStore = require('./poster.store')
PosterService = require('./poster.service')
PageDataStore = require('../page/page_data.store')

debug = require('../debug')('poster:component')

debug("here")

Poster = React.createClass
  displayName: 'Poster'

  mixins: [PosterMixin]

  getCurrentPosterId: () ->
    PageDataStore.getParams().posterId

  makeStateFromStore: ->
    {
      poster: PosterStore.getPoster(@getCurrentPosterId())
    }

  getInitialState: -> @makeStateFromStore()

  componentDidMount: ->
    PosterStore.addChangeListener(@handlePosterChange)

    if @getCurrentPosterId()?
      PosterService.loadPoster(@getCurrentPosterId())

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