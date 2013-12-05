REPORTER = spec
TESTS = test/*.coffee test/**/*.coffee test/**/**/*.coffee

test:
	@NODE_ENV=test NODE_PATH=./app/controllers ./node_modules/.bin/mocha \
    --compilers coffee:coffee-script \
    --require coffee-script \
    --reporter $(REPORTER) \
    --ui tdd \
    $(TESTS)

.PHONY: test
