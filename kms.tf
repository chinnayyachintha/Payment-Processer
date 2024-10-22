# KMS Key for Payment Cryptography
resource "aws_kms_key" "payment_key" {
  description             = "KMS key for payment cryptography"
  deletion_window_in_days = 30
  # Explanation:
  # This resource creates a KMS (Key Management Service) key that will be used to encrypt and decrypt sensitive payment data.
  # The `deletion_window_in_days` specifies that if this key is scheduled for deletion, AWS KMS will wait 30 days before permanently deleting it.
}

# Alias for the KMS Key
resource "aws_kms_alias" "payment_key_alias" {
  name          = "alias/paymentCryptography"
  target_key_id = aws_kms_key.payment_key.id
  # Explanation:
  # This resource creates a friendly alias `alias/paymentCryptography` for the KMS key to make it easier to reference and manage.
  # The alias points to the KMS key created above (by referencing `payment_key.id`).
}
