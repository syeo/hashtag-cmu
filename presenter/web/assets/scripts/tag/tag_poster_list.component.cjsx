_ = require('lodash')
React = require('react')
MasonryMixin = require('react-masonry-mixin')

PosterStore = require('../poster/poster.store')
PosterService = require('../poster/poster.service')
PosterListMixin = require('../poster/poster_list.mixin.cjsx')
PageDataStore = require('../page/page_data.store')

debug = require('../debug')('tag_poster_list:component')

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
    tagId = PageDataStore.getParams().tagId
    {
      tagId: tagId
      posters: PosterStore.getTagPosterList(tagId)
    }

  getInitialState: -> @makeStateFromStore()

  componentDidMount: ->
    debug("didmount")

    PosterStore.addChangeListener(@_onChange)
    PageDataStore.addChangeListener(@_onPageDataChange)

    debug(@state)

    if @state.tagId?
      PosterService.loadTagPosterList(@state.tagId)

  componentWillUnmount: ->
    debug("will unmount")

    PosterStore.removeChangeListener(@_onChange)
    PageDataStore.removeChangeListener(@_onPageDataChange)

  render: -> @renderList()

  _onChange: ->
    @setState(@makeStateFromStore())

  _onPageDataChange: ->
    tagId = PageDataStore.getParams().tagId

    if tagId? and @state?.tagId != tagId
      PosterService.loadTagPosterList(tagId)

    @setState(@makeStateFromStore())
});

module.exports = TagPosterList;
