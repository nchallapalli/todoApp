injector = require "./injector"


injector().inject (WebServer)->

  WebServer.start()