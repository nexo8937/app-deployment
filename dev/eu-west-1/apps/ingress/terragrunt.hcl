terraform {
  source = "${get_repo_root()}/modules/ingress"
}

include {
  path = find_in_parent_folders("root.hcl")
}


inputs = {
    additional_set = [
      {
        name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"
        value = "nlb"
        type  = "string"
      },
      {
        name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-cross-zone-load-balancing-enabled"
        value = "true"
        type  = "string"
      }
    ]
}

generate "provider_helm" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "helm" {
  kubernetes = {
    # Use Terragrunt interpolation (with $) to substitute the value BEFORE writing to provider.tf
    host                   = "${dependency.eks.outputs.cluster_endpoint}"
    cluster_ca_certificate = base64decode("${dependency.eks.outputs.cluster_certificate_authority_data}")
    exec = {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", "${dependency.eks.outputs.cluster_name}"]
      command     = "aws"
    }
  }
}
EOF
}

dependency "eks" {
  config_path = "../../infra/eks"
  mock_outputs = {
    cluster_endpoint                 = "cluster_endpoint"
    cluster_certificate_authority_data = "cluster_certificate_authority_data"
    cluster_name                     = "cluster_name"
  }
}
#generate "provider_helm" {
#  path      = "provider.tf"
#  if_exists = "overwrite"
#  contents  = <<EOF
#provider "helm" {
#  kubernetes = {
#    host                   = dependency.eks.outputs.cluster_endpoint
#    cluster_ca_certificate = base64decode(dependency.eks.outputs.cluster_certificate_authority_data)
#    exec = {
#      api_version = "client.authentication.k8s.io/v1beta1"
#      args        = ["eks", "get-token", "--cluster-name", dependency.eks.outputs.cluster_name]
#      command     = "aws"
#    }
#  }
# }
#  EOF
#}
#
#dependency "eks" {
#  config_path = "../../infra/eks"
#  mock_outputs = {
#    cluster_endpoint                   = "cluster_endpoint"
#    cluster_certificate_authority_data = "cluster_certificate_authority_data"
#    cluster_name                       = "cluster_name"
#  }
#}