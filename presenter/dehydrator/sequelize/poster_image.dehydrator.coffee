BaseDehydrator = require('./base.dehydrator')

class PosterImageDehydrator extends BaseDehydrator

module.exports = (registry) -> new PosterImageDehydrator(registry)