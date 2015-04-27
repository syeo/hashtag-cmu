_ = require('lodash')
React = require('react')

TagPosterList = require('../tag/tag_poster_list.component.cjsx')

debug = require('../debug')('tag_page:component')

# LIST_KEY = 'HOME'

TagPage = React.createClass({
  displayName: 'TagPage'

  statics:
    fetchData: (params, query) ->
      TagPosterList.fetchData(params, query)

  contextTypes:
    router: React.PropTypes.func

  render: ->
    params = @context.router.getCurrentParams()
    tagId = params.tagId
    <div className='tag-page'>
      <TagPosterList tagId={tagId}/>
    </div>

})

module.exports = TagPage
