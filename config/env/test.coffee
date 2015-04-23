module.exports =
  app:
    title: '#CMU - test'
  livereload:
    host: 'localhost'
    port: 35729
  sequelize:
    dialect: 'sqlite',
    storage: ':memory:'
  session:
    secret: 'secret'
    modelName: 'Session'
