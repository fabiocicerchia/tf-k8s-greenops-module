module "prometheus" {
  count  = var.prometheus.enabled ? 1 : 0
  source = "https://github.com/fabiocicerchia/kepler-module.git//modules/prometheus?ref=main"

  kubeconfig_path = var.kubeconfig_path
  release_name    = var.prometheus.release_name
  namespace       = var.prometheus.namespace
  values          = var.prometheus.values
}

module "keda" {
  count  = var.keda.enabled ? 1 : 0
  source = "https://github.com/fabiocicerchia/kepler-module.git//modules/keda?ref=main"

  kubeconfig_path = var.kubeconfig_path
  release_name    = var.keda.release_name
  namespace       = var.keda.namespace
  values          = var.keda.values
  deploy_example  = var.keda.deploy_example
  manifest_path   = var.keda.manifest_path
}

module "opencost" {
  count  = var.opencost.enabled ? 1 : 0
  source = "https://github.com/fabiocicerchia/kepler-module.git//modules/opencost?ref=main"

  kubeconfig_path = var.kubeconfig_path
  release_name    = var.opencost.release_name
  namespace       = var.opencost.namespace
  values          = var.opencost.values
}

module "kepler" {
  count  = var.kepler.enabled ? 1 : 0
  source = "https://github.com/fabiocicerchia/kepler-module.git//modules/kepler?ref=main"

  kubeconfig_path     = var.kubeconfig_path
  release_name        = var.kepler.release_name
  namespace           = var.kepler.namespace
  values              = var.kepler.values
  deploy_powermonitor = var.kepler.deploy_powermonitor
}

module "scaphandre" {
  count  = var.scaphandre.enabled ? 1 : 0
  source = "https://github.com/fabiocicerchia/kepler-module.git//modules/scaphandre?ref=main"

  kubeconfig_path = var.kubeconfig_path
  release_name    = var.scaphandre.release_name
  namespace       = var.scaphandre.namespace
  values          = var.scaphandre.values
}

module "kubegreen" {
  count  = var.kubegreen.enabled ? 1 : 0
  source = "https://github.com/fabiocicerchia/kepler-module.git//modules/kubegreen?ref=main"

  kubeconfig_path = var.kubeconfig_path
  release_name    = var.kubegreen.release_name
  namespace       = var.kubegreen.namespace
  values          = var.kubegreen.values
}
