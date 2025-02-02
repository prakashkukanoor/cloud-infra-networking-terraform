#Include the parent terragrunt.hcl to inherit the remote_state block
include "root" {
  path = find_in_parent_folders()
}

# Define specific values for this child configuration
locals {
  parent_config = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  bucket_name         = local.parent_config.locals.bucket_name
  dynamodb_table_name = local.parent_config.locals.dynamodb_table_name
}

terraform {
  source = "git@github.com:prakashkukanoor/terraform-aws-vpc-subnets-routetable.git"
}

inputs = {
  region               = "us-east-1"
  team                 = "devops"
  environment          = "PROD"
  vpc_cidr_ipv4 = "10.0.0.0/16"
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  enable_ipv6 = true
  application_public_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  application_private_subnets = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  database_private_subnets = ["10.0.201.0/24", "10.0.202.0/24", "10.0.203.0/24"]
}