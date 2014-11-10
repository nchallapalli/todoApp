request = require('superagent')


describe "WebServer", ->

  beforeEach (done)->
    @mockConsole =
      logs:[]
      log:(message)->
        @logs.push(message)

    injector()
      .replaceDependency("console", @mockConsole)
      .inject (@WebServer,  @config)=>
        @WebServer.start(done)

  afterEach (done)->
    @WebServer.stop(done)

  it "should exist", ->
    expect(@WebServer).to.exist

  it "/ returns 'hello'", (done)->
    request.get("http://localhost:#{@config.Port}").end (res)=>
      expect(res.text).to.equal "Hello"
      expect(@mockConsole.logs).to.deep.equal [
       'Express server listening on port 3000' ]
      done()
