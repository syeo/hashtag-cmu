_ = require('lodash')
React = require('react')
MasonryMixin = require('react-masonry-mixin')

PosterStore = require('../poster/poster.store')
PosterService = require('../poster/poster.service')
PosterListMixin = require('../poster/poster_list.mixin.cjsx')

debug = require('../debug')('tag_poster_list:component')

MASONRY_CONTAINER_REF = 'masonryContainer'
MASONRY_OPTIONS = {}

TagPosterList = React.createClass({
  displayName: 'TagPosterList'

  statics:
    fetchData: (params, query) ->
      PosterService.loadTagPosterList(params.tagId)

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

  makeStateFromStore: (props) ->
    props ||= @props
    debug(props.tagId)
    {
      posters: PosterStore.getTagPosterList(props.tagId)
    }

  # getCurrentTagId: () ->

  getInitialState: -> @makeStateFromStore()

  componentDidMount: ->
    debug("didmount")

    PosterStore.addChangeListener(@_onPosterChange)

    debug(@state)

    # if @getCurrentTagId()?
    #   PosterService.loadTagPosterList(@getCurrentTagId())

  componentWillUnmount: ->
    debug("will unmount")

    PosterStore.removeChangeListener(@_onPosterChange)

  componentWillReceiveProps: (nextProps) ->
    debug("will receive Props")

    @setState(@makeStateFromStore(nextProps))

  render: -> @renderList()

  _onPosterChange: ->
    @setState(@makeStateFromStore())

})

module.exports = TagPosterList
