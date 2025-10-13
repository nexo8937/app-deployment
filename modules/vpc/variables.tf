variable "name" {}

variable "azs" {
  type = list(string)
}

variable "cidr" {}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "database_subnets" {
  type = list(string)
}

variable "enable_nat_gateway" {
  type = bool
}

variable "single_nat_gateway" {
  type = bool
}

variable "Owner" {}

variable "manage_default_network_acl" {
  type = bool
}

variable "manage_default_security_group" {
  type = bool
}

variable "manage_default_route_table" {
  type = bool
}

variable "create_elasticache_subnet_group" {
  type = bool
}

variable "create_redshift_subnet_group" {
  type = bool
}

variable "create_database_subnet_group" {
  type = bool
}

variable "create_database_subnet_route_table" {
  type = bool
}
