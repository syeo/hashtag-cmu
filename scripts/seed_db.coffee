_ = require('lodash')

registry = require('../system/registry')

postersData = require('../fixtures/posters.json')
posterImagesData = require('../fixtures/poster_images.json')
tagsData = require('../fixtures/tags.json')
posterTagsData = require('../fixtures/poster_tags.json')

seedPosters = () ->
  registry.innstance().posterRepository.bulkCreate(postersData)

seedPosterImages = () ->
  registry.innstance().posterImageRepository.bulkCreate(posterImagesData)

seedTags = () ->
  registry.innstance().tagRepository.bulkCreate(tagsData)

seedPosterTags = () ->
  registry.innstance().posterTagRepository.bulkCreate(posterTagsData)


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