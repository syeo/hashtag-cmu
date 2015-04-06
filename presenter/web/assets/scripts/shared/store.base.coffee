EventEmitter = require('events').EventEmitter
keyMirror = require('keymirror')
_ = require('lodash')

Dispatcher = require('../dispatcher')

EVENTS = keyMirror({
  CHANGE: null,
})

class StoreBase extends EventEmitter
  constructor: ->
    @dispatchToken =  Dispatcher.register(@actionHandler)

  emitChange: () => @emit(EVENTS.CHANGE)

  addChangeListener: (cb) => @on(EVENTS.CHANGE, cb)

  removeChangeListener: (cb) => @removeListener(EVENTS.CHANGE, cb)

  actionHandler: _.noop

module.exports = StoreBase