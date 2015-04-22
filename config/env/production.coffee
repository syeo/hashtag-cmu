module.exports =
  app:
    title: '#CMU'
  webServer:
    port: process.env.PORT || 80
  sequelize:
    use_env_variable: 'DATABASE_URL'
  session:
    secret: 'secret'
    modelName: 'Session'
