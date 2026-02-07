# Modules

This directory contains reusable OpenTofu modules for managing foundational infrastructure.

## Available Modules

### State Backend
Located in `state/` - Manages S3 bucket and DynamoDB table for OpenTofu remote state storage.

### GitHub OIDC
Located in `github-oidc/` - Manages AWS IAM OIDC provider and role for GitHub Actions authentication.

### DNS
Located in `dns/` - Manages Route53 hosted zones and DNS records.

### Organization
Located in `organization/` - Manages AWS Organizations, Organizational Units, and AWS accounts.

## Creating New Modules

When creating a new module:

1. Create a new directory in `modules/`
2. Add the following files:
   - `main.tf` - Main resource definitions
   - `variables.tf` - Input variables
   - `outputs.tf` - Output values
   - `README.md` - Module documentation
3. Follow the naming convention: `{environment}_{resource_type}_{name}`
4. Document all variables and outputs
5. Include usage examples in the README

## Module Best Practices

- Keep modules focused on a single responsibility
- Use semantic versioning for module releases
- Provide sensible defaults for variables
- Include validation rules for inputs
- Document all outputs and their use cases
