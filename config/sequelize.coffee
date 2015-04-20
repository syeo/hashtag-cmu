_ = require('lodash')
parseDbUrl = require("parse-database-url")

module.exports = {
  development: {
    dialect: 'sqlite',
    storage: './db/development.sqlite'
  },
  production: _.extend(
    {
      dialect: 'postgres'
    },
    parseDbUrl(process.env.DATABASE_URL || "")
  )
}