variable "name" {}

variable "kubernetes_version" {}

variable "endpoint_public_access" {
  type = bool
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "Owner" {}

variable "eks_managed_node_groups" {
  type = map(any)
}

variable "addons" {
  type = map(any)
}
