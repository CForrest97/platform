variable "aws_region" {
  description = "Primary AWS region"
  type        = string
  default     = "eu-west-2"
}

variable "aws_account_id" {
  description = "AWS Account ID for the primary account"
  type        = string
  default     = "095907291166"
}

variable "dns_zones" {
  description = "DNS zones to manage"
  type = map(object({
    comment = string
  }))
  default = {}
}

variable "tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default = {
    ManagedBy = "OpenTofu"
    Repo      = "infra"
  }
}
