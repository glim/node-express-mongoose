#!
# * Module dependencies.
# 
express = require("express")
mongoStore = require("connect-mongo")(express)
helpers = require("view-helpers")
pkg = require("../package")
flash = require("connect-flash")
env = process.env.NODE_ENV or "development"

#!
# * Expose
# 
module.exports = (app, config, passport) ->
  
  # Add basic auth for staging
  if env is "staging"
    app.use express.basicAuth((user, pass) ->
      "username" is user and "password" is pass
    )
    app.use (req, res, next) ->
      delete req.user  if req.remoteUser and req.user and not req.user._id
      next()

  app.set "showStackError", true
  
  # use express favicon
  app.use express.favicon()
  app.use express.static(config.root + "/public")
  app.use express.logger("dev")
  
  # views config
  app.set "views", config.root + "/app/views"
  app.set "view engine", "jade"
  app.configure ->
    
    # bodyParser should be above methodOverride
    app.use express.bodyParser()
    app.use express.methodOverride()
    
    # cookieParser should be above session
    app.use express.cookieParser()
    app.use express.session(
      secret: pkg.name
      store: new mongoStore(
        url: config.db
        collection: "sessions"
      )
    )
    
    # Passport session
    app.use passport.initialize()
    app.use passport.session()
    
    # Flash messages
    app.use flash()
    
    # expose pkg and node env to views
    app.use (req, res, next) ->
      res.locals.pkg = pkg
      res.locals.env = env
      next()

    
    # View helpers
    app.use helpers(pkg.name)
    
    # adds CSRF support
    if process.env.NODE_ENV isnt "test"
      app.use express.csrf()
      
      # This could be moved to view-helpers :-)
      app.use (req, res, next) ->
        res.locals.csrf_token = req.csrfToken()
        next()

    
    # routes should be at the last
    app.use app.router
    
    # custom error handler
    app.use (err, req, res, next) ->
      return next()  if err.message and (~err.message.indexOf("not found") or (~err.message.indexOf("Cast to ObjectId failed")))
      console.error err.stack
      res.status(500).render "500"

    app.use (req, res, next) ->
      res.status(404).render "404",
        url: req.originalUrl



  
  # development specific stuff
  app.configure "development", ->
    app.locals.pretty = true

  
  # staging specific stuff
  app.configure "staging", ->
    app.locals.pretty = true

