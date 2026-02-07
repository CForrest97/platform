# OpenTofu Infrastructure Repository

Foundational infrastructure as code (IaC) for managing AWS accounts, DNS, and core infrastructure using OpenTofu.

## 📁 Project Structure

```
.
├── modules/                      # Reusable OpenTofu modules
│   ├── dns/                      # Route53 DNS zone management
│   └── organization/             # AWS Organization and account management
├── .github/
│   ├── workflows/                # GitHub Actions workflows
│   └── copilot-instructions.md   # Copilot configuration
├── backend.tf                    # S3 backend configuration
├── main.tf                       # Main infrastructure definitions
├── variables.tf                  # Variable definitions
├── outputs.tf                    # Output definitions
├── terraform.tfvars.example      # Example variables file
└── .gitignore                    # Git ignore rules
```

## 🚀 Getting Started

### Prerequisites

- [OpenTofu](https://opentofu.org/docs/intro/install/) >= 1.6.0
- AWS credentials configured with appropriate permissions
- S3 bucket for state storage
- DynamoDB table for state locking

### Initial Setup

1. **Create S3 bucket and DynamoDB table** for state management:
```bash
# Create S3 bucket
aws s3 mb s3://YOUR-STATE-BUCKET-NAME --region us-east-1

# Enable versioning
aws s3api put-bucket-versioning \
  --bucket YOUR-STATE-BUCKET-NAME \
  --versioning-configuration Status=Enabled

# Create DynamoDB table for locking
aws dynamodb create-table \
  --table-name tofu-state-lock \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST \
  --region us-east-1
```

2. **Update backend configuration**:
Edit [backend.tf](backend.tf) and replace placeholders:
- `YOUR-STATE-BUCKET-NAME` with your S3 bucket name
- Update region if needed
- Update DynamoDB table name if different

3. **Create your variables file**:
```bash
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your values
```

4. **Initialize OpenTofu**:
```bash
tofu init
```

5. **Review the plan**:
```bash
tofu plan
```

6. **Apply the configuration**:
```bash
tofu apply
```

## 🔧 Usage

### Managing DNS Zones

```hcl
# In terraform.tfvars
dns_zones = {
  "example.com" = {
    comment = "Primary domain"
  }
  "staging.example.com" = {
    comment = "Staging subdomain"
  }
}
```

Then enable the DNS module in [main.tf](main.tf):
```hcl
module "dns" {
  source = "./modules/dns"
  zones  = var.dns_zones
  tags   = local.common_tags
}
```

### Managing AWS Organization

Configure organizational units and accounts in [main.tf](main.tf):
```hcl
module "organization" {
  source            = "./modules/organization"
  organization_name = var.organization_name

  organizational_units = {
    "workloads" = {}
    "security"  = {}
  }

  accounts = {
    "production" = {
      email               = "aws-prod@example.com"
      organizational_unit = "workloads"
    }
  }

  tags = local.common_tags
}
```

### Common Commands

```bash
# Format configuration files
tofu fmt -recursive

# Validate configuration
tofu validate

# Show current state
tofu show

# List resources
tofu state list

# Destroy resources
tofu destroy -var-file=environments/dev/terraform.tfvars
```

## 📦 Modules

Reusable modules are located in the `modules/` directory:

- **dns** - Route53 hosted zone management
- **organization** - AWS Organization and account management

Each module includes documentation in its README.md file.

## 🔐 Security

- Never commit sensitive values or credentials
- Use GitHub Secrets for AWS credentials in Actions
- Keep `.tfvars` files out of version control (already in `.gitignore`)
- Use remote state with encryption enabled
- Implement state locking to prevent concurrent modifications

## 🚀 GitHub Actions CI/CD

This repository includes three GitHub Actions workflows:

### 1. Validate (`.github/workflows/tofu-validate.yml`)
Runs on every push and PR to validate configuration syntax and formatting.

### 2. Plan (`.github/workflows/tofu-plan.yml`)
Runs on PRs to show what changes will be made. Posts the plan as a PR comment.

### 3. Apply (`.github/workflows/tofu-apply.yml`)
Runs on pushes to `main` branch to apply infrastructure changes.

### Required GitHub Secrets

Add these secrets to your repository (Settings → Secrets and variables → Actions):

- `AWS_ACCESS_KEY_ID` - AWS access key for the deployment user
- `AWS_SECRET_ACCESS_KEY` - AWS secret key for the deployment user

**Recommended**: Use OIDC authentication instead of long-lived credentials. See [AWS OIDC Configuration](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services).

## 📝 Development Guidelines

1. **Formatting**: Always run `tofu fmt` before committing
2. **Validation**: Run `tofu validate` to check configuration syntax
3. **Documentation**: Document all variables with descriptions
4. **Modules**: Keep modules focused and reusable
5. **State**: State is managed in S3 with DynamoDB locking
6. **CI/CD**: Changes are deployed via GitHub Actions workflows

## 🤝 Contributing

1. Create a feature branch
2. Make your changes
3. Run `tofu fmt` and `tofu validate`
4. Test in dev environment first
5. Submit a pull request

## 📄 License

Add your license information here.

## 🆘 Support

For questions or issues, please contact the DevOps team.
# platform
