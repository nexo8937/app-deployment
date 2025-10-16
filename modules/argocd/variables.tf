variable "namespace" {
  type = string
}

variable "values" {
  type    = list(string)
  default = []
}

variable "create_namespace" {
  type = bool
}
