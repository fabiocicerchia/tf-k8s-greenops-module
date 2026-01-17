# Scaphandre Module

Terraform module to deploy Scaphandre on your Kubernetes cluster for power consumption and environmental impact monitoring.

## Features

- **Power Consumption Monitoring**: Track energy usage at container level
- **Detailed Metrics**: Fine-grained power consumption data per container
- **Environmental Impact**: Measure CO2 emissions from power usage
- **DaemonSet Deployment**: Runs on all nodes in the cluster
- **Multiple Exporters**: Support for various metric export formats

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| helm | >= 2.0 |
| null | >= 3.0 |

### External Requirements

- [kubectl](https://kubernetes.io/docs/tasks/tools/) - For interacting with your Kubernetes cluster
- [Kubernetes cluster](https://kubernetes.io/docs/setup/) - A running Kubernetes cluster
- [git](https://git-scm.com/) - Required for cloning the Scaphandre repository

## Usage

### Basic Usage

```hcl
module "scaphandre" {
  source = "https://github.com/fabiocicerchia/kepler-module.git//modules/scaphandre?ref=main"

  kubeconfig_path = "~/.kube/config"
  release_name    = "scaphandre"
  namespace       = "scaphandre"
  values          = {}
}
```

### With Custom Values

```hcl
module "scaphandre" {
  source = "https://github.com/fabiocicerchia/kepler-module.git//modules/scaphandre?ref=main"

  namespace = "monitoring"
  values = {
    scaphandre = {
      serviceMonitor = {
        enabled = true
      }
    }
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| kubeconfig_path | Path to the kubeconfig file | `string` | `"~/.kube/config"` | no |
| release_name | Helm release name for Scaphandre | `string` | `"scaphandre"` | no |
| namespace | Kubernetes namespace for Scaphandre | `string` | `"scaphandre"` | no |
| values | Scaphandre Helm chart values | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| namespace | Kubernetes namespace where Scaphandre is deployed |
| release_name | Helm release name of Scaphandre |
| chart_version | Chart version of Scaphandre deployment |

## Notes

- This module requires git to be installed on the system running Terraform
- The repository is cloned to `/tmp/scaphandre` during deployment
- The Helm provider requires access to your Kubernetes cluster via kubeconfig
- Values are passed directly to the Helm chart as HCL objects

## Related Resources

- [Scaphandre Project](https://hubblo-org.github.io/scaphandre/)
- [Scaphandre GitHub Repository](https://github.com/hubblo-org/scaphandre)
- [Scaphandre Helm Charts](https://github.com/hubblo-org/scaphandre/tree/main/helm)
