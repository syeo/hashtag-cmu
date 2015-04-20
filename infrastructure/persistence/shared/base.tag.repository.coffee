class BaseTagRepository
  findAllByPoster: (poster) => @findAllByPosterId(poster.get('id'))
  findAllByPosterId: (posterId) -> throw new Error("Method not implemented")

module.exports = BaseTagRepository
