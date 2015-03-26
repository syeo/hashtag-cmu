gulp = require('gulp')
path = require('path')
_ = require('lodash')
plugins = require('gulp-load-plugins')()

config = require('./config/config')

gulp.task('serve:web:dev', ['build'], ->
  plugins.nodemon({
    script: 'presenter/web/index.coffee'
    ext: 'coffee, js, jade'
    ignore: [
      'node_modules/'
      'bower_components/'
      'lib/'
      'presenter/web/asset'
      'presenter/web/public'
      'presenter/web/build'
      'presenter/web/template'
    ]
    env:
      NODE_ENV: 'development'
      DEBUG: "#{config.debugPrefix}*"
  }).on('restart', (event) ->
    console.log "nodemon got restart #{event}"
    setTimeout(() ->
      console.log "triggering livereload"
      plugins.livereload.reload()
      console.log "triggered livereload"
    , 2000)
    # console.log "nodemon restarted"
    # plugins.livereload()
  )
)

gulp.task('build:js', ->
  gulp.src('./presenter/web/asset/script/application.coffee')
    .pipe(plugins.webpack(require('./webpack.config')))
    .pipe(gulp.dest('./presenter/web/build/asset/script/'))
    .pipe(plugins.livereload())
)

gulp.task('build:css', ->
  gulp.src('./presenter/web/asset/style/application.less')
    .pipe(plugins.sourcemaps.init())
    .pipe(plugins.less({
      paths: [
        path.join(__dirname, 'node_modules'),
        path.join(__dirname, 'bower_components'),
        path.join(__dirname, 'lib/styles')
      ]
    }))
    .pipe(plugins.sourcemaps.write('./'))
    .pipe(gulp.dest('./presenter/web/build/asset/style/'))
    .pipe(plugins.livereload())
)

gulp.task('watch', ->
  plugins.livereload.listen({port: config.livereload.port})

  gulp.watch([
    'lib/**/*.@(css|less)',
    'presenter/web/asset/style/**/*.@(css|less)',
  ], ['build:css'])

  gulp.watch([
    'lib/**/*.@(js|coffee)',
    'presenter/web/asset/script/**/*.@(js|coffee)',
  ], ['build:js'])

  gulp.watch([
    'presenter/web/template/**/*.jade',
  ], {}, () ->
    console.log("jade change callback called")
    plugins.livereload.reload()
  )
)

gulp.task('build', ['build:js', 'build:css'])

gulp.task('default', ['watch', 'serve:web:dev'])