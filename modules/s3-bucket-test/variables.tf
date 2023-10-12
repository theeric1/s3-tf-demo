variable "bucket_name" {
  description = "Name of the main S3 bucket"
  type        = string
}

variable "tags" {
  description = "Tags for the main S3 bucket"
  type        = map(string)
  default     = {}
}

variable "logging_bucket_name" {
  description = "Name of the S3 bucket used for logging"
  type        = string
}

variable "logging_prefix" {
  description = "Prefix for S3 logging"
  type        = string
  default     = ""
}

variable "versioning_enabled" {
  description = "Flag to enable or disable versioning on the main S3 bucket"
  type        = bool
  default     = true
}

variable "kms_alias_name" {
  description = "Name for the KMS key alias"
  type        = string
}

variable "mfa_delete" {
  description = "Flag to enable or disable MFA delete on the main S3 bucket"
  type        = bool
  default     = false
}

variable "kms_key_deletion_window" {
  description = "The duration in days after which the key is deleted after destruction of the resource"
  type        = number
  default     = 10  # Setting a default value of 10 days
}

