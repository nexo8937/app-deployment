terraform {
  source = "${get_repo_root()}/modules/app"
}

include {
  path = find_in_parent_folders("root.hcl")
}


inputs = {
  yaml_file     = file("app.yaml")
}

generate "provider_kubectl" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.14.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}

data "aws_eks_cluster_auth" "cluster" {
  name = "${dependency.eks.outputs.cluster_name}"
}

provider "kubectl" {
  host                   = "${dependency.eks.outputs.cluster_endpoint}"
  cluster_ca_certificate = base64decode("${dependency.eks.outputs.cluster_certificate_authority_data}")
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
}
EOF
}

dependency "eks" {
  config_path = "../../infra/eks"
  mock_outputs = {
    cluster_endpoint                   = "cluster_endpoint"
    cluster_certificate_authority_data = "cluster_certificate_authority_data"
    cluster_name                       = "cluster_name"
  }
}

dependency "ingress" {
   config_path = "../argocd" 
   skip_outputs = true
}