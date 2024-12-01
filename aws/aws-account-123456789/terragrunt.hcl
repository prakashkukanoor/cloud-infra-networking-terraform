locals {
  bucket_name         = "parent-specific-2-bucket"
  dynamodb_table_name = "parent-dynamodb-2-table"
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket         = local.bucket_name
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = local.dynamodb_table_name
  }
}