_ = require('lodash')
React = require('react')

HomePosterList = require('../home/home.poster_list.component.cjsx')
PosterService = require('../poster/poster.service')

debug = require('../debug')('home_page:component')

# LIST_KEY = 'HOME'

HomePage = React.createClass({
  displayName: 'HomePage'

  statics:
    fetchData: (params, query) ->
      HomePosterList.fetchData(params, query)

  render: ->
    <div className='home-page'>
      <HomePosterList />
    </div>

  _onChange: -> @setState(@makeStateFromStore())
})

module.exports = HomePage
