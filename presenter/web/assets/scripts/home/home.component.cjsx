_ = require('lodash')
React = require('react')

PosterStream = require('../poster/poster_stream.component.cjsx')
PosterStore = require('../poster/poster.store')
PosterService = require('../poster/poster.service')
PosterListItem = require('../poster/poster_list_item.component.cjsx')

debug = require('../debug')('home:component')

# LIST_KEY = 'HOME'

Home = React.createClass({
  displayName: 'Home'

  makeStateFromStore: () ->
    {
      posters: PosterStore.getPosterList()
    }

  getInitialState: -> @makeStateFromStore()

  componentDidMount: ->
    debug("home didmount")
    PosterStore.addChangeListener(@_onChange)
    PosterService.loadPosterList()

  componentWillUnmount: ->
    debug("home will unmount")
    PosterStore.removeChangeListener(@_onChange)

  renderPosters: ->
    debug("home render posters")
    debug(@state.posters)
    console.log(@state.posters)

    _.map(@state.posters, (poster) ->
      <div className="col-lg-3 col-md-4 col-sm-6 col-xs-12" key={poster.id}>
        <PosterListItem poster={poster} load={false}/>
      </div>
    )

  render: ->
    debug("home render")

    <div>
      <h1>Home </h1>
      <PosterStream>
        {@renderPosters()}
      </PosterStream>
    </div>

  _onChange: -> @setState(@makeStateFromStore())
});

module.exports = Home;
