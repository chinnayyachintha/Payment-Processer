# DynamoDB Table for Storing Payment Transactions
resource "aws_dynamodb_table" "payment_ledger" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "TransactionID"

  # Define the attributes of the table
  attribute {
    name = "TransactionID"
    type = "S" # 'S' indicates that the TransactionID attribute is of type String
  }

  # Tags to categorize the table
  tags = merge(
    {
      Name = var.dynamodb_table_name
    },
    var.tags # Additional tags passed through variables (e.g., environment, project, owner)
  )

  # Explanation:
  # This resource creates a DynamoDB table named as specified by the `dynamodb_table_name` variable.
  # It is set to `PAY_PER_REQUEST` billing mode, which charges based on the number of read/write requests.
  # The table has a primary key (`TransactionID`) of type String (`S`), which uniquely identifies each item in the table.
  # Tags are merged from a local `Name` tag and the general tags passed via `var.tags`.
}
