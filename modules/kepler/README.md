# Kepler Operator Module

Terraform module to deploy the Kepler Operator on your Kubernetes cluster for monitoring and tracking the environmental impact and power consumption.

## Features

- **Power Consumption Monitoring**: Track energy usage across your cluster
- **Environmental Impact Tracking**: Measure CO2 emissions from your workloads
- **Cert Manager**: Automatic certificate management for cluster operations
- **PowerMonitor Resources**: Optional deployment of PowerMonitor custom resources
- **ServiceMonitor Integration**: Automatic Prometheus metrics collection

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| helm | >= 2.0 |
| null | >= 3.0 |

### External Requirements

- [kubectl](https://kubernetes.io/docs/tasks/tools/) - For interacting with your Kubernetes cluster
- [Kubernetes cluster](https://kubernetes.io/docs/setup/) - A running Kubernetes cluster

## Usage

### Basic Usage

```hcl
module "kepler" {
  source = "https://github.com/fabiocicerchia/kepler-module.git//modules/kepler?ref=main"

  kubeconfig_path = "~/.kube/config"
  release_name    = "kepler-operator"
  namespace       = "kepler-operator"
  values          = {}
}
```

### Without PowerMonitor Deployment

```hcl
module "kepler" {
  source = "https://github.com/fabiocicerchia/kepler-module.git//modules/kepler?ref=main"

  deploy_powermonitor = false
}
```

### With Custom Namespace and Values

```hcl
module "kepler" {
  source = "https://github.com/fabiocicerchia/kepler-module.git//modules/kepler?ref=main"

  namespace = "custom-kepler"
  values = {
    serviceMonitor = {
      enabled = true
    }
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| kubeconfig_path | Path to the kubeconfig file | `string` | `"~/.kube/config"` | no |
| release_name | Helm release name for Kepler Operator | `string` | `"kepler-operator"` | no |
| namespace | Kubernetes namespace for Kepler Operator | `string` | `"kepler-operator"` | no |
| values | Kepler Helm chart values | `any` | `{}` | no |
| deploy_powermonitor | Deploy the Kepler PowerMonitor resource | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| chart_version | Chart version of Kepler Operator deployment |
| namespace | Kubernetes namespace where Kepler Operator is deployed |
| release_name | Helm release name of Kepler Operator |

## Notes

- The Helm provider requires access to your Kubernetes cluster via kubeconfig
- Cert Manager is automatically deployed as a dependency
- Values are passed directly to the Helm chart as HCL objects
- PowerMonitor resources require the Kepler CRDs to be installed first

## Related Resources

- [Kepler Project](https://sustainable-computing.io/)
- [Kepler GitHub Repository](https://github.com/sustainable-computing-io/kepler)
- [Kepler Helm Charts](https://github.com/sustainable-computing-io/kepler)

