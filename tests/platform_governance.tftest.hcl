mock_provider "aws" {}

run "platform_governance_plan" {
  command = plan

  variables {
    name_prefix        = "slalom"
    environment        = "dev"
    vpc_cidr           = "10.42.0.0/16"
    aws_region         = "ap-southeast-2"
    log_retention_days = 30
    monthly_budget_usd = 5000
    cost_center        = "platform"
    budget_alert_emails = [
      "platform-alerts@example.invalid",
    ]
    tags = {
      Owner = "platform"
    }
  }

  assert {
    condition     = output.platform_vpc_cidr == "10.42.0.0/16"
    error_message = "The platform VPC must use the configured CIDR block."
  }

  assert {
    condition     = output.platform_log_group_name == "/slalom-dev/platform"
    error_message = "The centralised platform log group must be deterministically named."
  }

  assert {
    condition     = output.platform_operator_role_name == "slalom-dev-platform-operator"
    error_message = "The operator IAM role must follow the landing-zone naming convention."
  }

  assert {
    condition     = output.monthly_budget_limit == "5000"
    error_message = "The FinOps budget must reflect the configured monthly limit."
  }
}
