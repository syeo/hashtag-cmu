registry = require('../../../../../system/registry')

posterRepository = registry.instance().posterRepository

module.exports =
  fetchPoster: (posterIdLens, key) ->
    (req, res, next) ->
      posterId = posterIdLens.get(req)
      posterRepository.findById(posterId)
        .then((poster) ->
          if poster
            req[key] = poster
            next()
          else
            res.status(404).json({message: 'Not Found'})
        )
        .done()
