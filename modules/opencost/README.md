# OpenCost Module

Terraform module to deploy OpenCost on your Kubernetes cluster for cost monitoring and allocation. This module is part of the [tf-k8s-greenops-module](https://github.com/fabiocicerchia/tf-k8s-greenops-module) for comprehensive Kubernetes monitoring and sustainability tracking.

## Overview

OpenCost provides cost allocation and visibility into your Kubernetes spending, integrated with carbon tracking to measure environmental impact alongside financial costs.

- **Cost Monitoring**: Track and allocate cloud resource costs within your Kubernetes cluster
- **Multi-Cloud Support**: Works with AWS, Azure, GCP, and on-premises clusters
- **Resource Allocation**: Detailed cost breakdown by namespace, pod, and label
- **Carbon Cost Tracking**: Integrated carbon footprint measurement

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
module "opencost" {
  source = "https://github.com/fabiocicerchia/tf-k8s-greenops-module.git//modules/opencost?ref=main"

  kubeconfig_path = "~/.kube/config"
  release_name    = "opencost-charts"
  namespace       = "opencost"
  values          = {}
}
```

### With Custom Namespace and Values

```hcl
module "opencost" {
  source = "https://github.com/fabiocicerchia/tf-k8s-greenops-module.git//modules/opencost?ref=main"

  namespace = "cost-monitoring"
  values = {
    opencost = {
      prometheus = {
        internal = {
          serviceName = "prometheus-kube-prometheus-prometheus"
          port        = 9090
        }
      }
    }
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| kubeconfig_path | Path to the kubeconfig file | `string` | `"~/.kube/config"` | no |
| release_name | Helm release name for OpenCost | `string` | `"opencost-charts"` | no |
| namespace | Kubernetes namespace for OpenCost | `string` | `"opencost"` | no |
| values | OpenCost Helm chart values | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| chart_version | Chart version of OpenCost deployment |
| namespace | Kubernetes namespace where OpenCost is deployed |
| release_name | Helm release name of OpenCost |

## Notes

- The Helm provider requires access to your Kubernetes cluster via kubeconfig
- Values are passed directly to the Helm chart as HCL objects
- Ensure Prometheus is deployed before OpenCost for cost metrics integration

## Related Resources

- [OpenCost Project](https://www.opencost.io/)
- [OpenCost GitHub Repository](https://github.com/opencost/opencost)
- [OpenCost Helm Charts](https://github.com/opencost/opencost-helm-chart)
