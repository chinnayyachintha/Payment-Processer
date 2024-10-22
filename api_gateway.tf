# API Gateway REST API for Payment Processing
resource "aws_api_gateway_rest_api" "payment_api" {
  name        = var.api_gateway_name
  description = "API Gateway for payment processing"
  # This creates an API Gateway REST API that will be the entry point for clients to interact with the payment system.
}

# API Gateway Resource representing the /payment endpoint
resource "aws_api_gateway_resource" "payment_resource" {
  rest_api_id = aws_api_gateway_rest_api.payment_api.id
  parent_id   = aws_api_gateway_rest_api.payment_api.root_resource_id
  path_part   = "payment"
  # This defines a specific resource (path) under the REST API. In this case, it's the /payment endpoint.
}

# API Gateway Method for the POST request to /payment
resource "aws_api_gateway_method" "payment_method" {
  rest_api_id   = aws_api_gateway_rest_api.payment_api.id
  resource_id   = aws_api_gateway_resource.payment_resource.id
  http_method   = "POST"
  authorization = "NONE"
  # This creates a POST method for the /payment resource and specifies that no authorization is required (can be modified for security).
}

# API Gateway Integration with Lambda for the POST method
resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id             = aws_api_gateway_rest_api.payment_api.id
  resource_id             = aws_api_gateway_resource.payment_resource.id
  http_method             = aws_api_gateway_method.payment_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.payment_processor.invoke_arn
  # This integrates the API Gateway with the Lambda function. AWS_PROXY means the API Gateway will forward the request directly to Lambda.
  # The 'uri' points to the invoke ARN of the Lambda function that processes the payments.
}

# Deploying the API Gateway
resource "aws_api_gateway_deployment" "api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.payment_api.id
  stage_name  = "dev"
  depends_on = [
    aws_api_gateway_integration.lambda_integration
  ]
  # This creates a deployment of the API to the 'dev' stage. It ensures that the API is deployed only after the integration is created.
}
