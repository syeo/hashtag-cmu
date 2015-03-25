BaseDehydrator = require('./base_dehydrator')

class PosterImageDehydrator extends BaseDehydrator

module.exports = (registry) -> new PosterImageDehydrator(registry)