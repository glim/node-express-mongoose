
###
Module dependencies.
###
mongoose = require("mongoose")
passportOptions =
  failureFlash: "Invalid email or password."
  failureRedirect: "/login"


# controllers
home = require("home")

###
Expose
###
module.exports = (app, passport) ->
  app.get "/", home.index
