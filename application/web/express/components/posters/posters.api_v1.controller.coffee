_ = require('lodash')
Lens = require('data-lens')

debug = require('../../../../../system/debug')('web:controller:api:v1:posters')
registry = require('../../../../../system/registry')
Promise = require('../../../../../system/promise')

PAGE_SIZE = 30

posterRepository = registry.instance().posterRepository
posterDehydrator = registry.instance().posterDehydrator
tagRepository = registry.instance().tagRepository
Tag = registry.instance().Tag

module.exports =
  list: (req, res) ->
    debug('api.v1.poster.list called')
    debug(req.query)

    options =
      pageSize: PAGE_SIZE

    if req.query.filter?
      options.filter = _.pick(req.query.filter, ['tag'])

    posterRepository
      .findRecent(options)
      .then(posterDehydrator.list)
      .then((posters) -> res.json({posters: posters}))
      .done()

  get: (req, res) ->
    debug('api.v1.poster.get called')

    posterRepository
      .findById(req.params.posterId)
      .then(posterDehydrator.whole)
      .then((poster) -> res.json({poster: poster}))
      .done()

  delete: (req, res) ->
    debug('api.v1.poster.delete called')

    posterRepository
      .findById(req.params.posterId)
      .then((poster) -> poster.set('deleted', true))
      .then((poster) -> posterRepository.save(poster))
      .then(res.json({message: 'OK'}))
      .done()

  update: (req, res) ->
    debug('api.v1.poster.update called')

    newPosterData = req.body.poster

    posterRepository
      .findById(req.params.posterId)
      .then((poster) ->
        Promise.all([
          Promise.all(_.map(
            _.filter(newPosterData.tags, (tag) -> !tag.id?)
            (tag) -> tagRepository.save(Tag.build(tag))
          ))
          tagRepository.findAllByIds(
            _.compact(_.map(newPosterData.tags, (tag) -> tag.id))
          )
        ])
          .spread((newTags, existingTags) ->
            debug(newTags)
            debug(existingTags)
            newTags.concat(existingTags)
          )
          .then((tags) ->
            debug(tags)
            debug(poster.setTags)
            poster.setTags(tags)
          )
          .then(() -> poster)
      )
      .then((poster) ->
        _.each(['title', 'description'], (key) ->
          if _.has(newPosterData, key)
            poster.set(key, newPosterData[key])
        )
        return poster
      )
      .then((poster) -> posterRepository.save(poster))
      .then(posterDehydrator.whole)
      .then((poster) -> res.json({poster: poster}))
      .done()
