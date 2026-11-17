variable "name_prefix" {
  description = "Short lowercase prefix for resource names."
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{1,20}$", var.name_prefix))
    error_message = "name_prefix must be 2-21 lowercase letters, digits or hyphens and start with a letter."
  }
}

variable "environment" {
  description = "Deployment environment."
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment must be dev, staging or prod."
  }
}

variable "tags" {
  description = "Additional tags applied to every resource."
  type        = map(string)
  default     = {}
}

variable "vpc_cidr" {
  description = "CIDR block for the platform landing-zone VPC."
  type        = string
  default     = "10.42.0.0/16"
}

variable "aws_region" {
  description = "AWS region used to derive subnet availability zones."
  type        = string
  default     = "ap-southeast-2"
}

variable "log_retention_days" {
  description = "Retention window for centralised platform logs."
  type        = number
  default     = 30

  validation {
    condition     = var.log_retention_days >= 1 && var.log_retention_days <= 3653
    error_message = "log_retention_days must be between 1 and 3653 days."
  }
}

variable "monthly_budget_usd" {
  description = "Monthly cost guardrail for FinOps budgeting."
  type        = number
  default     = 5000
}

variable "budget_alert_emails" {
  description = "Optional list of subscribers for budget threshold alerts."
  type        = list(string)
  default     = []
}

variable "cost_center" {
  description = "Cost allocation tag value for chargeback and FinOps reporting."
  type        = string
  default     = "platform"
}
