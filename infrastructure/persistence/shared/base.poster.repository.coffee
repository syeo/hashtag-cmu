class BasePosterRepository
  findRecent: (options = {}) -> throw new Error("Method not implemented")
  findRecentByTagId: (tagId) -> throw new Error("Method not implemented")
  findRecentByTag: (tag) => @findRecentByTagId(tag.get('id'))

module.exports = BasePosterRepository
