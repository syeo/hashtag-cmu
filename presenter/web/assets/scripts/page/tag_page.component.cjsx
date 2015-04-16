_ = require('lodash')
React = require('react')

TagPosterList = require('../tag/tag_poster_list.component.cjsx')

debug = require('../debug')('tag_page:component')

# LIST_KEY = 'HOME'

TagPage = React.createClass({
  displayName: 'TagPage'

  contextTypes:
    router: React.PropTypes.func

  render: ->
    <div className='tag-page'>
      <TagPosterList />
    </div>

  _onChange: -> @setState(@makeStateFromStore())
})

module.exports = TagPage
