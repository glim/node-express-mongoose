
#!
# * Module dependencies.
# 
mongoose = require("mongoose")
#LocalStrategy = require("passport-local").Strategy
TwitterStrategy = require('passport-twitter').Strategy
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

  passport.use new TwitterStrategy(
    consumerKey: "BwIBaGqlHBSuwghEiHHZg"
    consumerSecret: "pe1XtaM0GAppeXfSKcGbCiJCDIVyKysklFFnrzA"
    callbackURL: "http://vasdf.jameson.cc/auth/twitter/callback"
  , (token, tokenSecret, profile, done) ->
    #console.log profile
    User.findOne {twitterId: profile.id}, (err,user) ->
      return done(err) if err

      if user
        done null, user
      else
        console.log 'creating user'
        user = new User twitterId: profile.id, twitterToken: token, twitterSecret: tokenSecret, twitterProfile: profile
        user.save (err) ->
          done err, user
    return
  )
