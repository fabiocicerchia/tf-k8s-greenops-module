# Prometheus Module

Terraform module to deploy the Prometheus monitoring stack on Kubernetes using Helm.

## Features

- **Kube Prometheus Stack**: Complete Prometheus, Grafana, and Alertmanager setup
- **Metrics Collection**: Automatic scraping of Kubernetes metrics
- **Grafana Dashboards**: Pre-configured dashboards for cluster monitoring
- **ServiceMonitor Integration**: Automatic service discovery for metrics scraping

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| helm | >= 2.0 |

### External Requirements

- [kubectl](https://kubernetes.io/docs/tasks/tools/) - For interacting with your Kubernetes cluster
- [Kubernetes cluster](https://kubernetes.io/docs/setup/) - A running Kubernetes cluster

## Usage

### Basic Usage

```hcl
module "prometheus" {
  source = "https://github.com/fabiocicerchia/kepler-module.git//modules/prometheus?ref=main"

  kubeconfig_path = "~/.kube/config"
  release_name    = "prometheus-community"
  namespace       = "monitoring"
  values          = {}
}
```

### With Custom Values

```hcl
module "prometheus" {
  source = "https://github.com/fabiocicerchia/kepler-module.git//modules/prometheus?ref=main"

  kubeconfig_path = "~/.kube/config"
  namespace       = "custom-monitoring"
  values = {
    prometheus = {
      prometheusSpec = {
        retention = "30d"
      }
    }
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| kubeconfig_path | Path to the kubeconfig file | `string` | `"~/.kube/config"` | no |
| release_name | Helm release name for Prometheus | `string` | `"prometheus-community"` | no |
| namespace | Kubernetes namespace for Prometheus | `string` | `"monitoring"` | no |
| values | Prometheus Helm chart values | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| chart_version | Chart version of Prometheus deployment |
| namespace | Kubernetes namespace where Prometheus is deployed |
| release_name | Helm release name of Prometheus |

## Notes

- The Helm provider requires access to your Kubernetes cluster via kubeconfig
- Values are passed directly to the Helm chart as HCL objects

## Related Resources

- [Prometheus Operator](https://prometheus-operator.dev/)
- [Kube Prometheus Stack](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack)
