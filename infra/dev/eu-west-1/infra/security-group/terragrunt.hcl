locals {
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  account_name = local.account_vars.locals.account_name
}

terraform {
  source = "${get_repo_root()}/modules/sg"
}

include {
  path = find_in_parent_folders("root.hcl")
}

dependency "vpc" {
  config_path  = "../vpc"
  mock_outputs        = {
    vpc_id = "vpc-id"
    }
}

inputs = {
  name        = "terragrunt-test-${local.account_name}"
  vpc_id      = dependency.vpc.outputs.vpc_id 
  
  ingress_with_cidr_blocks = [
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_blocks = "10.0.0.0/16"
      description = "Allow PostgreSQL from internal network"
    }
  ]

  Owner       = "Yeghish"
}  