_ = require('lodash')

PosterListItem = require('./poster_list_item.component.cjsx')

module.exports =
  renderList: ->
    <div className="container poster-list">
      <div className='row' ref={@props.masonryContainerRef}>{
        _.map(@state.posters, (poster) ->
          <PosterListItem poster={poster} key={poster.id} />
        )
      }</div>
    </div>
