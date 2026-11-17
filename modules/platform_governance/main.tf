locals {
  name = "${var.name_prefix}-${var.environment}"
  tags = merge(var.tags, {
    Environment = var.environment
    CostCenter  = var.cost_center
    ManagedBy   = "terraform"
    Module      = "platform-governance"
  })
}

resource "aws_vpc" "platform" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(local.tags, { Name = "${local.name}-platform" })
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.platform.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, 1)
  availability_zone = "${var.aws_region}a"

  tags = merge(local.tags, { Name = "${local.name}-private" })
}

resource "aws_cloudwatch_log_group" "platform" {
  name              = "/${local.name}/platform"
  retention_in_days = var.log_retention_days

  tags = local.tags
}

resource "aws_iam_role" "operator" {
  name = "${local.name}-platform-operator"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })

  tags = local.tags
}

resource "aws_iam_role_policy" "operator" {
  name = "${local.name}-platform-operator"
  role = aws_iam_role.operator.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "s3:GetObject",
        "s3:ListBucket",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
      ]
      Effect   = "Allow"
      Resource = "*"
    }]
  })
}

resource "aws_budgets_budget" "platform" {
  name         = "${local.name}-monthly"
  budget_type  = "COST"
  limit_amount = tostring(var.monthly_budget_usd)
  limit_unit   = "USD"
  time_unit    = "MONTHLY"

  dynamic "notification" {
    for_each = length(var.budget_alert_emails) > 0 ? [1] : []
    content {
      comparison_operator        = "GREATER_THAN"
      threshold                  = 80
      threshold_type             = "PERCENTAGE"
      notification_type          = "ACTUAL"
      subscriber_email_addresses = var.budget_alert_emails
    }
  }
}
