_ = require('lodash')

registry = require('../system/registry')

usersData = require('../fixtures/users.json')
postersData = require('../fixtures/posters.json')
posterImagesData = require('../fixtures/poster_images.json')
tagsData = require('../fixtures/tags.json')
posterTagsData = require('../fixtures/poster_tags.json')

seedUsers = () ->
  registry.instance().userRepository.bulkCreate(usersData)

seedPosters = () ->
  registry.instance().posterRepository.bulkCreate(postersData)

seedPosterImages = () ->
  registry.instance().posterImageRepository.bulkCreate(posterImagesData)

seedTags = () ->
  registry.instance().tagRepository.bulkCreate(tagsData)

seedPosterTags = () ->
  registry.instance().posterTagRepository.bulkCreate(posterTagsData)


progress = seedUsers()
  .then(seedPosters)
  .then(seedPosterImages)
  .then(seedTags)
  .then(seedPosterTags)
  .catch((errors) ->
    throw errors
  )



# progress.done(() ->
#   process.exit()
# )