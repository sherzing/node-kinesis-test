## Simple test producer for AWS kinesis and consumer as lambda function

This is just a quick POC project to get to know AWS Kinensis better. Maybe it's usefull for somebody.

### Requirement

* AWS cli installed and configured
* node, npm and lambda-local installed
* install the dependencies via npm install
* AWS Kinesis stream existing in your account with the name 'testing-stream'

### Producer

run with the following command:

AWS_ACCESS_KEY_ID=your_access_key AWS_SECRET_ACCESS_KEY=your_secret_key lambda-local -f producer.js -t 600

### consumer

* install consumer via make upload
  * it will use the default AWS profile in your configuration. If you want a different profile, export AWS_PROFILE=<profile name> before running make upload
* mapping to the kinesis stream needs to be set manually ATM.
* there is a 2nd consumer (the same code), just to check how the bus works with multiple consumers

### improvements

* Kinesis stream and region via env vars
