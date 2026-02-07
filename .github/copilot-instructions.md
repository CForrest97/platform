<!-- OpenTofu Foundational Infrastructure Repository -->

## Project Overview
This is an OpenTofu infrastructure-as-code repository for managing foundational AWS infrastructure including DNS zones, AWS Organizations, accounts, and other core resources. State is managed in S3 with DynamoDB locking, and deployments are handled via GitHub Actions.

## Project Structure
- `modules/dns/` - Route53 DNS zone management
- `modules/organization/` - AWS Organization and account management
- `backend.tf` - S3 backend configuration for state management
- `variables.tf` - Global variable definitions
- `outputs.tf` - Global output definitions
- `terraform.tfvars.example` - Example variables file
- `.github/workflows/` - GitHub Actions CI/CD workflows

## Development Guidelines
- Always run `tofu fmt` before committing
- Use meaningful resource names and descriptions
- Keep modules focused and reusable
- Document all variables with descriptions
- Never commit sensitive values or credentials (use terraform.tfvars which is gitignored)
- State is stored in S3 with DynamoDB locking
- Deployments are automated via GitHub Actions

## OpenTofu Commands
- `tofu init` - Initialize the working directory
- `tofu plan` - Preview changes
- `tofu apply` - Apply changes
- `tofu destroy` - Destroy resources
- `tofu fmt` - Format configuration files
- `tofu validate` - Validate configuration

## Best Practices
- Use data sources when possible
- Implement proper tagging strategy
- Use local values for repeated expressions
- Lock provider versions
- This is foundational infrastructure - no environment separation needed
- Manage DNS zones, AWS accounts, and organization structure here
