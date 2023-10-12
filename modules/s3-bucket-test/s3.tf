# Create the KMS key for S3 bucket encryption
resource "aws_kms_key" "main" {
  description             = "KMS key for S3 bucket encryption"
  deletion_window_in_days = var.kms_key_deletion_window
}


# Create the KMS key alias for easier reference
resource "aws_kms_alias" "main" {
  name          = var.kms_alias_name
  target_key_id = aws_kms_key.main.id
}

# Create the main S3 bucket
resource "aws_s3_bucket" "main" {
  bucket = var.bucket_name
  tags   = var.tags
}

# Block public access configurations for the main bucket
resource "aws_s3_bucket_public_access_block" "main" {
  bucket = aws_s3_bucket.main.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Create a separate S3 bucket for logging purposes
resource "aws_s3_bucket" "logging" {
  bucket = var.logging_bucket_name
}

# Enable server-side encryption for the main S3 bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "main" {
  bucket = aws_s3_bucket.main.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.main.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

# Control versioning on the main S3 bucket
resource "aws_s3_bucket_versioning" "main" {
  bucket = aws_s3_bucket.main.id

  versioning_configuration {
    status     = var.versioning_enabled ? "Enabled" : "Suspended"
    mfa_delete = var.mfa_delete ? "Enabled" : "Disabled"
  }
}

# Logging configurations for the main S3 bucket
resource "aws_s3_bucket_logging" "main" {
  bucket        = aws_s3_bucket.main.id
  target_bucket = aws_s3_bucket.logging.bucket
  target_prefix = var.logging_prefix
}




