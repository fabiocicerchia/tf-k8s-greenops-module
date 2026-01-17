# KubeGreen Module

Terraform module to deploy KubeGreen on your Kubernetes cluster for automated resource cleanup and optimization. This module is part of the [tf-k8s-greenops-module](https://github.com/fabiocicerchia/tf-k8s-greenops-module) for comprehensive Kubernetes monitoring and sustainability tracking.

## Overview

KubeGreen automatically manages workload schedules to reduce resource consumption during off-hours, directly lowering both costs and environmental impact.

- **Automatic Resource Cleanup**: Remove unused resources automatically
- **Pod Hibernation**: Sleep pods during off-hours to save resources
- **Cost Optimization**: Reduce cloud spending by optimizing resource usage
- **Namespace Isolation**: Configure cleanup policies per namespace
- **Schedule-Based Execution**: Define when cleanup should occur

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
module "kubegreen" {
  source = "https://github.com/fabiocicerchia/tf-k8s-greenops-module.git//modules/kubegreen?ref=main"

  kubeconfig_path = "~/.kube/config"
  release_name    = "kube-green"
  namespace       = "kube-green"
  values          = {}
}
```

### With Custom Configuration

```hcl
module "kubegreen" {
  source = "https://github.com/fabiocicerchia/tf-k8s-greenops-module.git//modules/kubegreen?ref=main"

  namespace = "kube-system"
  values = {
    kubeGreen = {
      sleepSchedule = {
        cron = "0 22 * * 0-4"
        suspendCronJob = true
        suspendDeployments = true
      }
    }
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| kubeconfig_path | Path to the kubeconfig file | `string` | `"~/.kube/config"` | no |
| release_name | Helm release name for KubeGreen | `string` | `"kube-green"` | no |
| namespace | Kubernetes namespace for KubeGreen | `string` | `"kube-green"` | no |
| values | KubeGreen Helm chart values | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| namespace | Kubernetes namespace where KubeGreen is deployed |
| release_name | Helm release name of KubeGreen |
| chart_version | Chart version of KubeGreen deployment |

## Notes

- The Helm provider requires access to your Kubernetes cluster via kubeconfig
- Values are passed directly to the Helm chart as HCL objects
- KubeGreen operates cluster-wide once installed
- Requires appropriate RBAC permissions for resource cleanup

## Related Resources

- [KubeGreen Project](https://kube-green.github.io/)
- [KubeGreen GitHub Repository](https://github.com/kube-green/kube-green)
- [KubeGreen Helm Charts](https://github.com/kube-green/helm-charts)
