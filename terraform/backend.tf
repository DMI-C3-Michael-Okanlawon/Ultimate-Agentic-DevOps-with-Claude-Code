# S3 Backend Configuration
#
# IMPORTANT: Uncomment this block AFTER creating the S3 state bucket and DynamoDB table
#
# Initial Setup Process:
# 1. Run `terraform init` without backend (with this block commented out)
# 2. Run `terraform apply` to create the infrastructure
# 3. Manually create the S3 bucket for Terraform state (or use another Terraform config)
# 4. Create a DynamoDB table for state locking with:
#    - Name: terraform-locks
#    - Primary key: LockID (string)
# 5. Uncomment the backend block below
# 6. Run `terraform init -migrate-state` to migrate state to S3
#
# terraform {
#   backend "s3" {
#     bucket         = "your-terraform-state-bucket"
#     key            = "portfolio-site/terraform.tfstate"
#     region         = "ap-south-1"
#     encrypt        = true
#     dynamodb_table = "terraform-locks"
#   }
# }
