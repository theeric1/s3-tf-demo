package test

import (
	"fmt"
	"io"
	"strings"
	"testing"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/s3"
	ttaws "github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestS3Bucket(t *testing.T) {
	t.Parallel()

	awsRegion := "us-east-1"

	// Set Terraform options
	terraformOpts := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../",
		Vars: map[string]interface{}{
			"bucket_name": fmt.Sprintf("testbucket-%v", strings.ToLower(random.UniqueId())),
		},
		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": awsRegion,
		},
	})

	// Establish a session with AWS SDK
	sess := session.Must(session.NewSession(&aws.Config{
		Region: aws.String(awsRegion),
	}))
	s3Client := s3.New(sess)

	// Deploy the infrastructure
	terraform.InitAndApply(t, terraformOpts)

	// Fetch the bucket ID from Terraform outputs
	bucketID := terraform.Output(t, terraformOpts, "created_s3_bucket_id")

	// Ensure infrastructure is destroyed after test completion
	defer func() {
		deleteAllObjects(t, s3Client, bucketID)
		terraform.Destroy(t, terraformOpts)
	}()

	// Verify logging configuration
	loggingConfig := ttaws.GetS3BucketLoggingTarget(t, awsRegion, bucketID)
	require.NotEmpty(t, loggingConfig, "Failed: Bucket does not have a logging configuration.")

	// Verify versioning
	actualStatus := ttaws.GetS3BucketVersioning(t, awsRegion, bucketID)
	require.Equal(t, "Enabled", actualStatus, "Failed: Bucket versioning is not enabled.")

	// Verify bucket encryption
	encryptionOutput, err := s3Client.GetBucketEncryption(&s3.GetBucketEncryptionInput{
		Bucket: aws.String(bucketID),
	})
	require.NoError(t, err, "Failed to fetch bucket encryption.")
	assert.NotNil(t, encryptionOutput.ServerSideEncryptionConfiguration, "Bucket does not have server-side encryption configuration.")

	// Upload a test string to the bucket
	fileContent := "testcontent"
	_, err = s3Client.PutObject(&s3.PutObjectInput{
		Body:   strings.NewReader(fileContent),
		Bucket: aws.String(bucketID),
		Key:    aws.String("testfile.txt"),
	})
	require.NoError(t, err, "Failed to upload file to bucket.")

	// Download the test string
	output, err := s3Client.GetObject(&s3.GetObjectInput{
		Bucket: aws.String(bucketID),
		Key:    aws.String("testfile.txt"),
	})
	require.NoError(t, err, "Failed to download file from bucket.")

	downloadedContent := new(strings.Builder)
	_, err = io.Copy(downloadedContent, output.Body)
	require.NoError(t, err, "Failed to read downloaded content.")
	assert.Equal(t, fileContent, downloadedContent.String(), "Uploaded and downloaded content don't match.")
}

// Helper function to delete all objects (and their versions) from a bucket
func deleteAllObjects(t *testing.T, s3Client *s3.S3, bucket string) {
	input := &s3.ListObjectVersionsInput{
		Bucket: aws.String(bucket),
	}

	result, err := s3Client.ListObjectVersions(input)
	require.NoError(t, err, "Failed to list object versions.")

	for _, version := range result.Versions {
		_, err = s3Client.DeleteObject(&s3.DeleteObjectInput{
			Bucket:    aws.String(bucket),
			Key:       version.Key,
			VersionId: version.VersionId,
		})
		require.NoError(t, err, "Failed to delete object version.")
	}
}
