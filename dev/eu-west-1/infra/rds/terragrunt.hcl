locals {
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  account_name = local.account_vars.locals.account_name
}

terraform {
  source = "${get_repo_root()}/modules/rds"
}

include {
  path = find_in_parent_folders("root.hcl")
}

dependency "vpc" {
  config_path  = "../vpc"
  mock_outputs        = {
    database_subnets = "database_subnets"
    }
}

dependency "security_group" {
  config_path  = "../security-group"
  mock_outputs        = {
    security_group_id = "security_group_id"
    }
}

inputs = {
  identifier = "terragrunt-test-${local.account_name}"
  username = "test"
  db_name = "test"
  engine   = "postgres"
  instance_class     = "db.t3.micro"
  skip_final_snapshot = true
  allocated_storage = 5
  create_db_subnet_group = true
  create_db_parameter_group = false
  db_subnet_group_name  = "terragrunt-test-${local.account_name}"
  vpc_security_group_ids = [dependency.security_group.outputs.security_group_id]
  subnet_ids = dependency.vpc.outputs.database_subnets
  manage_master_user_password = true
  publicly_accessible = false
  Owner = "Yeghish"
}
