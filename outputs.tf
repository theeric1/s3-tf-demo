# ID of the created main S3 bucket
output "created_s3_bucket_id" {
  description = "ID of the created main S3 bucket"
  value       = module.s3-bucket-test.bucket_id
}

# ID of the created logging S3 bucket
output "created_logging_bucket_id" {
  description = "ID of the created logging S3 bucket"
  value       = module.s3-bucket-test.logging_bucket_id
}
# ARN of the main nucket
output "s3_bucket_arn" {
  description = "ARN of the created S3 bucket"
  value       = module.s3-bucket-test.bucket_arn
}

# ARN of the KMS key used for bucket encryption.
output "kms_key_arn" {
  description = "ARN of the KMS key used for bucket encryption"
  value       = module.s3-bucket-test.kms_key_arn
}

