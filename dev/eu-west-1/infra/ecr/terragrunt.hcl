locals {
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  account_name = local.account_vars.locals.account_name
  aws_region   = local.region_vars.locals.aws_region
}

include "root" {
    path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${get_repo_root()}/modules/ecr"
}

inputs = {
  repo_name = "terragrunt-test-${local.account_name}"
  Owner     = "Yeghish"
  region    = local.aws_region
  repository_force_delete = true
  repository_image_tag_mutability = "MUTABLE"

  repository_lifecycle_policy = {
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 30 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  }
}