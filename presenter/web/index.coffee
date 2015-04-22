chalk = require('chalk')
fs = require('fs')
express = require('express')

initializers = require('../../config/initializers')

registry = require('../../system/registry')
config = require('../../config/config')

module.exports = initializers.express(express(), config)
