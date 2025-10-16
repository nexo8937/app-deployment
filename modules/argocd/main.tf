resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = var.namespace
  version          = "7.6.10"
  create_namespace = var.create_namespace
  values           = var.values


  #  values = [file("${path.module}/values.yaml")]
}
