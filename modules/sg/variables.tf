variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "Owner" {}

variable "ingress_with_cidr_blocks" {
  type = list(map(string))
}
