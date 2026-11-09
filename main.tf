module "baseline" {
  source = "./modules/saas_baseline"

  name_prefix = var.name_prefix
  environment = var.environment
  tags        = var.tags
}
