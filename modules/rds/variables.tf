variable "identifier" {
  type = string
}

variable "db_name" {
  type = string
}

variable "username" {
  type = string
}

variable "engine" {
  type = string
}

variable "instance_class" {
  type = string
}

variable "skip_final_snapshot" {
  type    = bool
  default = true
}

variable "allocated_storage" {
  type = number
}

variable "create_db_subnet_group" {
  type    = bool
  default = true
}

variable "create_db_parameter_group" {
  type    = bool
  default = true
}

variable "db_subnet_group_name" {
  type    = string
  default = null
}

variable "vpc_security_group_ids" {
  type = list(string)
}

variable "subnet_ids" {
  type = list(string)
}

variable "publicly_accessible" {
  type    = bool
  default = false
}

variable "manage_master_user_password" {
  type    = bool
  default = false
}

variable "Owner" {}
