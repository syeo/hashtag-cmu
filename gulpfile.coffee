gulp = require('gulp')
path = require('path')
_ = require('lodash')
plugins = require('gulp-load-plugins')()

config = require('./config/config')

gulp.task('serve:web:dev', ['build'], ->
  plugins.nodemon({
    script: 'scripts/web_server.coffee'
    ext: "coffee, js, #{config.template.ext}, json"
    ignore: [
      'node_modules/'
      'bower_components/'
      'lib/'
      'application/web/assets'
      'application/web/public'
      'application/web/assets.build'
      'application/web/templates'
    ]
    env:
      NODE_ENV: 'development'
      DEBUG: "#{config.debugPrefix}*"
  })
)

gulp.task('build:js', ->
  gulp.src('./application/web/assets/scripts/application.cjsx')
    .pipe(plugins.plumber({
      errorHandler: plugins.notify.onError("Error: <%= error.message %>")
    }))
    .pipe(plugins.webpack(require('./webpack.config')))
    .pipe(gulp.dest('./application/web/assets.build/scripts/'))
    .pipe(plugins.livereload())
)

gulp.task('build:css', ->
  gulp.src('./application/web/assets/styles/application.less')
    .pipe(plugins.plumber({
      errorHandler: plugins.notify.onError("Error: <%= error.message %>")
    }))
    .pipe(plugins.sourcemaps.init())
    .pipe(plugins.less({
      paths: [
        path.join(__dirname, 'node_modules')
        path.join(__dirname, 'bower_components')
        path.join(__dirname, 'lib/styles')
      ]
    }))
    .pipe(plugins.autoprefixer({
      browsers: ['last 2 versions']
      cascade: false
    }))
    .pipe(plugins.sourcemaps.write('./'))
    .pipe(gulp.dest('./application/web/assets.build/styles/'))
    .pipe(plugins.livereload())
)

gulp.task('watch', ->
  plugins.livereload.listen({port: config.livereload.port})

  gulp.watch([
    'lib/**/*.@(css|less)'
    'application/web/assets/styles/**/*.@(css|less)'
  ], ['build:css'])

  gulp.watch([
    'lib/**/*.@(js|coffee)'
    'application/web/assets/scripts/**/*.@(js|coffee|cjsx)'
  ], ['build:js'])

  gulp.watch([
    "application/web/templates/**/*.@(#{config.template.ext})"
    '.rebooted'
  ], {}, () ->
    plugins.livereload.reload()
  )
)

gulp.task('build', ['build:js', 'build:css'])

gulp.task('default', ['watch', 'serve:web:dev'])