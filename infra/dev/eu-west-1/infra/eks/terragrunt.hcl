locals {
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  account_name = local.account_vars.locals.account_name
}

include "root" {
    path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${get_repo_root()}/modules/eks"
}

dependency "vpc" {
  config_path  = "../vpc"
  mock_outputs        = {
    vpc_id = "vpc_id"
    private_subnets = ["subnet-123", "subnet-456"]
    }
}

inputs = {
  name = "terragrunt-test-${local.account_name}"
  kubernetes_version = "1.33"
  endpoint_public_access = true
  vpc_id = dependency.vpc.outputs.vpc_id
  subnet_ids = dependency.vpc.outputs.private_subnets
  Owner     = "Yeghish"

  addons = {
    coredns = {}
    kube-proxy = {}
    vpc-cni = {
      before_compute = true
    }
  }

  eks_managed_node_groups = {
    node-group = {
      ami_type = "AL2023_x86_64_STANDARD"

      instance_types = ["t3.medium"]

      desired_size = 1
      max_size = 2
      min_size =1
    }
  }

}