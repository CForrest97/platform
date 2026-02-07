terraform {
  backend "s3" {
    bucket         = "tofu-state-${var.aws_account_id}"
    key            = "infra/terraform.tfstate"
    region         = var.aws_region
    encrypt        = true
    dynamodb_table = "tofu-state-locks"
  }

  required_version = ">= 1.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.31"
    }
  }
}
