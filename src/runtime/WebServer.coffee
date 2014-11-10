module.exports = (express, cookieParser, bodyParser, config, path, console)->

  new class WebServer

    constructor:()->
      @app = express()

      @app.set "port", process.env.PORT || config.Port
      @app.set('views', path.join(__dirname, 'views'))
      @app.set('view engine', 'jade')

      @app.use(bodyParser.json())
      @app.use(bodyParser.urlencoded({ extended: false }))
      @app.use(cookieParser())
      @app.use(express.static(path.join(__dirname, 'public')))

      @app.use '/', (req, res)->
        res.send("Hello")

      @app.use (req, res, next)->
          err = new Error('Not Found')
          err.status = 404;
          next(err)


    start:(next=->)->
      @server = @app.listen @app.get('port'), ()->
        console.log "Express server listening on port #{config.Port}"
        next()

    stop:(next=->)->
      if @server?.close
        @server?.close(next)
      else
        next()

