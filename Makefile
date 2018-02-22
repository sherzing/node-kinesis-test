AWS_REGION = eu-west-1
ROLE_NAME = shedd-pns-lambda
FUNCTION_NAME = kinesis-testing-consumer
ROLE_ARN ?= $(shell helper/role_arn_helper.sh $(ROLE_NAME))
FUNCTION_ARN ?= $(shell helper/get_function_arn.sh kinesis-testing-consumer)
AWS_REGION = eu-west-1
AWS_PROFILE ?= stage

list:
	aws lambda list-functions \
		--region $(AWS_REGION) --profile $(AWS_PROFILE)

# needs a way to schedue the execution every 5 min

update:
	mkdir -p dist
	@npm install
	@npm run transpile
	@zip -r ./$(FUNCTION_NAME).zip * -x *.json *.zip test helper
	aws lambda update-function-code \
		--region $(AWS_REGION) \
		--function-name $(FUNCTION_NAME) \
		--zip-file fileb://$(FUNCTION_NAME).zip \
		--profile $(AWS_PROFILE)
update2:
	mkdir -p dist
	@npm install
	@npm run transpile
	@zip -r ./$(FUNCTION_NAME).zip * -x *.json *.zip test helper
	aws lambda update-function-code \
		--region $(AWS_REGION) \
		--function-name $(FUNCTION_NAME)-2 \
		--zip-file fileb://$(FUNCTION_NAME).zip \
		--profile $(AWS_PROFILE)

upload:
	mkdir -p dist
	@npm install
	@npm run transpile
	@zip -r ./$(FUNCTION_NAME).zip * -x *.json *.zip test.js
	aws lambda create-function \
		--region $(AWS_REGION) \
		--function-name $(FUNCTION_NAME) \
		--zip-file fileb://$(FUNCTION_NAME).zip \
		--handler dist/lambda_consumer.handler \
		--runtime nodejs6.10 \
		--role $(ROLE_ARN) \
		--profile $(AWS_PROFILE)
upload2:
	mkdir -p dist
	@npm install
	@npm run transpile
	@zip -r ./$(FUNCTION_NAME).zip * -x *.json *.zip test.js
	aws lambda create-function \
		--region $(AWS_REGION) \
		--function-name $(FUNCTION_NAME)-2 \
		--zip-file fileb://$(FUNCTION_NAME).zip \
		--handler dist/lambda_consumer.handler \
		--runtime nodejs6.10 \
		--role $(ROLE_ARN) \
		--profile $(AWS_PROFILE)

clean:
	rm -rf dist
	rm $(FUNCTION_NAME).zip
