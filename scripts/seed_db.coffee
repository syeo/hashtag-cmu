_ = require('lodash')

registry = require('../config/registry')()

# poster1 = registry.domain.models.Poster.build({
#   title: 'test1 poster - title'
#   description: 'test1 poster - desc'
# })

# progress = registry.infrastructure.persistence.posterRepository.save(poster1)



# posters = null
# posterImages = null

postersData = [
  {
    title: 'poster 1 - title'
    description: 'poster 1 - description'
  }
  {
    title: 'poster 2 - title'
    description: 'poster 2 - description'
  }
  {
    title: 'poster 3 - title'
    description: 'poster 3 - description'
  }
  {
    title: 'poster 4 - title'
    description: 'poster 4 - description'
  }
  {
    title: 'poster 5 - title'
    description: 'poster 5 - description'
  }
]

posterImagesData = [
  {
    thumbnailUrl: 'http://placehold.it/20x30'
    cardUrl: 'http://placehold.it/200x300'
    originalUrl: 'http://placehold.it/600x900'
    posterId: 1
  }
  {
    thumbnailUrl: 'http://placehold.it/20x30'
    cardUrl: 'http://placehold.it/200x300'
    originalUrl: 'http://placehold.it/600x900'
    posterId: 2
  }
  {
    thumbnailUrl: 'http://placehold.it/20x30'
    cardUrl: 'http://placehold.it/200x300'
    originalUrl: 'http://placehold.it/600x900'
    posterId: 3
  }
  {
    thumbnailUrl: 'http://placehold.it/20x30'
    cardUrl: 'http://placehold.it/200x300'
    originalUrl: 'http://placehold.it/600x900'
    posterId: 4
  }
  {
    thumbnailUrl: 'http://placehold.it/20x30'
    cardUrl: 'http://placehold.it/200x300'
    originalUrl: 'http://placehold.it/600x900'
    posterId: 5
  }
]

postersArray = []
postersDictionary = {}

seedPosters = () ->
  registry.infrastructure.persistence.posterRepository.bulkCreate(postersData)

seedPosterImages = () ->
  registry.infrastructure.persistence.posterImageRepository.bulkCreate(posterImagesData)


progress = seedPosters().then(() ->
  registry.infrastructure.persistence.posterRepository.findAll()
).then((objs) ->
  postersArray = objs
  postersDictionary = _.indexBy(objs, (obj) -> obj.get('id'))
).then(seedPosterImages)



progress.done(() ->
  process.exit()
)