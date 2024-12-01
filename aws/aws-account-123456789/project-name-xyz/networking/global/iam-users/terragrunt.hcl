#Include the parent terragrunt.hcl to inherit the remote_state block
include "root" {
  path = find_in_parent_folders()
}

# # # Define specific values for this child configuration
locals {
  parent_config = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  bucket_name         = local.parent_config.locals.bucket_name
  dynamodb_table_name = local.parent_config.locals.dynamodb_table_name
}

terraform {
  source = "git@github.com:prakashkukanoor/aws-module-iam-roles-users.git?ref=v1.0.0"
}

inputs = {
  region               = "us-east-1"
  team                 = "devops"
  environment          = "PROD"
  path_to_json_file    = "${get_terragrunt_dir()}/policy.json.tpl"
  bucket_name          = "${local.bucket_name}"
  dynamodb_table_name  = "${local.dynamodb_table_name}"
  public_key_file_path = "/Users/prakashkukanoor/Documents/Prakash/Learning/private-public-keys/public-key-terraform.asc"

  users = [
    { user = "user1", path = "/terraform/networking/admins/users/" },
    { user = "user2", path = "/terraform/networking/admins/users/" },
    { user = "user5", path = "/terraform/networking/non-admins/users/" },
    { user = "user6", path = "/terraform/networking/non-admins/users/" }
  ]
}