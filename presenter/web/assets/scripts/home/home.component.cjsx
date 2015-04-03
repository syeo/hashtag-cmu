React = require('react')

debug = require('../debug')('home:component')

Home = React.createClass({
  displayName: 'Home'

  render: ->
    <h1>Home 1</h1>
});

module.exports = Home;
