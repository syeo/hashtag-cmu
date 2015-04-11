path = require("path")
webpack = require("webpack")

config = require('./config/config')

plugins = []

if process.env.NODE_ENV == 'production'
  plugins.push(new webpack.optimize.UglifyJsPlugin(
    mangle: true
  ))

module.exports = {
  # This is the main file that should include all other JS files
  entry: './presenter/web/assets/scripts/application.cjsx'
  target: "web"
  debug: true
  devtool: 'source-map'
  # We are watching in the gulp.watch, so tell webpack not to watch
  watch: false
  # watchDelay: 300
  output:
    path: path.join(__dirname, 'presenter', 'web', 'build', 'asset', 'script')
    publicPath: "/static/"
    # filename: "main-[hash].js"
    filename: "application.js"
    chunkFilename: "[chunkhash].js"

  resolve:
    # Tell webpack to look for required files in bower and node
    modulesDirectories: [
      'bower_components'
      'node_modules'
      'lib/script'
    ]
    extensions: ['', '.js', '.coffee']
    root: __dirname
    alias: {
      'angular': "angular/angular.js",
      'angular-deckgrid': "angular-deckgrid/angular-deckgrid.js",
      'angular-bootstrap': "angular-bootstrap/ui-bootstrap-tpls.js",
    },

  module:
    loaders: [
      { test: /\.gif/, loader: "url-loader?limit=10000&minetype=image/gif" }
      { test: /\.jpg/, loader: "url-loader?limit=10000&minetype=image/jpg" }
      { test: /\.png/, loader: "url-loader?limit=10000&minetype=image/png" }
      { test: /\.coffee/, loader: 'coffee-loader' }
      { test: /\.html/,  loader: "raw-loader" }
      { test: /\.json$/,  loader: "json-loader" }
      { test: /\.cjsx$/, loaders: ['coffee', 'cjsx']}
   ]
    noParse: [
      /\.min\.js/
      /[\/\\]angular\.js$/
      /[\/\\]angular-deckgrid\.js$/
      /[\/\\]ui-bootstrap-tpls\.js$/
    ]

  plugins: plugins
}