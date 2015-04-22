_ = require('lodash')
glob = require('glob')
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
session = require('express-session')

getGlobbedFiles = (globPatterns, removeRoot) ->
  # URL paths regex
  urlRegex = new RegExp('^(?:[a-z]+:)?\/\/', 'i')

  # The output array
  output = []

  # If glob pattern is array so we use each pattern in a recursive way,
  # otherwise we use glob
  if _.isArray(globPatterns)
    globPatterns.forEach((globPattern) ->
      output = _.union(output, getGlobbedFiles(globPattern, removeRoot))
    )
  else if _.isString(globPatterns)
    if urlRegex.test(globPatterns)
      output.push(globPatterns)
    else
      files = glob.sync(globPatterns)
      if removeRoot
        files = files.map((file) ->
          return file.replace(removeRoot, '')
        )
      output = _.union(output, files)

  return output

module.exports = (instance, passport, sessionStore, config) ->
  # Setting application local variables
  instance.locals.title = config.app.title
  instance.locals.description = config.app.description
  instance.locals.keywords = config.app.keywords
  instance.locals.NODE_ENV = config.NODE_ENV

  if config.NODE_ENV is 'development'
    instance.locals.livereload = config.livereload

  # Passing the request url to environment locals
  instance.use((req, res, next) ->
    res.locals.url = req.protocol + '://' + req.headers.host + req.url
    next()
  )

  # Should be placed before express.static
  instance.use(compress({
    filter: (req, res) ->
      return (/json|text|javascript|css/).test(res.getHeader('Content-Type'))
    level: 9
  }))

  # Showing stack errors
  instance.set('showStackError', true)

  # Set swig as the template engine
  instance.engine(
    config.template.ext,
    consolidate[config.template.engine]
  )

  # Set default
  instance.set('view engine', config.template.ext)
  instance.set('views', './application/web/templates')

  # Environment dependent middleware
  if config.NODE_ENV is 'development'
    # Enable logger (morgan)
    instance.use(morgan('dev'))

    # Disable views cache
    instance.set('view cache', false)

  else if config.NODE_ENV is 'production'
    instance.locals.cache = 'memory'

  # Request body parsing middleware should be above methodOverride
  instance.use(bodyParser.urlencoded({
    extended: true
  }))
  instance.use(bodyParser.json())
  instance.use(methodOverride())

  # CookieParser should be above session
  instance.use(cookieParser())

  # connect flash for flash messages
  instance.use(flash())

  # Use helmet to secure Express headers
  instance.use(helmet.xframe())
  instance.use(helmet.xssFilter())
  instance.use(helmet.nosniff())
  instance.use(helmet.ienoopen())
  instance.disable('x-powered-by')

  # Setting the express router and static folder
  instance.use(
    '/static/assets'
    express.static(path.resolve('./application/web/assets.build'))
  )
  instance.use(
    '/static'
    express.static(path.resolve('./application/web/public'))
  )
  instance.use(
    '/static/fonts'
    express.static(path.resolve('./bower_components/bootstrap/fonts'))
  )

  # Globbing routing files
  getGlobbedFiles(
    './application/web/express/components/**/*.route.@(js|coffee)'
  ).forEach(
    (routePath) ->
      require(path.resolve(routePath))(instance)
  )

  instance.use(session(
    secret: config.session.secret
    store: sessionStore
    proxy: config.session.config
    resave: false
    saveUninitialized: false
  ))

  # Assume 'not found' in the error msgs is a 404. this is somewhat silly,
  # but valid, you can do whatever you like, set properties, use instanceof etc.
  instance.use((err, req, res, next) ->
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
  instance.use((req, res) ->
    if req.accepts('html')
      res.render('home.swig', {
        req: req
      })

    else if req.accepts('json')
      res.status(404).json({
        text: 'Not Found'
      })
  )

  # Return express server instance
  return instance