
#!
# * Module dependencies.
# 
request = require("supertest")
should = require("should")
app = require("../server")

# other stuff you want to include for tests
before (done) ->
  
  # clear db and other stuff
  done()

describe.skip "Users", ->
  describe "POST /users", ->
    it "should create a user", (done) ->
      
      # fill the test
      done()



after (done) ->
  
  # do some stuff
  done()

