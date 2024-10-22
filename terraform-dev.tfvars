# Name of AWS Region where the resources are deployed
aws_region = "ca-central-1"
# This is the AWS region identifier (Canada Central). It defines where your resources like DynamoDB, Lambda, etc., are physically hosted.

# Name of DynamoDB Table
dynamodb_table_name = "PaymentLedger"
# This table is used to store transaction details or logs related to the payment processing system.

# Name of Lambda Function
lambda_function_name = "PaymentProcessorFunction"
# This Lambda function handles the payment processing logic, such as validating requests, charging customers, and sending responses.

# Name of API Gateway
api_gateway_name = "PaymentAPI"
# This API Gateway acts as the front-end for the payment service, receiving API requests from clients and routing them to the appropriate backend resources like the Lambda function.

# Tag values for AWS resources
tags = {
  Environment = "Development",     # The environment in which the resources are deployed, in this case, for development purposes.
  Project     = "Payment Gateway", # The name of the project these resources are part of, specifically related to the payment gateway system.
  Owner       = "Anudeep"          # The person or team responsible for maintaining these resources.
}
