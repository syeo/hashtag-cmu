_ = require('lodash')

PosterListItem = require('./poster_list_item.component.cjsx')

module.exports =
  renderList: ->
    <div className="container poster-stream">
      <div className='row' ref={@props.masonryContainerRef}>{
        _.map(@state.posters, (poster) ->
          <div className="col-lg-3 col-md-4 col-sm-6 col-xs-12"
               key={poster.id}>
            <PosterListItem poster={poster}/>
          </div>
        )
      }</div>
    </div>
