registry = require('../../../../../system/registry')

tagRepository = registry.instance().tagRepository

module.exports =
  fetchTag: (tagIdLens, key) ->
    (req, res, next) ->
      tagId = tagIdLens.get(req)
      tagRepository.findById(tagId)
        .then((tag) ->
          if tag
            req[key] = tag
            next()
          else
            res.status(404).json({message: 'Not Found'})
        )
        .done()
