# ID of the main bucket
output "bucket_id" {
  description = "ID of the main S3 bucket"
  value       = aws_s3_bucket.main.id  
}

# ID of the logging bucket
output "logging_bucket_id" {
  description = "ID of the logging S3 bucket"
  value       = aws_s3_bucket.logging.id
}

# Alias name of the KMS key
output "kms_key_alias_name" {
  description = "Alias name of the KMS key used for S3 bucket encryption"
  value       = aws_kms_alias.main.name
}
# ARN of the main bucket
output "bucket_arn" {
  description = "ARN of the main S3 bucket"
  value       = aws_s3_bucket.main.arn
}

# ARN of the logging S3 bucket
output "logging_bucket_arn" {
  description = "ARN of the logging S3 bucket"
  value       = aws_s3_bucket.logging.arn
}

# ARN of the KMS key used for encryption
output "kms_key_arn" {
  description = "ARN of the KMS key used for S3 bucket encryption"
  value       = aws_kms_key.main.arn
}

# ARN of the KMS key alias
output "kms_key_alias_arn" {
  description = "ARN of the KMS key alias"
  value       = aws_kms_alias.main.arn
}
