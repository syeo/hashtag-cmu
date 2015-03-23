require('./init')()

fs = require('fs')
http = require('http')
https = require('https')
express = require('express')
morgan = require('morgan')
bodyParser = require('body-parser')
compress = require('compression')
methodOverride = require('method-override')
cookieParser = require('cookie-parser')
helmet = require('helmet')
flash = require('connect-flash')
consolidate = require('consolidate')
path = require('path')

config = require('./config')

module.exports = () ->
  # Initialize express app
  app = express()

  # Setting application local variables
  app.locals.title = config.app.title
  app.locals.description = config.app.description
  app.locals.keywords = config.app.keywords

  # Passing the request url to environment locals
  app.use((req, res, next) ->
    res.locals.url = req.protocol + '://' + req.headers.host + req.url
    next()
  )

  # Should be placed before express.static
  app.use(compress({
    filter: (req, res) ->
      return (/json|text|javascript|css/).test(res.getHeader('Content-Type'))
    level: 9
  }))

  # Showing stack errors
  app.set('showStackError', true)

  # Set swig as the template engine
  app.engine(
    "server.view.#{config.templateEngine}",
    consolidate[config.templateEngine]
  )

  # Set views path and view engine
  app.set('view engine', "server.view.#{config.templateEngine}")
  app.set('views', './presenter/web/template')

  # Environment dependent middleware
  if process.env.NODE_ENV is 'development'
    # Enable logger (morgan)
    app.use(morgan('dev'))

    # Disable views cache
    app.set('view cache', false)

  else if process.env.NODE_ENV is 'production'
    app.locals.cache = 'memory'

  # Request body parsing middleware should be above methodOverride
  app.use(bodyParser.urlencoded({
    extended: true
  }))
  app.use(bodyParser.json())
  app.use(methodOverride())

  # CookieParser should be above session
  app.use(cookieParser())

  # connect flash for flash messages
  app.use(flash())

  # Use helmet to secure Express headers
  app.use(helmet.xframe())
  app.use(helmet.xssFilter())
  app.use(helmet.nosniff())
  app.use(helmet.ienoopen())
  app.disable('x-powered-by')

  # Setting the app router and static folder
  app.use(express.static(path.resolve('./public')))

  # Globbing routing files
  config.getGlobbedFiles('./presenter/web/route/**/*.@(js|coffee)').forEach(
    (routePath) ->
      require(path.resolve(routePath))(app)
  )

  # Assume 'not found' in the error msgs is a 404. this is somewhat silly,
  # but valid, you can do whatever you like, set properties, use instanceof etc.
  app.use((err, req, res, next) ->
    # If the error object doesn't exists
    if not err
      return next()

    # Log it
    console.error(err.stack)

    # Error page
    res.status(500).render('500', {
      error: err.stack
    })
  )

  # Assume 404 since no middleware responded
  app.use((req, res) ->
    res.status(404).render('404', {
      url: req.originalUrl,
      error: 'Not Found'
    })
  )

  # Return Express server instance
  return app