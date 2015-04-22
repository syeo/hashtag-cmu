registry = require('../system/registry')

app = registry.instance().webAppFactory.create()
registry.instance().webAppService.run(app)
