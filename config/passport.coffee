
#!
# * Module dependencies.
# 
mongoose = require("mongoose")
LocalStrategy = require("passport-local").Strategy
User = mongoose.model("User")

###
Expose
###
module.exports = (passport, config) ->
  
  # serialize sessions
  passport.serializeUser (user, done) ->
    done null, user.id

  passport.deserializeUser (id, done) ->
    User.findOne
      _id: id
    , (err, user) ->
      done err, user


  
  # use local strategy
  passport.use new LocalStrategy(
    usernameField: "email"
    passwordField: "password"
  , (email, password, done) ->
    options = criteria:
      email: email

    User.load options, (err, user) ->
      return done(err)  if err
      unless user
        return done(null, false,
          message: "Unknown user"
        )
      unless user.authenticate(password)
        return done(null, false,
          message: "Invalid password"
        )
      done null, user

  )
