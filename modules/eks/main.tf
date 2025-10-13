module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name                                     = var.name
  kubernetes_version                       = var.kubernetes_version
  addons                                   = var.addons
  endpoint_public_access                   = var.endpoint_public_access
  enable_cluster_creator_admin_permissions = true
  vpc_id                                   = var.vpc_id
  subnet_ids                               = var.subnet_ids
  eks_managed_node_groups                  = var.eks_managed_node_groups

  tags = {
    Owner = var.Owner
  }
}
