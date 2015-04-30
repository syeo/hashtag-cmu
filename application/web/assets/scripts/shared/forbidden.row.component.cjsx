React = require('react')

ForbiddenRow = React.createClass
  displayName: 'ForbiddenRow'

  render: ->
    <div className='row'>
      <div className='col-lg-12 col-md-12 col-sm-12 col-xs-12'>
        Forbidden
      </div>
    </div>

module.exports = ForbiddenRow
