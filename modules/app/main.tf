resource "kubectl_manifest" "app" {
  yaml_body = var.yaml_file
}
