
###
Module dependencies
###
express = require("express")
passport = require("passport")
env = process.env.NODE_ENV or "development"
config = require("./config/config")[env]
mongoose = require("mongoose")
fs = require("fs")
require "express-namespace"
mongoose.connect config.db

# Bootstrap models
fs.readdirSync(__dirname + "/app/models").forEach (file) ->
  require __dirname + "/app/models/" + file  if ~file.indexOf(".coffee")


# Bootstrap passport config
app = express()
require("./config/passport") passport, config 

# Bootstrap application settings
require("./config/express") app, config, passport

# Bootstrap routes
require("./config/routes") app, passport

# Start the app by listening on <port>
port = process.env.PORT or 3000
app.listen port
console.log "Express app started on port " + port

# Expose app
module.exports = app
