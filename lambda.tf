# Lambda Function for Payment Processing
resource "aws_lambda_function" "payment_processor" {
  function_name = var.lambda_function_name
  runtime       = "python3.9"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "payment_processor.lambda_handler"
  filename      = "package.zip" # Path to your packaged Lambda code

  # Environment variables passed to the Lambda function
  environment {
    variables = {
      DYNAMODB_TABLE = aws_dynamodb_table.payment_ledger.name
      KMS_KEY_ID     = aws_kms_key.payment_key.key_id  # Add the KMS key ID to environment variables
    }
  }

  # Tags for resource management
  tags = merge(
    {
      Name = var.lambda_function_name
    },
    var.tags
  )

  # Explanation:
  # This resource creates a Lambda function named as per the `lambda_function_name` variable.
  # It uses the specified runtime (Python 3.9), role (for permissions), and handler (the main entry point for the Lambda function).
  # The environment block defines any variables the Lambda function needs, such as the name of the DynamoDB table and the KMS key ID.
  # Tags are added to categorize and manage the Lambda function.
}

# Lambda Permission to Allow API Gateway Invocation
resource "aws_lambda_permission" "api_gateway_invoke" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.payment_processor.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.payment_api.execution_arn}/*/*"

  # Explanation:
  # This resource grants API Gateway permission to invoke the Lambda function.
  # The permission is specified with the action `lambda:InvokeFunction` and limited to API Gateway (`apigateway.amazonaws.com`).
  # The `source_arn` ensures the permission is granted only for requests coming from the specified API Gateway resource.
}