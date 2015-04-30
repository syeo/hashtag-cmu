React = require('react')

LoadingRow = React.createClass
  displayName: 'LoadingRow'

  render: ->
    <div className='row'>
      <div className='col-lg-12 col-md-12 col-sm-12 col-xs-12'>
        LOADING
      </div>
    </div>

module.exports = LoadingRow
