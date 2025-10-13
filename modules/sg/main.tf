module "db_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.2.0"

  name   = var.name
  vpc_id = var.vpc_id

  ingress_with_cidr_blocks = var.ingress_with_cidr_blocks

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
      description = "Allow all outbound"
    }
  ]
  tags = {
    Owner = var.Owner
  }
}
