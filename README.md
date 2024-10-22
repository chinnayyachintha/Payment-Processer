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
