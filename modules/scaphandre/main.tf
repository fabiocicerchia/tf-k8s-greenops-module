terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.0"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.0"
    }
  }
}

provider "helm" {
  kubernetes {
    config_path = var.kubeconfig_path
  }
}

# Deploy Scaphandre using Helm
resource "helm_release" "scaphandre" {
  name             = var.release_name
  namespace        = var.namespace
  create_namespace = true

  chart = "https://github.com/hubblo-org/scaphandre"

  values = [
    yamlencode(var.values)
  ]
}
