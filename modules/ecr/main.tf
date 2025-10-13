module "ecr" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "3.0.1"

  repository_name                 = var.repo_name
  region                          = var.region
  repository_lifecycle_policy     = var.repository_lifecycle_policy
  repository_force_delete         = var.repository_force_delete
  repository_image_tag_mutability = var.repository_image_tag_mutability

  tags = {
    Owner = var.Owner
  }
}
