module "baseline" {
  source = "./modules/saas_baseline"

  name_prefix = var.name_prefix
  environment = var.environment
  tags        = var.tags
}

module "governance" {
  source = "./modules/platform_governance"

  name_prefix         = var.name_prefix
  environment         = var.environment
  tags                = var.tags
  vpc_cidr            = var.vpc_cidr
  aws_region          = var.aws_region
  log_retention_days  = var.log_retention_days
  monthly_budget_usd  = var.monthly_budget_usd
  budget_alert_emails = var.budget_alert_emails
  cost_center         = var.cost_center
}
