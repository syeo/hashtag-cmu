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
  cloudinary:
    cloud_name: 'hol3m5cfg'
    api_key: '234738264158186'
    api_secret: 'ZQU7WU1NM36cgaWI36WGqLyGalY'
    private_cdn: false
    secure_distribution: null