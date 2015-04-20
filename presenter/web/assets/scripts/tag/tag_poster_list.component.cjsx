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
    {
      posters: PosterStore.getTagPosterList(@getCurrentTagId())
    }

  getCurrentTagId: () ->
    PageDataStore.getParams().tagId

  getInitialState: -> @makeStateFromStore()

  componentDidMount: ->
    debug("didmount")

    PosterStore.addChangeListener(@_onPosterChange)
    PageDataStore.addChangeListener(@_onPageDataChange)

    debug(@state)

    if @getCurrentTagId()?
      PosterService.loadTagPosterList(@getCurrentTagId())

  componentWillUnmount: ->
    debug("will unmount")

    PosterStore.removeChangeListener(@_onPosterChange)
    PageDataStore.removeChangeListener(@_onPageDataChange)

  render: -> @renderList()

  _onPosterChange: ->
    @setState(@makeStateFromStore())

  _onPageDataChange: ->
    tagId = @getCurrentTagId()
    if tagId?
      PosterService.loadTagPosterList(tagId)
})

module.exports = TagPosterList
