module "greenops" {
  source = "./modules/greenops"

  kubeconfig_path = var.kubeconfig_path

  prometheus = {
    enabled      = var.prometheus.enabled
    release_name = var.prometheus.release_name
    namespace    = var.prometheus.namespace
    values       = var.prometheus.values
  }

  keda = {
    enabled        = var.keda.enabled
    release_name   = var.keda.release_name
    namespace      = var.keda.namespace
    values         = {}
    deploy_example = var.keda.deploy_example
    manifest_path  = var.keda.manifest_path
  }

  opencost = {
    enabled      = var.opencost.enabled
    release_name = var.opencost.release_name
    namespace    = var.opencost.namespace
    values       = var.opencost.values
  }

  kepler = {
    enabled             = var.kepler.enabled
    release_name        = var.kepler.release_name
    namespace           = var.kepler.namespace
    values              = var.kepler.values
    deploy_powermonitor = var.kepler.deploy_powermonitor
  }

  scaphandre = {
    enabled      = var.scaphandre.enabled
    release_name = var.scaphandre.release_name
    namespace    = var.scaphandre.namespace
    values       = var.scaphandre.values
  }
}

resource "null_resource" "deploy_demo_app" {
  count = var.deploy_demo_app ? 1 : 0

  provisioner "local-exec" {
    command = "kubectl apply -f https://raw.githubusercontent.com/GoogleCloudPlatform/microservices-demo/refs/heads/main/release/kubernetes-manifests.yaml"
  }

  depends_on = [module.greenops]
}
