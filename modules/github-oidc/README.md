# GitHub OIDC Module

This module creates an AWS IAM OIDC provider and role for GitHub Actions to authenticate without long-lived credentials.

## Usage

```hcl
module "github_oidc" {
  source = "./modules/github-oidc"

  github_org = "your-org"
  github_repositories = [
    "repo:your-org/infra:ref:refs/heads/main",
    "repo:your-org/infra:pull_request"
  ]

  role_name = "github-actions-infra-role"
  
  role_policy_arns = [
    "arn:aws:iam::aws:policy/ReadOnlyAccess"
  ]

  tags = var.tags
}
```

## GitHub Actions Workflow Configuration

Update your workflows to use OIDC authentication:

```yaml
permissions:
  id-token: write
  contents: read

steps:
  - name: Configure AWS credentials
    uses: aws-actions/configure-aws-credentials@v4
    with:
      role-to-assume: arn:aws:iam::ACCOUNT_ID:role/github-actions-infra-role
      aws-region: us-east-1
```

## Repository Patterns

The `github_repositories` variable accepts patterns for the `sub` claim:
- `repo:owner/repo-name:ref:refs/heads/main` - Only main branch
- `repo:owner/repo-name:ref:refs/heads/*` - Any branch
- `repo:owner/repo-name:pull_request` - Pull requests
- `repo:owner/repo-name:*` - Any reference

## Built-in Permissions

This module automatically grants the role permissions to:
- Read/write OpenTofu state in S3 buckets matching `tofu-state-*`
- Access state lock table in DynamoDB

Additional permissions can be added via `role_policy_arns`.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| github_org | GitHub organization or username | `string` | n/a | yes |
| github_repositories | List of repository patterns allowed to assume the role | `list(string)` | n/a | yes |
| role_name | Name of the IAM role for GitHub Actions | `string` | `"github-actions-role"` | no |
| role_policy_arns | List of IAM policy ARNs to attach to the role | `list(string)` | `[]` | no |
| tags | Tags to apply to resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| oidc_provider_arn | ARN of the GitHub OIDC provider |
| role_arn | ARN of the IAM role for GitHub Actions |
| role_name | Name of the IAM role for GitHub Actions |

## Security Notes

- Use specific repository patterns to limit which repos can assume the role
- Prefer branch-specific patterns over wildcards
- Review and minimize the attached IAM policies
- The OIDC provider is shared across all GitHub Actions in your account
