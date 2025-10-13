module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "6.12.0"


  identifier                  = var.identifier
  db_name                     = var.db_name
  username                    = var.username
  engine                      = var.engine
  instance_class              = var.instance_class
  skip_final_snapshot         = var.skip_final_snapshot
  allocated_storage           = var.allocated_storage
  create_db_subnet_group      = var.create_db_subnet_group
  create_db_parameter_group   = var.create_db_parameter_group
  db_subnet_group_name        = var.db_subnet_group_name
  vpc_security_group_ids      = var.vpc_security_group_ids
  manage_master_user_password = var.manage_master_user_password
  subnet_ids                  = var.subnet_ids
  publicly_accessible         = var.publicly_accessible
  tags = {
    Owner = var.Owner
  }
}


