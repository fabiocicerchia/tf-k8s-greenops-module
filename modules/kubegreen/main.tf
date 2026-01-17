terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.0"
    }
  }
}

provider "helm" {
  kubernetes {
    config_path = var.kubeconfig_path
  }
}

# Deploy KubeGreen using Helm
resource "helm_release" "kubegreen" {
  name             = var.release_name
  namespace        = var.namespace
  create_namespace = true

  repository = "https://kube-green.github.io/helm-charts/"
  chart      = "kube-green"

  values = [
    yamlencode(var.values)
  ]
}
