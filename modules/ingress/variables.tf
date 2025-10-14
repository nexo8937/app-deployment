variable "additional_set" {
  description = "Additional Helm values to set for nginx-controller"
  type = list(object({
    name  = string
    value = string
    type  = string
  }))
  default = []
}
