module.exports = (base, mixins...) ->
  class Mixed extends base

  for mixin in mixins
    for name, method of mixin::
      Mixed::[name] = method

  Mixed