output "artifacts_bucket_name" {
  description = "S3 bucket for application artifacts."
  value       = aws_s3_bucket.artifacts.bucket
}

output "state_table_name" {
  description = "DynamoDB table for idempotency and workflow state."
  value       = aws_dynamodb_table.state.name
}
