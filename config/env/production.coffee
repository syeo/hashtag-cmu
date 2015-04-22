module.exports =
  app:
    title: '#CMU'
  port: process.env.PORT || 80
  sequelize:
    use_env_variable: 'DATABASE_URL'
