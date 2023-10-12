variable "aws_region" {
  description = "AWS region to deploy resources in"
  type        = string
  default     = "us-west-2"
}

variable "bucket_name" {
  description = "Name of the main bucket"
  type        = string
}

variable "tags" {
  description = "Tags for the main bucket"
  type        = map(string)
  default     = {}
}

variable "logging_bucket_name" {
  description = "Name of the S3 bucket for logging"
  type        = string
}

variable "logging_prefix" {
  description = "Prefix for logging"
  type        = string
  default     = ""
}

variable "versioning_enabled" {
  description = "Boolean to enable or disable versioning"
  type        = bool
  default     = true
}

variable "kms_alias_name" {
  description = "Name for the KMS key alias"
  type        = string
}

variable "kms_key_deletion_window" {
  description = "Number of days a key is deleted after being disabled"
  type        = number
  default     = 10 
}

variable "mfa_delete" {
  description = "Whether to enable MFA delete for the S3 bucket"
  type        = bool
  default     = false
}

