# Variable to specify the AWS Region where resources will be deployed
variable "aws_region" {
  type        = string
  description = "AWS Region to deploy resources"
  # This variable defines the AWS region where the resources like DynamoDB, Lambda, and API Gateway will be deployed.
}

# Variable to specify the name of the DynamoDB table
variable "dynamodb_table_name" {
  type        = string
  description = "Name of the DynamoDB table"
  # This variable holds the name of the DynamoDB table that will store payment transaction logs or details.
}

# Variable to specify the name of the Lambda function for payment processing
variable "lambda_function_name" {
  type        = string
  description = "Name of the Lambda function for payment processing"
  # This variable defines the name of the Lambda function responsible for executing the payment logic, like validating payments and interacting with the database.
}

# Variable to specify the name of the API Gateway
variable "api_gateway_name" {
  type        = string
  description = "Name of the API Gateway"
  # This variable holds the name of the API Gateway that serves as the entry point for clients interacting with the payment system.
}

# Variable to specify a map of tags for AWS resources
variable "tags" {
  description = "A map of tags to assign to resources."
  type        = map(string)
  # This variable is used to define tags (key-value pairs) that will be assigned to each AWS resource. 
  # Tags provide additional context, such as environment and owner, to help manage and organize resources.
}
