_ = require('lodash')
React = require('react')
MasonryMixin = require('react-masonry-mixin')

PosterStore = require('../poster/poster.store')
PosterService = require('../poster/poster.service')
PosterListMixin = require('../poster/poster_list.mixin.cjsx')

debug = require('../debug')('home_poster_list:component')

MASONRY_CONTAINER_REF = 'masonryContainer'
MASONRY_OPTIONS = {}

HomePosterList = React.createClass({
  displayName: 'HomePosterList'

  getDefaultProps: ->
    {
      masonryContainerRef: MASONRY_CONTAINER_REF
    }

  mixins: [
    MasonryMixin(MASONRY_CONTAINER_REF, MASONRY_OPTIONS)
    PosterListMixin
  ]

  makeStateFromStore: () ->
    {
      posters: PosterStore.getHomePosterList()
    }

  getInitialState: -> @makeStateFromStore()

  componentDidMount: ->
    debug("didmount")

    PosterStore.addChangeListener(@_onChange)
    PosterService.loadHomePosterList()

  componentWillUnmount: ->
    debug("will unmount")

    PosterStore.removeChangeListener(@_onChange)

  render: -> @renderList()

  _onChange: -> @setState(@makeStateFromStore())
});

module.exports = HomePosterList;
