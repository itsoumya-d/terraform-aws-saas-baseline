# terraform-aws-saas-baseline

A small, reviewable Terraform baseline for an AWS SaaS platform.

## Why this exists

Slalom's Cloud & Build team is asked to modernise legacy systems and migrate workloads with **Terraform, AWS, React and a backend language**. The repeatable foundation usually has to solve the same first three problems:

1. A private-by-default artifact bucket with versioning and encryption.
2. A DynamoDB state/idempotency table with point-in-time recovery.
3. A deterministic naming convention that makes environments reviewable.

This module does exactly that, with validation, a mocked-provider plan test and a CI gate. It is deliberately small enough to review in one sitting.

## Structure

```text
.
├── main.tf                  # root composition
├── variables.tf             # validated inputs
├── outputs.tf
├── modules/saas_baseline    # artifact bucket + state table
└── tests/baseline.tftest.hcl
```

## Test and CI

```bash
terraform fmt -check -recursive
terraform init -backend=false
terraform validate
terraform test
```

GitHub Actions runs the same sequence on Terraform 1.9.8. `terraform test` uses `mock_provider "aws"`, so the plan test does not need AWS credentials.

## Scope

This is a reference baseline, not a production landing zone. It intentionally leaves out networking, IAM boundaries, logging destinations and remote state; those should be added per client after a threat model and account strategy review.
