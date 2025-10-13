terraform {
  source = "${get_repo_root()}/modules/ingress"
}

include {
  path = find_in_parent_folders("root.hcl")
}

dependency "eks" {
  config_path  = "../infra/eks"
  mock_outputs        = {
    cluster_endpoint = "cluster_endpoint"
    cluster_certificate_authority_data = "cluster_certificate_authority_data"
    cluster_name = "cluster_name"
    }
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