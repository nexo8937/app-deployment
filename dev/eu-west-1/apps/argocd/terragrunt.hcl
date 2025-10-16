terraform {
  source = "${get_repo_root()}/modules/argocd"
}

include {
  path = find_in_parent_folders("root.hcl")
}


inputs = {
  namespace  = "argocd"
  create_namespace = true
  values     = [file("values.yaml")]
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