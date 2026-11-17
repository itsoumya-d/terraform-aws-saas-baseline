output "artifacts_bucket_name" {
  description = "S3 bucket for application artifacts."
  value       = module.baseline.artifacts_bucket_name
}

output "state_table_name" {
  description = "DynamoDB table for idempotency and workflow state."
  value       = module.baseline.state_table_name
}

output "platform_vpc_cidr" {
  description = "CIDR block of the platform landing-zone VPC."
  value       = module.governance.vpc_cidr
}

output "platform_log_group_name" {
  description = "Centralised platform log group."
  value       = module.governance.log_group_name
}

output "platform_operator_role_name" {
  description = "Least-privilege platform operator IAM role."
  value       = module.governance.operator_role_name
}

output "monthly_budget_limit" {
  description = "Configured monthly FinOps cost limit in USD."
  value       = module.governance.budget_limit
}
