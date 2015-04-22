module.exports =
  app:
    title: '#CMU - dev'
  livereload:
    host: 'localhost'
    port: 35729
  sequelize:
    dialect: 'sqlite',
    storage: './db/development.sqlite'
  session:
    secret: 'secret'
    modelName: 'Session'
