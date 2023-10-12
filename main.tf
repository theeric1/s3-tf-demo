terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
// Reference S3 module location and vars
module "s3-bucket-test" {
  source              = "./modules/s3-bucket-test"
  bucket_name         = var.bucket_name
  tags                = var.tags
  logging_bucket_name = var.logging_bucket_name
  logging_prefix      = var.logging_prefix
  versioning_enabled  = var.versioning_enabled
  kms_alias_name      = var.kms_alias_name
  kms_key_deletion_window = var.kms_key_deletion_window
  mfa_delete          = var.mfa_delete
}

# Access the KMS key alias ARN from the module's output
locals {
  kms_key_alias_arn = module.s3-bucket-test.kms_key_alias_arn
}
