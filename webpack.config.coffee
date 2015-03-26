path = require("path")
webpack = require("webpack")

module.exports = {
  # This is the main file that should include all other JS files
  entry: './presenter/web/asset/script/application.coffee'
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

  module:
    loaders: [
      { test: /\.gif/, loader: "url-loader?limit=10000&minetype=image/gif" }
      { test: /\.jpg/, loader: "url-loader?limit=10000&minetype=image/jpg" }
      { test: /\.png/, loader: "url-loader?limit=10000&minetype=image/png" }
      { test: /\.coffee/, loader: 'coffee-loader' }
    ],
    noParse: /\.min\.js/

  plugins: [
    # If you want to minify everything
    # new webpack.optimize.UglifyJsPlugin()
  ]
}