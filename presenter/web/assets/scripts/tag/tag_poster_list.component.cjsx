_ = require('lodash')
React = require('react')
MasonryMixin = require('react-masonry-mixin')

PosterStore = require('../poster/poster.store')
PosterService = require('../poster/poster.service')
PosterListMixin = require('../poster/poster_list.mixin.cjsx')

debug = require('../debug')('home_page:component')

MASONRY_CONTAINER_REF = 'masonryContainer'
MASONRY_OPTIONS = {}

TagPosterList = React.createClass({
  displayName: 'TagPosterList'

  contextTypes:
    router: React.PropTypes.func

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
      posters: PosterStore.getTagPosterList(@props.tagId)
    }

  getInitialState: -> @makeStateFromStore()

  componentDidMount: ->
    debug("didmount")

    PosterStore.addChangeListener(@_onChange)
    PosterService.loadTagPosterList(@props.tagId)

  componentWillUnmount: ->
    debug("will unmount")

    PosterStore.removeChangeListener(@_onChange)

  render: -> @renderList()

  _onChange: -> @setState(@makeStateFromStore())
});

module.exports = TagPosterList;
