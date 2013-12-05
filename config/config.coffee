
#!
# * Module dependencies.
# 
path = require("path")
rootPath = path.resolve(__dirname + "../..")

###
Expose config
###
module.exports =
  development:
    root: rootPath
    db: "mongodb://localhost/your_app_db_dev"

  test:
    root: rootPath
    db: "mongodb://localhost/your_app_db_test"

  staging:
    root: rootPath
    db: process.env.MONGOHQ_URL

  production:
    root: rootPath
    db: process.env.MONGOHQ_URL
