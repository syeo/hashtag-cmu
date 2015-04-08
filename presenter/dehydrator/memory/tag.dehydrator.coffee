_ = require('lodash')

BaseDehydrator = require('./base.dehydrator')
Promise = require('../../../config/promise')

class TagImageDehydrator extends BaseDehydrator

module.exports = (registry) -> new TagImageDehydrator(registry)