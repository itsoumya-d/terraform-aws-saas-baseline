mock_provider "aws" {}

run "baseline_plan" {
  command = plan

  variables {
    name_prefix = "slalom"
    environment = "dev"
    tags = {
      Owner = "platform"
    }
  }

  assert {
    condition     = output.artifacts_bucket_name == "slalom-dev-artifacts"
    error_message = "The artifacts bucket name must be deterministic."
  }

  assert {
    condition     = output.state_table_name == "slalom-dev-state"
    error_message = "The state table name must be deterministic."
  }
}
