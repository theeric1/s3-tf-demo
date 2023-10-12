# Terraform S3 Bucket Module and Validation

This module provisions an S3 bucket with associated logging and a KMS key for encryption. It's designed to offer a balance between flexibility and security, adhering to best practices.

## Terraform S3 Bucket Module Usage

### Setup and Execution

#### Prerequisites
- Knowledge of Terraform and AWS.
- Proper AWS permissions and policies configured.
- Ability to pass necessary AWS credentials (e.g., aws-vault, environment variables).
- Terraform and any dependencies installed.

1. **Clone Repository**.
2. **Navigate to Directory**.
3. **Set Configurations**: Modify  `tfvars` file.
4. **Initialize**: Run `terraform init`.
5. **Review**: Execute `terraform plan`.
6. **Apply**: Run `terraform apply`.
7. **Teardown**: Execute `terraform destroy` after testing.

### Limitations and Considerations

- **CORS**: Direct S3-served web content might need CORS setup.
- **Encryption**: Defaults to KMS. Other types like AES256 aren't used.
- **Lifecycle**: No policies for transitioning objects (e.g., to Glacier).
- **Bucket Policy**: Defaults are restrictive; custom policies aren't integrated.

## Terratest for S3 Bucket Module

Terratest is a Go library used to test our Terraform configurations.

### Setup and Execution

#### Prerequisites
- Knowledge of Go, Terraform, and AWS.
- Installed Go, Terratest, and dependencies.
- Configured AWS permissions and policies.

1. **Navigate to Test Directory**: `./tests`.
2. **Fetch Dependencies**: Run `go get`.
3. **Execute Tests**: Execute with `go test -v`.

### What's Tested

- **Unique Bucket Creation**: The script creates an S3 bucket with a unique name.
- **Logging Configuration**: The test ensures that the created bucket has logging enabled.
- **Bucket Versioning**: Checks if versioning is enabled on the created bucket
- **Bucket Encryption**: Validates that the bucket has server-side encryption enabled using KMS
- **Object Uploads/Downloads**: Tests for object operations within the bucket.

### Some of the scenrios not yet covered:
- **CORS Configurations**: Validating any CORS settings for the bucket.
- **Lifecycle Policies**: Confirming any object lifecycle policies set on the bucket.

### Tips
- Beware of AWS costs when running tests.
- Utilize `-parallel` for independent tests.
- Adjust timeouts for resource-intensive tests.
