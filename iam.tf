# IAM Role for Lambda Execution
resource "aws_iam_role" "lambda_exec" {
  name = "lambda_execution_role"

  # Policy that allows Lambda to assume this role
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
  # Explanation:
  # This IAM role is created specifically for Lambda functions. The assume role policy allows the Lambda service to assume this role.
}

# IAM Policy for Lambda to interact with DynamoDB and KMS
resource "aws_iam_policy" "lambda_policy" {
  name        = "LambdaDynamoDBPolicy"
  description = "IAM policy for Lambda to access DynamoDB and KMS"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        # Allow Lambda to perform actions on DynamoDB (PutItem, GetItem, UpdateItem)
        Action = [
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:UpdateItem"
        ]
        Effect   = "Allow"
        Resource = aws_dynamodb_table.payment_ledger.arn
        # Grants permission for the Lambda function to perform DynamoDB operations (Put, Get, Update) on the PaymentLedger table.
      },
      {
        # Allow Lambda to perform encryption and decryption with KMS
        Action = [
          "kms:Encrypt",
          "kms:Decrypt"
        ]
        Effect   = "Allow"
        Resource = aws_kms_key.payment_key.arn
        # This statement allows the Lambda function to encrypt and decrypt data using the specified KMS key.
      }
    ]
  })
  # Explanation:
  # This IAM policy gives Lambda the necessary permissions to read/write from DynamoDB and to encrypt/decrypt data using AWS KMS.
}

# Attaching the IAM Policy to the Lambda Execution Role
resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = aws_iam_policy.lambda_policy.arn
  # Explanation:
  # This resource attaches the defined `lambda_policy` to the `lambda_exec` role, 
  # ensuring that the Lambda function associated with this role has the necessary permissions to access DynamoDB and KMS.
}
