provider "aws" {
  region = var.aws_region

  default_tags {
    tags = var.tags
  }
}

locals {
  common_tags = var.tags
}

module "state" {
  source         = "./modules/state"
  aws_account_id = var.aws_account_id
}

module "github_oidc" {
  source = "./modules/github-oidc"

  github_repositories = [
    "repo:CForrest97/platform:*",
  ]

  role_name = "github-actions-infra-role"

  tags = local.common_tags
}
