locals {
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  account_name = local.account_vars.locals.account_name
}

include "root" {
    path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${get_repo_root()}/modules/vpc"
}

inputs = {
#  name = "terragrunt-test-sss"
  name = "terragrunt-test-${local.account_name}"
  azs  = ["eu-west-1a", "eu-west-1b"]
  cidr = "10.0.0.0/16"
  public_subnets  = ["10.0.11.0/24", "10.0.12.0/24"]
  private_subnets = ["10.0.21.0/24", "10.0.22.0/24"]
  database_subnets = ["10.0.31.0/24", "10.0.32.0/24"]
  enable_nat_gateway = true
  single_nat_gateway = true
  Owner = "Yeghish"
  manage_default_network_acl         = false
  manage_default_security_group      = false
  manage_default_route_table         = false
  create_elasticache_subnet_group    = false
  create_redshift_subnet_group       = false
  create_database_subnet_group       = false
  create_database_subnet_route_table = true
}