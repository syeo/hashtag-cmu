_ = require('lodash')

registry = require('../system/registry')

registry.instance().syncDb({force: true})

