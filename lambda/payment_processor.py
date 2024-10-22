import boto3
import os
import json
from botocore.exceptions import ClientError

# Initialize the AWS SDK clients
dynamodb = boto3.resource('dynamodb')
kms_client = boto3.client('kms')

# Get the environment variables
DYNAMODB_TABLE = os.environ['DYNAMODB_TABLE']
KMS_KEY_ID = os.environ['KMS_KEY_ID']  # Add this variable in the Terraform environment section

# Lambda handler function
def lambda_handler(event, context):
    try:
        # Process incoming event data
        print("Received event: " + json.dumps(event))

        # Example: Assume 'card_data' is passed in the event to encrypt and store
        card_data = event.get('card_data')
        if not card_data:
            return {
                'statusCode': 400,
                'body': json.dumps({'message': 'Missing card data'})
            }

        # Encrypt card data using KMS
        encrypted_data = encrypt_data(card_data)

        # Store encrypted data in DynamoDB
        store_in_dynamodb(encrypted_data)

        return {
            'statusCode': 200,
            'body': json.dumps({'message': 'Payment processed successfully', 'data': encrypted_data})
        }

    except Exception as e:
        print(f"Error processing payment: {str(e)}")
        return {
            'statusCode': 500,
            'body': json.dumps({'message': 'Internal Server Error'})
        }

def encrypt_data(data):
    """Encrypt data using KMS."""
    try:
        response = kms_client.encrypt(
            KeyId=KMS_KEY_ID,
            Plaintext=json.dumps(data).encode('utf-8')  # Convert data to bytes
        )
        return response['CiphertextBlob']
    except ClientError as e:
        print(f"Error encrypting data: {e}")
        raise

def store_in_dynamodb(encrypted_data):
    """Store encrypted data in DynamoDB."""
    table = dynamodb.Table(DYNAMODB_TABLE)

    try:
        # Example item to store
        item = {
            'transaction_id': str(hash(encrypted_data)),  # Use a hash for a unique transaction ID
            'encrypted_data': encrypted_data
        }
        table.put_item(Item=item)
        print("Data stored in DynamoDB successfully.")
    except ClientError as e:
        print(f"Error storing data in DynamoDB: {e}")
        raise
