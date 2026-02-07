variable "github_repositories" {
  description = "List of GitHub repositories allowed to assume the role (format: 'repo:owner/repo-name:ref:refs/heads/main')"
  type        = list(string)
}

variable "role_name" {
  description = "Name of the IAM role for GitHub Actions"
  type        = string
  default     = "github-actions-role"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
