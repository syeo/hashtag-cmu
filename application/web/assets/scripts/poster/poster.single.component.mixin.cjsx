React = require('react')

debug = require('../debug')('poster:single:component:mixin')

module.exports =
  renderPoster: (delegates)->
    if delegates.renderControls
      controls = <div className="poster-controls">
        {delegates.renderControls()}
      </div>
    else
      controls = []

    <div className='row' key="poster">
      <div className='col-lg-6 col-md-6 col-sm-12 col-xs-12'>
        <div className="poster">
          {delegates.renderImageSection()}
        </div>
      </div>
      <div className='col-lg-6 col-md-6 col-sm-12 col-xs-12'>
        <div className="poster">
          {delegates.renderTitleSection()}
          {delegates.renderTagsSection()}
          {delegates.renderDescriptionSection()}
        </div>
        {controls}
      </div>
    </div>
