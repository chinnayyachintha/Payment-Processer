# Payment Processing Solution

## Ticket Title: Implement Process-Payment Persisting Payment Ledger

### Overview

This project implements a secure payment processing workflow, leveraging AWS services to ensure compliance and security. The architecture includes AWS KMS for encryption, DynamoDB for data persistence, and Lambda functions for processing payment requests.

### Requirements

- **Data Encryption and Storage**: Securely encrypt payment metadata using AWS KMS and store encrypted data in DynamoDB.
- **Payment Integration**: Interact with a payment processor (e.g., Sparkle payment gateway) to handle actual payments.
- **Automated Workflow**: Design an end-to-end flow for tokenizing, processing, and recording payments in DynamoDB.
- **Infrastructure as Code (IaC)**: Use Terraform to automate the deployment of the architecture.

### Expectations

- **Compliance**: Ensure the solution complies with standards such as PCI-DSS.
- **Data Storage**: Store encrypted payment data and transaction details in DynamoDB.
- **Infrastructure Provisioning**: Use Terraform scripts to provision all required AWS resources.
- **API Endpoint**: Provide a functional API endpoint via API Gateway for payment-related requests.

---

## Step-by-Step Procedure

### 1. Design the Architecture

- **AWS KMS**: For encryption and decryption.
- **DynamoDB**: For storing payment records.
- **Lambda**: For processing payment requests (tokenization, decryption, rule-based processing).
- **API Gateway**: To expose a RESTful API for client interactions.

### 2. Create the Infrastructure Using Terraform

#### 2.1 DynamoDB Setup
- Create a DynamoDB table to store payment records.

#### 2.2 KMS Key
- Create a KMS key for encrypting and decrypting payment data.

#### 2.3 Lambda Functions
- Develop Lambda functions for:
  - Tokenizing payment data.
  - Storing payment information in DynamoDB.
  - Interacting with the payment gateway.

#### 2.4 API Gateway
- Set up an API Gateway to expose endpoints for initiating payment processing.

#### 2.5 IAM Roles and Policies
- Define roles and policies for Lambda functions, allowing access to DynamoDB, KMS, and other required services.

### 3. Write Terraform Code

- **Modular Structure**: Split the code into modular files:
  - `dynamodb.tf`
  - `lambda.tf`
  - `api_gateway.tf`
- Use the `merge` function to dynamically tag AWS resources.
- Run the following commands to deploy the infrastructure:
  ```bash
  terraform init
  terraform apply


  # Payment Encryption and Storage Using AWS Lambda, KMS, and DynamoDB

This project provides an AWS Lambda function designed to securely handle payment processing by encrypting credit card metadata and storing the encrypted data in an AWS DynamoDB table. The function utilizes AWS Key Management Service (KMS) for encryption, ensuring the security and compliance of sensitive payment information.

## Overview

The Lambda function performs the following steps:

1. **Receiving Event Data**:
   - The function is triggered by an event containing credit card metadata, expected to be passed under the key `'card_data'`. 
   - If the `'card_data'` is not found in the incoming event, the function returns a `400` status code with an error message indicating "Missing card data."

2. **Encrypting the Data Using KMS**:
   - The function encrypts the credit card metadata using AWS KMS.
   - The `encrypt_data` function converts the metadata to a JSON string, encodes it into bytes, and encrypts it using the KMS key specified by the `KMS_KEY_ID` environment variable.
   - The encrypted result is a binary blob (`CiphertextBlob`), which represents the encrypted version of the credit card metadata.

3. **Storing Encrypted Data in DynamoDB**:
   - The encrypted data is then stored in a DynamoDB table.
   - The `store_in_dynamodb` function generates a unique `transaction_id` based on the hash of the encrypted data and stores it along with the encrypted data in the DynamoDB table specified by the `DYNAMODB_TABLE` environment variable.

## Prerequisites

Before deploying this function, ensure that you have:
- An AWS account with permissions to use Lambda, KMS, and DynamoDB.
- A KMS key configured for encryption.
- A DynamoDB table set up to store the encrypted data.

## Environment Variables

The Lambda function requires the following environment variables:
- `DYNAMODB_TABLE`: The name of the DynamoDB table where encrypted data will be stored.
- `KMS_KEY_ID`: The ID of the KMS key used to encrypt the payment metadata.

## Example Usage

When the function is triggered with an event containing the following JSON:

```json
{
    "card_data": {
        "card_number": "4111111111111111",
        "expiry_date": "12/25",
        "card_holder": "John Doe"
    }
}

