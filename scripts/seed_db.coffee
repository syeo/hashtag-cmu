_ = require('lodash')

registry = require('../config/registry')()

postersData = require('../fixtures/posters.json')
posterImagesData = require('../fixtures/poster_images.json')
tagsData = require('../fixtures/tags.json')
posterTagsData = require('../fixtures/poster_tags.json')

seedPosters = () ->
  registry.infrastructure.persistence.posterRepository.bulkCreate(postersData)

seedPosterImages = () ->
  registry.infrastructure.persistence.posterImageRepository.bulkCreate(posterImagesData)

seedTags = () ->
  registry.infrastructure.persistence.tagRepository.bulkCreate(tagsData)

seedPosterTags = () ->
  registry.infrastructure.persistence.posterTagRepository.bulkCreate(posterTagsData)


progress = seedPosters()
  .then(seedPosterImages)
  .then(seedTags)
  .then(seedPosterTags)
  .catch((errors) ->
    throw errors
  )



# progress.done(() ->
#   process.exit()
# )