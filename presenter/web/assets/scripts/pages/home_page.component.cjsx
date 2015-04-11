_ = require('lodash')
React = require('react')

HomePosterList = require('../home/home_poster_list.component.cjsx')

debug = require('../debug')('tag_page:component')

# LIST_KEY = 'HOME'

HomePage = React.createClass({
  displayName: 'HomePage'

  render: ->
    <div className='home-page'>
      <HomePosterList />
    </div>

  _onChange: -> @setState(@makeStateFromStore())
});

module.exports = HomePage;
