locals {
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  account_name = local.account_vars.locals.account_name
  account_id   = local.account_vars.locals.aws_account_id
  aws_region   = local.region_vars.locals.aws_region
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = "${local.aws_region}"

  allowed_account_ids = ["${local.account_id}"]
}
EOF
}

remote_state {
  backend = "s3"
  config = {
    encrypt        = true
    bucket         = "terragrunt-state-${local.account_id}-${local.account_name}"
    key            = "terragrunt/${path_relative_to_include()}/tf.tfstate"
    region         = local.aws_region
    dynamodb_table = "terragrunt-lock-${local.account_name}"
  }
  generate = {
    path      = "_backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}
