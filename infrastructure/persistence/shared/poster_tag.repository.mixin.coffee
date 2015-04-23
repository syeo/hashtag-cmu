class TagRepositoryMixin
  findAllByPoster: (poster) => @findAllByPosterId(poster.get('id'))
  findAllByPosterId: (posterId) -> throw new Error("Method not implemented")
  findAllByTag: (tag) => @findAllByTagId(tag.get('id'))
  findAllByTagId: (tagId) -> throw new Error("Method not implemented")

module.exports = TagRepositoryMixin
