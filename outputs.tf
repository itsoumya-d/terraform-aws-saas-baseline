output "artifacts_bucket_name" {
  description = "S3 bucket for application artifacts."
  value       = module.baseline.artifacts_bucket_name
}

output "state_table_name" {
  description = "DynamoDB table for idempotency and workflow state."
  value       = module.baseline.state_table_name
}
