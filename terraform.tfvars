//Update to fit individual requirements
aws_region = "us-east-1"                  # AWS deployment region
kms_alias_name = "alias/s3-key-test"      # KMS key alias
kms_key_deletion_window = 7               # KMS key deletion window in days
bucket_name = "tftest-111-abcd"           # Main S3 bucket name
logging_bucket_name = "tfttest-111-ab-logs"  # S3 logging bucket name
logging_prefix = "s3-logs/"               # Logging prefix in logging bucket
versioning_enabled = true                 # Enable S3 bucket versioning
mfa_delete = false                        # Enable MFA delete for the bucket
tags = {                                  # Resource tags
  Project = "Well-co-test"
  Env     = "Prod"
}
