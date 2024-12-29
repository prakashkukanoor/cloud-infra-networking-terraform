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
}