output "vpc_id" {
  description = "ID of the platform VPC."
  value       = aws_vpc.platform.id
}

output "vpc_cidr" {
  description = "Configured CIDR block of the platform VPC."
  value       = aws_vpc.platform.cidr_block
}

output "private_subnet_id" {
  description = "ID of the private platform subnet."
  value       = aws_subnet.private.id
}

output "log_group_name" {
  description = "Centralised platform log group."
  value       = aws_cloudwatch_log_group.platform.name
}

output "operator_role_name" {
  description = "Least-privilege platform operator IAM role."
  value       = aws_iam_role.operator.name
}

output "budget_name" {
  description = "Name of the monthly FinOps budget."
  value       = aws_budgets_budget.platform.name
}

output "budget_limit" {
  description = "Configured monthly cost limit in USD."
  value       = aws_budgets_budget.platform.limit_amount
}
