iocExtra = require "simple-ioc-extra"
path     = require "path"

module.exports = ()->
  ioc = iocExtra()

  process.env.NODE_ENV or= "development"

  settings = ioc.registerSettingsFolder path.join(__dirname, "./config")

  ioc.registerDependencies {
    "console":console
  }

  ioc.registerLibraries {
    "Promise"      : "bluebird"
    "_"            : "underscore"
    "path"         : "path"
    "express"      : "express"
    "cookieParser" : "cookie-parser"
    "bodyParser"   : "body-parser"
  }

  ioc.registerDirectories __dirname, [
    "/runtime"
  ]

  ioc