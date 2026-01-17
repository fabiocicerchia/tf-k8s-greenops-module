output "prometheus" {
  description = "Prometheus module outputs"
  value = var.prometheus.enabled ? {
    namespace    = module.prometheus[0].namespace
    release_name = module.prometheus[0].release_name
    version      = module.prometheus[0].chart_version
  } : null
}

output "keda" {
  description = "KEDA module outputs"
  value = var.keda.enabled ? {
    namespace    = module.keda[0].namespace
    release_name = module.keda[0].release_name
    version      = module.keda[0].chart_version
  } : null
}

output "opencost" {
  description = "OpenCost module outputs"
  value = var.opencost.enabled ? {
    namespace    = module.opencost[0].namespace
    release_name = module.opencost[0].release_name
    version      = module.opencost[0].chart_version
  } : null
}

output "kepler" {
  description = "Kepler module outputs"
  value = var.kepler.enabled ? {
    namespace    = module.kepler[0].namespace
    release_name = module.kepler[0].release_name
    version      = module.kepler[0].chart_version
  } : null
}

output "scaphandre" {
  description = "Scaphandre module outputs"
  value = var.scaphandre.enabled ? {
    namespace    = module.scaphandre[0].namespace
    release_name = module.scaphandre[0].release_name
    version      = module.scaphandre[0].chart_version
  } : null
}

output "deployed_components" {
  description = "List of deployed components"
  value = {
    prometheus = var.prometheus.enabled
    keda       = var.keda.enabled
    opencost   = var.opencost.enabled
    kepler     = var.kepler.enabled
    scaphandre = var.scaphandre.enabled
  }
}
