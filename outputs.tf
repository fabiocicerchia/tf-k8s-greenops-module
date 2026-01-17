output "prometheus" {
  description = "Prometheus module outputs"
  value = {
    namespace    = module.greenops.prometheus.namespace
    release_name = module.greenops.prometheus.release_name
    version      = module.greenops.prometheus.version
  }
}

output "keda" {
  description = "KEDA module outputs"
  value = {
    namespace    = module.greenops.keda.namespace
    release_name = module.greenops.keda.release_name
    version      = module.greenops.keda.version
  }
}

output "opencost" {
  description = "OpenCost module outputs"
  value = {
    namespace    = module.greenops.opencost.namespace
    release_name = module.greenops.opencost.release_name
    version      = module.greenops.opencost.version
  }
}

output "kepler" {
  description = "Kepler module outputs"
  value = {
    namespace    = module.greenops.kepler.namespace
    release_name = module.greenops.kepler.release_name
    version      = module.greenops.kepler.version
  }
}

output "scaphandre" {
  description = "Scaphandre module outputs"
  value = module.greenops.scaphandre == null ? null : {
    namespace    = module.greenops.scaphandre.namespace
    release_name = module.greenops.scaphandre.release_name
    version      = module.greenops.scaphandre.version
  }
}
  description = "Map of deployed components and their status"
  value       = module.greenops.deployed_components
}

output "demo_app_deployed" {
  description = "Whether the demo application was deployed"
  value       = var.deploy_demo_app
}
