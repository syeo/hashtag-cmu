React = require('react')

PosterMixin = require('./poster.component.mixin.cjsx')

debug = require('../debug')('poster:component')

PosterListItem = React.createClass
  displayName: 'PosterListItem'

  mixins: [PosterMixin]

  render: ->
    <div className="col-lg-3 col-md-4 col-sm-6 col-xs-12">
      <div className="poster-list-item">
        <div className="poster">
          {@renderImageSection(@props.poster)}
          {@renderTitleSection(@props.poster)}
          {@renderTagsSection(@props.poster)}
          {@renderDescriptionSection(@props.poster)}
        </div>
      </div>
    </div>

module.exports = PosterListItem