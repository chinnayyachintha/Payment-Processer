# Output for DynamoDB Table Name
output "dynamodb_table_name" {
  value = aws_dynamodb_table.payment_ledger.name
  # This outputs the name of the DynamoDB table, allowing it to be easily accessed after Terraform execution.
}

# Output for API Gateway URL
output "api_gateway_url" {
  value = "${aws_api_gateway_rest_api.payment_api.execution_arn}/dev"
  # This outputs the execution URL for the API Gateway, appending the 'dev' stage.
  # The output allows users to access the API Gateway URL after deployment to make requests.
}

# Output for Lambda Function ARN
output "lambda_function_arn" {
  value = aws_lambda_function.payment_processor.arn
  # This outputs the ARN (Amazon Resource Name) of the Lambda function, making it easy to reference after deployment.
}
