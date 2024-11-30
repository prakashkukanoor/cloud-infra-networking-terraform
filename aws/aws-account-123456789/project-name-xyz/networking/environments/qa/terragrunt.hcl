# Include the parent terragrunt.hcl to inherit the remote_state block
include {
  path = find_in_parent_folders()  # This will include the parent configuration
}

# Define specific values for this child configuration
# locals {
#   bucket_name         = "child-specific-bucket"
#   dynamodb_table_name = "child-dynamodb-table"
# }

terraform {
  source = "git@github.com:prakashkukanoor/aws-module-iam-roles-users.git?ref=v1.0.0"
}

inputs = {
  region               = "us-east-1"
  team                 = "devops"
  environment          = "PROD"
  path_to_json_file    = "${get_terragrunt_dir()}/policy.json.tpl"
  bucket_name          = "tf-statefile-prod-networking"
  dynamodb_table_name  = "tf-state-lock-prod-networking"
  public_key_file_path = "/Users/prakashkukanoor/Documents/Prakash/Learning/private-public-keys/public-key-terraform.asc"

  users = [
    { user = "user1", path = "/terraform/networking/admins/users/" },
    { user = "user2", path = "/terraform/networking/admins/users/" },
    { user = "user5", path = "/terraform/networking/non-admins/users/" },
    { user = "user6", path = "/terraform/networking/non-admins/users/" }
  ]
}