
#!
# * Module dependencies
# 
mongoose = require("mongoose")
Schema = mongoose.Schema
#userPlugin = require("mongoose-user")

###
User schema
###
UserSchema = new Schema(
  twitterId:
    type: String
    default: ""

  twitterToken:
    type: String
    default: ""

  twitterSecret:
    type: String
    default: ""
  
  twitterProfile: {}
)

###
User plugin
###
#UserSchema.plugin userPlugin, {}

###
Add your
- pre-save hooks
- validations
- virtuals
###

###
Methods
###
UserSchema.method {}

###
Statics
###
UserSchema.static {}

###
Register
###
mongoose.model "User", UserSchema
