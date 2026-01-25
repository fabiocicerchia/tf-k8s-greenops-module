module "prometheus" {
  count  = var.prometheus.enabled ? 1 : 0
  source = "fabiocicerchia/prometheus-stack/helm"

  providers = {
    helm = helm
  }

  release_name  = var.prometheus.release_name
  namespace     = var.prometheus.namespace
  values        = var.prometheus.values
  chart_version = var.prometheus.chart_version
}

module "keda" {
  count  = var.keda.enabled ? 1 : 0
  source = "fabiocicerchia/keda/helm"

  providers = {
    helm = helm
  }

  release_name   = var.keda.release_name
  namespace      = var.keda.namespace
  values         = var.keda.values
  deploy_example = var.keda.deploy_example
  manifest_path  = var.keda.manifest_path
  chart_version  = var.keda.chart_version
}

module "opencost" {
  count  = var.opencost.enabled ? 1 : 0
  source = "fabiocicerchia/opencost/helm"

  providers = {
    helm = helm
  }

  release_name  = var.opencost.release_name
  namespace     = var.opencost.namespace
  chart_version = var.opencost.chart_version
  values        = var.opencost.values
}

module "kepler" {
  count  = var.kepler.enabled ? 1 : 0
  source = "fabiocicerchia/kepler/helm"

  providers = {
    helm = helm
  }

  release_name        = var.kepler.release_name
  namespace           = var.kepler.namespace
  values              = var.kepler.values
  chart_version       = var.kepler.chart_version
  deploy_powermonitor = var.kepler.deploy_powermonitor
}

module "scaphandre" {
  count  = var.scaphandre.enabled ? 1 : 0
  source = "fabiocicerchia/scaphandre/helm"

  providers = {
    helm = helm
  }

  release_name  = var.scaphandre.release_name
  namespace     = var.scaphandre.namespace
  chart_version = var.scaphandre.chart_version
  values        = var.scaphandre.values
}

module "kubegreen" {
  count  = var.kubegreen.enabled ? 1 : 0
  source = "fabiocicerchia/kubegreen/helm"

  providers = {
    helm = helm
  }

  release_name  = var.kubegreen.release_name
  chart_version = var.kubegreen.chart_version
  namespace     = var.kubegreen.namespace
  values        = var.kubegreen.values
}

module "carbon_intensity_exporter" {
  count  = var.carbon_intensity_exporter.enabled ? 1 : 0
  source = "fabiocicerchia/carbon-intensity-exporter/helm"

  providers = {
    helm = helm
  }

  release_name  = var.carbon_intensity_exporter.release_name
  namespace     = var.carbon_intensity_exporter.namespace
  chart_version = var.carbon_intensity_exporter.chart_version
  values        = var.carbon_intensity_exporter.values
}

module "cloud_carbon_footprint" {
  count  = var.cloud_carbon_footprint.enabled ? 1 : 0
  source = "fabiocicerchia/cloud-carbon-footprint/helm"

  providers = {
    helm = helm
  }

  release_name  = var.cloud_carbon_footprint.release_name
  namespace     = var.cloud_carbon_footprint.namespace
  chart_version = var.cloud_carbon_footprint.chart_version
  values        = var.cloud_carbon_footprint.values
}

module "green_metrics_tool" {
  count  = var.green_metrics_tool.enabled ? 1 : 0
  # source = "fabiocicerchia/green-metrics-tool/helm"
  source = "../terraform-helm-green-metrics-tool"

  providers = {
    helm = helm
  }

  # release_name  = var.green_metrics_tool.release_name
  namespace     = var.green_metrics_tool.namespace
  # chart_version = var.green_metrics_tool.chart_version
  # values        = var.green_metrics_tool.values
  postgres_password = var.green_metrics_tool.postgres_password
}

module "codecarbon" {
  count  = var.codecarbon.enabled ? 1 : 0
  source = "../terraform-kubernetes-codecarbon"

  providers = {
    kubectl = kubectl
  }

  name            = var.codecarbon.name
  namespace       = var.codecarbon.namespace
  image           = var.codecarbon.image
  api_endpoint    = var.codecarbon.api_endpoint
  organization_id = var.codecarbon.organization_id
  project_id      = var.codecarbon.project_id
  experiment_id   = var.codecarbon.experiment_id
  api_key         = var.codecarbon.api_key
}
