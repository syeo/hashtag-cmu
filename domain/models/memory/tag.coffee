RandomColor = require('just.randomcolor')

BaseModel = require('./base')

class Tag extends BaseModel
  constructor: (dataValue = {}) ->
    dataValue.color ||= (new RandomColor).toHex().toCSS()
    super(dataValue)

module.exports = Tag