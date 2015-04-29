uuid = require('node-uuid')

class BasePosterImageService
  uploadFile: (file, options) -> throw new Error('Method not implemented')
  createFilename: () -> uuid.v4()

module.exports = BasePosterImageService