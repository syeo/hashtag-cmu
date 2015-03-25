gulp = require('gulp')
path = require('path')
nodemon = require('gulp-nodemon')

gulp.task('serve:web:dev', ->
  nodemon({
    script: 'presenter/web/index.coffee'
    ext: 'coffee, js, jade'
    ignore: ['node_modules/']
    env:
      NODE_ENV: 'development'
      DEBUG: '#CMU*'
  })
)

gulp.task('default', ['serve:web:dev'])